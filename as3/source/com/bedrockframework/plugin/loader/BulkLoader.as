package com.bedrockframework.plugin.loader
{
	import com.bedrockframework.plugin.event.BulkLoaderEvent;
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.storage.SuperArray;
	import com.bedrockframework.plugin.util.MathUtil;

	public class BulkLoader extends MultiLoader
	{
		/*
		Variable Delarations
		*/
		public static var PRIORITY:String = "priority";
		public static var ORDER:String = "order";
		
		private var _bolRunning:Boolean;
		private var _bolComplete:Boolean;
		private var _bolAddWhileRunning:Boolean;
		private var _arrQueue:Array;
		private var _arrCurrentLoad:Array;
		private var _numMaxConcurrentLoads:uint;
		private var _numLoadIndex:uint;
		private var _numTotalFiles:uint;
		private var _numCompletedFiles:uint;
		private var _numOverallPercentage:uint;
		private var _numTotalPercentage:uint;
		private var _numLoadedPercentage:uint;
		private var _strSortBy:String;
		
		private var _objQueueBrowser:SuperArray;
		/*
		Constructor
		*/
		public function BulkLoader()
		{
			this._arrQueue=new Array  ;
			this._arrCurrentLoad = new Array();
			this._numLoadIndex=0;
			this._numMaxConcurrentLoads = 2;
			this._objQueueBrowser = new SuperArray();
			this._bolRunning=false;
			this._bolComplete=false;
			this._strSortBy = BulkLoader.PRIORITY;
		}
		/*
		Reset
		*/
		public function reset():void
		{
			this._arrQueue=new Array();
			this._arrCurrentLoad = new Array();
			this._objQueueBrowser.data = this._arrQueue;
			this._numLoadIndex=0;
			this._numCompletedFiles = 0;
			this._bolRunning=false;
			this._bolComplete=false;
			this._numOverallPercentage = 0;
			this._numTotalPercentage = 0;
			this.status("Reset");
			this.dispatchEvent( new BulkLoaderEvent( BulkLoaderEvent.RESET, this ) );
		}
		public function close():void
		{
			if (this._arrQueue.length > 0) {
				var numLength:uint = this._arrCurrentLoad.length;
				var objQueueItem:*
				for (var i:int = 0; i < numLength; i++) {
					objQueueItem = this._arrCurrentLoad[i];
					
					try {
						objQueueItem.close();
					} catch ($error:Error) {}
					
					this.removeListeners(objQueueItem);
				}
				
				this.reset();
				this.status("Close");
				this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.CLOSE,this));
			}
		}
		public function loadQueue():void
		{
			if (this._arrQueue.length > 0) {
				this._objQueueBrowser.data = this._arrQueue;
				this.reorder();
				this.recalculate();
				this.begin();
			} else {
				this.warning("Unable to load, queue is empty!");
				this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.ERROR,this, {text:"Unable to load, queue is empty!"}));
			}
		}
		public function addToQueue($file:String, $loader:*=null, $priority:uint=0, $alias:String=null, $completeHandler:Function=null, $errorHandler:Function=null):void
		{
			if ($loader !=null && !( $loader is DataLoader || $loader is VisualLoader ) ) {
				this.error( "Loader must be an instance of DataLoader or VisualLoader!" );
			} else {
				if (this._bolComplete) {
					this.reset();
				}
				if (!this._bolRunning) {
					this.add($file, $loader, $priority, $alias, $completeHandler, $errorHandler);
				}else if (this._bolAddWhileRunning && this._bolRunning){
					this.add($file, $loader, $priority, $alias, $completeHandler, $errorHandler);
					if (this._arrCurrentLoad.length < this._numMaxConcurrentLoads) {
						this.loadNext();
					}
				} else {			
					this.warning("Cannot add to queue while loading!");
				}		
			}
		}
		private function add($file:String, $loader:* = null, $priority:uint=0, $alias:String=null, $completeHandler:Function=null, $errorHandler:Function=null):void
		{
			var strFile:String=$file;
			var objLoader:* =$loader || new DataLoader;
			if ($completeHandler != null) {
				if (objLoader is DataLoader) {
					objLoader.addEventListener(LoaderEvent.COMPLETE,$completeHandler,false,0,true);
				} else {
					objLoader.addEventListener(LoaderEvent.INIT,$completeHandler,false,0,true);
				}				
			}
			if ($errorHandler != null) {
				objLoader.addEventListener( LoaderEvent.IO_ERROR, $errorHandler, false, 0, true);
				objLoader.addEventListener(LoaderEvent.SECURITY_ERROR,$errorHandler,false,0,true);				
			}
			this._arrQueue.unshift( { file:strFile, loader:objLoader, priority:$priority, order:this._arrQueue.length, alias:$alias, percent:0});
			this.recalculate();
			this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.FILE_ADDED,this,{files:this._arrQueue,index:this._numLoadIndex,total:this._numTotalFiles}));
		}
		/*
		Current Load Managment
		*/
		private function addToCurrentLoad($loader:*):void
		{
			this._arrCurrentLoad.push($loader);
		}
		private function removeFromCurrentLoad($loader:*):void
		{
			var objBrowser:SuperArray = new SuperArray(this._arrCurrentLoad);
			objBrowser.remove(objBrowser.findIndex($loader));
		}
		/*
		Listener Managment
		*/
		private function addListeners($target:*):void
		{
			$target.addEventListener(LoaderEvent.COMPLETE,this.dispatchEvent);
			$target.addEventListener(LoaderEvent.OPEN,this.dispatchEvent);
			$target.addEventListener(LoaderEvent.INIT,this.dispatchEvent);
			$target.addEventListener(LoaderEvent.UNLOAD,this.dispatchEvent);
			$target.addEventListener(LoaderEvent.HTTP_STATUS,this.dispatchEvent);
			$target.addEventListener(LoaderEvent.IO_ERROR,this.dispatchEvent);
			$target.addEventListener(LoaderEvent.SECURITY_ERROR,this.dispatchEvent);

			$target.addEventListener(LoaderEvent.PROGRESS,this.onProgress);
			$target.addEventListener(LoaderEvent.IO_ERROR,this.onFileError);

			var strType:String = ($target is DataLoader) ? LoaderEvent.COMPLETE : LoaderEvent.INIT;
			$target.addEventListener(strType, this.onFileComplete);
		}
		private function removeListeners($target:*):void
		{
			$target.removeEventListener(LoaderEvent.COMPLETE,this.dispatchEvent);
			$target.removeEventListener(LoaderEvent.OPEN,this.dispatchEvent);
			$target.removeEventListener(LoaderEvent.INIT,this.dispatchEvent);
			$target.removeEventListener(LoaderEvent.UNLOAD,this.dispatchEvent);
			$target.removeEventListener(LoaderEvent.HTTP_STATUS,this.dispatchEvent);
			$target.removeEventListener(LoaderEvent.IO_ERROR,this.dispatchEvent);
			$target.removeEventListener(LoaderEvent.SECURITY_ERROR,this.dispatchEvent);

			$target.removeEventListener(LoaderEvent.PROGRESS,this.onProgress);
			$target.removeEventListener(LoaderEvent.IO_ERROR,this.onFileError);

			var strType:String = ($target is DataLoader) ? LoaderEvent.COMPLETE : LoaderEvent.INIT;
			$target.removeEventListener(strType, this.onFileComplete);
		}
		/*
		Calculate Percentage
		*/
		private function recalculate():void
		{
			this._numTotalFiles=this._arrQueue.length;
			this._numTotalPercentage=this._numTotalFiles * 100;
		}
		private function reorder():void
		{
			this._arrQueue.sortOn([this._strSortBy], Array.NUMERIC | Array.DESCENDING);
		}
		private function calculateOverallPercentage():uint
		{
			this._numLoadedPercentage = 0;
			var numLength:uint = this._arrQueue.length;
			for (var i:int = 0 ; i < numLength; i ++) {
				this._numLoadedPercentage += this._arrQueue[i].percent;
			}			
			this._numOverallPercentage=MathUtil.calculatePercentage(this._numLoadedPercentage,this._numTotalPercentage);
			return this._numOverallPercentage;
		}
		/*
		Begin Downloading Queued Files
		*/
		private function begin():void
		{
			if (!this._bolRunning) {
				this._bolRunning=true;
				this.status("Begin Load");
				var numLength:int = (this._numTotalFiles >= this._numMaxConcurrentLoads) ? this._numMaxConcurrentLoads : this._arrQueue.length;
				for (var i:int = 0; i < numLength; i ++) {
					this.loadURL(i);
				}
				this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.BEGIN,this,{total:this._numTotalFiles}));
			}
		}

		private function loadURL($index:uint):void
		{
			this._numLoadIndex=$index;
			var objQueueItem:Object=this.getQueueItem(this._numLoadIndex);
			objQueueItem.loader.loadURL(objQueueItem.file, this.generateLoaderContext());
			this.status("Loading - " + objQueueItem.file);
			
			this.addListeners(objQueueItem.loader);
			this.addToCurrentLoad(objQueueItem.loader);
			this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.FILE_OPEN,this,objQueueItem));
		}
		private function loadNext():void
		{
			if ( this._bolRunning ) {
				if ((this._numLoadIndex + 1) <= (this._numTotalFiles-1)) {
					this._numLoadIndex += 1;
					var objQueueItem:Object = this.getQueueItem(this._numLoadIndex);
					this.loadURL(this._numLoadIndex);
					this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.NEXT,this,{file:objQueueItem.file,total:this._numTotalFiles, index:this._numLoadIndex}));
				}
			}
		}
		private function loadComplete():void
		{
			this.calculateOverallPercentage();
			if (!this._bolComplete) {
				this._bolComplete=true;
				this.status("Complete!");
				this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.COMPLETE,this,{total:this._numTotalFiles}));
			}
		}
		/*
		Getters
		*/
		public function getLoader($alias:String):*
		{
			var objBrowser:SuperArray = new SuperArray(this._arrQueue);
			return objBrowser.findItem($alias, "alias").loader;
		}
		public function getQueueItem($index:int):Object
		{
			return this._arrQueue[$index];
		}
		private function getQueueItemByLoader($loader:*):Object
		{
			var objBrowser:SuperArray = new SuperArray(this._arrQueue);
			return objBrowser.findItem($loader, "loader");
		}
		/*
		Event Handlers
		*/
		private function onFileError($event:LoaderEvent):void
		{
			var objQueueItem:Object = this.getQueueItemByLoader($event.target);
			objQueueItem.percent = 100;
			this._numCompletedFiles += 1;
			
			this.warning("Could not find - " + objQueueItem.file + "!");
			this.removeFromCurrentLoad($event.target);
			this.removeListeners($event.target);
			this.calculateOverallPercentage();
			//Fake Progress Event Since file never had progress
			var objDetails:Object=new Object  ;
			objDetails.overallPercent=this._numOverallPercentage;
			objDetails.filePercent=100;
			objDetails.loadedPercent=this._numLoadedPercentage;
			objDetails.totalPercent=this._numTotalPercentage;
			objDetails.loadIndex=this._numLoadIndex;
			objDetails.totalFiles=this._numTotalFiles
			this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.PROGRESS,this,objDetails));
			//
			if (this._numCompletedFiles != this._numTotalFiles) {
				this.loadNext();
			} else {
				this.loadComplete();
			}
			
		}
		private function onProgress($event:LoaderEvent):void
		{
			var objQueueItem:Object = this.getQueueItemByLoader($event.target);
			objQueueItem.percent = $event.details.percent;
			//
			this.calculateOverallPercentage();
			//
			var objDetails:Object=new Object  ;
			objDetails.overallPercent=this._numOverallPercentage;
			objDetails.filePercent=$event.details.percent;
			objDetails.loadedPercent=this._numLoadedPercentage;
			objDetails.totalPercent=this._numTotalPercentage;
			objDetails.loadIndex=this._numLoadIndex;
			objDetails.totalFiles=this._numTotalFiles;

			this.dispatchEvent(new BulkLoaderEvent(BulkLoaderEvent.PROGRESS,this,objDetails));
		}
		private function onFileComplete($event:LoaderEvent):void
		{
			this._numCompletedFiles += 1;
			this.removeFromCurrentLoad( $event.target );
			this.removeListeners($event.target);
			if (this._numCompletedFiles != this._numTotalFiles) {
				this.loadNext();
			} else {
				this.loadComplete();
			}
		}
		/*
		Property Definitions
		*/
		public function set sortBy($value:String):void
		{
			this._strSortBy = $value;
		}
		public function get sortBy():String
		{
			return this._strSortBy;
		}
		
		public function get complete():Boolean
		{
			return this._bolComplete;
		}
		
		public function get running():Boolean
		{
			return this._bolRunning
		}
		
		public function set cuncurrentLoads($count:uint):void
		{
			this._numMaxConcurrentLoads = $count;			
		}
		public function get cuncurrentLoads():uint
		{
			return this._numMaxConcurrentLoads;			
		}
	}
}