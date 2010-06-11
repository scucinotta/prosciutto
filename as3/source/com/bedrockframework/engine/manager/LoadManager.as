package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.core.event.GenericEvent;
	import com.bedrockframework.core.logging.Logger;
	import com.bedrockframework.engine.api.ILoadManager;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.event.BulkLoaderEvent;
	import com.bedrockframework.plugin.loader.BulkLoader;
	import com.bedrockframework.plugin.loader.MultiLoader;
	import com.bedrockframework.plugin.storage.HashMap;
	
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	public class LoadManager extends StandardWidget implements ILoadManager
	{
		/*
		Variable Declarations
		*/
		private static var __objEventMap:HashMap;
		private var _objBulkLoader:BulkLoader;
		/*
		Constructor
		*/	
		public function LoadManager():void
		{
			
		}
		public function initialize( $applicationDomain:ApplicationDomain ):void
		{
			this._objBulkLoader = new BulkLoader;
			this._objBulkLoader.applicationDomainUsage = MultiLoader.REUSE_DOMAIN;
			this._objBulkLoader.applicationDomain = $applicationDomain;
			this.setupReplacements();
		}
		/*
		ChainLoader wrappers
		*/
		public function reset():void
		{
			this._objBulkLoader.reset();
		}
		public function close():void
		{
			this._objBulkLoader.close();
		}
		public function loadQueue():void
		{
			this._objBulkLoader.loadQueue();
		}
		public function addToQueue($path:String, $loader:* = null, $priority:uint=0, $alias:String = null, $completeHandler:Function=null, $errorHandler:Function=null):void
		{
			this._objBulkLoader.addToQueue($path,$loader, $priority, $alias, $completeHandler, $errorHandler);
		}
		/*
		Getters
		*/
		public function getLoader($alias:String):*
		{
			return this._objBulkLoader.getLoader( $alias );
		}
		/*
		Event Replacements
		*/
		private function setupReplacements():void
		{
			if (LoadManager.__objEventMap == null) {
				var arrBulkEvents:Array=new Array("BEGIN","ERROR","COMPLETE","CLOSE","PROGRESS","NEXT","RESET", "FILE_ADDED", "FILE_OPEN","FILE_PROGRESS","FILE_COMPLETE","FILE_INIT","FILE_UNLOAD","FILE_ERROR","FILE_SECURITY_ERROR","FILE_HTTP_STATUS");
				var arrManagerEvents:Array=new Array("LOAD_BEGIN","LOAD_ERROR","LOAD_COMPLETE","LOAD_CLOSE","LOAD_PROGRESS","LOAD_NEXT","LOAD_RESET", "FILE_ADDED","FILE_OPEN","FILE_PROGRESS","FILE_COMPLETE","FILE_INIT","FILE_UNLOAD","FILE_ERROR","FILE_SECURITY_ERROR","FILE_HTTP_STATUS");
				LoadManager.__objEventMap=new HashMap;
				//
				var numLength:Number=arrBulkEvents.length;
				for (var i:Number=0; i < numLength; i++) {
					LoadManager.__objEventMap.saveValue(BulkLoaderEvent[arrBulkEvents[i]],BedrockEvent[arrManagerEvents[i]]);
				}
				this.setupListeners(arrBulkEvents);
			}
		}
		private function setupListeners($events:Array):void
		{
			var numLength:int = $events.length;
			for (var i:int = 0 ; i < numLength; i++) {
				this._objBulkLoader.addEventListener(BulkLoaderEvent[$events[i]], this.onGenericHandler);
			}
		}
		private function onGenericHandler($event:Event):void
		{
			try {
				BedrockDispatcher.dispatchEvent(new BedrockEvent(LoadManager.__objEventMap.getValue($event.type),this,GenericEvent($event).details));
			} catch ($e:Error) {
				Logger.warning(this, "Unable to find matching event name replacement!");
			}
		}
		/*
		Property Definitions
		*/
		public function get running():Boolean 
		{
			return this._objBulkLoader.running;
		}
		
		public function set cuncurrentLoads($count:uint):void
		{
			this._objBulkLoader.cuncurrentLoads = $count;			
		}
		public function get cuncurrentLoads():uint
		{
			return this._objBulkLoader.cuncurrentLoads;	
		}
	}

}