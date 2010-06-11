package
{
	
	import flash.net.URLRequest;
	import com.bedrockframework.plugin.loader.VisualLoader;
	import com.bedrockframework.plugin.event.LoaderEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objVisualLoader:VisualLoader;
		
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
			this._objVisualLoader = new VisualLoader();
			this.addChild(this._objVisualLoader);
			
			this._objVisualLoader.addEventListener(LoaderEvent.COMPLETE, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.OPEN, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.INIT, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.UNLOAD, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.HTTP_STATUS, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.PROGRESS, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.IO_ERROR, this.onHandler);
			this._objVisualLoader.addEventListener(LoaderEvent.SECURITY_ERROR, this.onHandler);
			
			this._objVisualLoader.load(new URLRequest("pic1.jpg"));
			trace(this._objVisualLoader.request)
			
			this._objVisualLoader.loadURL("pic1.jpg");
			trace(this._objVisualLoader.request)
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onHandler($event)
		{
			trace("> ", $event.type);
			for (var i in $event.details) {
				trace("   ", i , $event.details[i]);
			}
			trace("")
		}
	}
}