package
{

	import com.bedrockframework.plugin.loader.VisualLoader;
	import com.bedrockframework.plugin.loader.ChainLoader;
	import com.bedrockframework.plugin.event.ChainLoaderEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objChainLoader:ChainLoader;
		
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
			//
			this.addChild(objVisualLoader1);
			this.addChild(objVisualLoader2);
			this.addChild(objVisualLoader3);
			//
			this._objChainLoader = new ChainLoader();
			this._objChainLoader.addToQueue("images/pic1.jpg", objVisualLoader1);
			this._objChainLoader.addToQueue("images/pic2.jpg", objVisualLoader2, this.onComplete);
			this._objChainLoader.addToQueue("images/pic3.jpg", objVisualLoader3, this.onComplete );
			this._objChainLoader.addToQueue("images/pic4.jpg", null, this.onComplete );
			this._objChainLoader.addToQueue("images/pic5.jpg", null, this.onComplete );
			//
			this._objChainLoader.addEventListener(ChainLoaderEvent.BEGIN, this.onGenericHandler)
			this._objChainLoader.addEventListener(ChainLoaderEvent.COMPLETE, this.onGenericHandler)
			this._objChainLoader.addEventListener(ChainLoaderEvent.PROGRESS, this.onGenericHandler)
			this._objChainLoader.addEventListener(ChainLoaderEvent.NEXT, this.onGenericHandler)
			this._objChainLoader.addEventListener(ChainLoaderEvent.RESET, this.onGenericHandler)
			this._objChainLoader.addEventListener(ChainLoaderEvent.FILE_COMPLETE, this.onGenericHandler)
			//
			this._objChainLoader.loadQueue();
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		private function onGenericHandler($event) {
			trace($event.type);
		}
		
		
		private function onComplete($event) {
			trace("onComplete");
			trace(this._objChainLoader.getFile(3));
			trace(this._objChainLoader.getLoader(3));
		}
	}
}