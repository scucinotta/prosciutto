package
{
	import com.bedrockframework.plugin.loader.VisualLoader;
	import com.bedrockframework.plugin.loader.BulkLoader;
	import com.bedrockframework.plugin.event.BulkLoaderEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objBulkLoader:BulkLoader;
		
		/*
		Constructor
		*/
		public function TestDocument()
		{
			this.loaderInfo.addEventListener(Event.INIT, this.onBootUp);
		}

		/*
		Basic view functions
	 	*/
		public function initialize():void
		{
			var objVisualLoader1:VisualLoader = new VisualLoader();
			var objVisualLoader2:VisualLoader = new VisualLoader();
			var objVisualLoader3:VisualLoader = new VisualLoader();
			//
			objVisualLoader2.x = 50;
			objVisualLoader2.y = 50;
			objVisualLoader3.x = 100;
			objVisualLoader3.y = 100;
			
			this.addChild(objVisualLoader1);
			this.addChild(objVisualLoader2);
			this.addChild(objVisualLoader3);
			
			this._objBulkLoader = new BulkLoader();
			this._objBulkLoader.addToQueue("images/pic1.jpg", objVisualLoader1);
			this._objBulkLoader.addToQueue("images/pic2.jpg", objVisualLoader2, 100, "cheese", this.onComplete);
			this._objBulkLoader.addToQueue("images/pic3.jpg", objVisualLoader3, 99, "nips",  this.onComplete);
			this._objBulkLoader.addToQueue("images/pic4.jpg", null, 0, null, this.onComplete);
			this._objBulkLoader.addToQueue("images/pic5.jpg", null, 0, null, this.onComplete);
			//
			this._objBulkLoader.addEventListener(BulkLoaderEvent.BEGIN, this.onGenericHandler)
			this._objBulkLoader.addEventListener(BulkLoaderEvent.COMPLETE, this.onTotallyComplete)
			this._objBulkLoader.addEventListener(BulkLoaderEvent.PROGRESS, this.onProgress)
			this._objBulkLoader.addEventListener(BulkLoaderEvent.NEXT, this.onGenericHandler)
			this._objBulkLoader.addEventListener(BulkLoaderEvent.RESET, this.onGenericHandler)
			this._objBulkLoader.addEventListener(BulkLoaderEvent.FILE_COMPLETE, this.onGenericHandler)
			
			mcClose.addEventListener("click", this.onCloseClicked);
			
			this._objBulkLoader.cuncurrentLoads = 2;
			this._objBulkLoader.loadQueue();
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onGenericHandler($event) {
			//trace($event.type);
		}
		
		function onCloseClicked ($event) {
			this._objBulkLoader.close();
		}
		
		function onComplete($event) {
			trace("onComplete");
			trace(this._objBulkLoader.getLoader("nips") as VisualLoader);
		}
		function onProgress ($event) {
			trace($event.details.overallPercent)
		}
		
		function onTotallyComplete($event) {
			trace("totally onComplete")
		}
		
	}
}