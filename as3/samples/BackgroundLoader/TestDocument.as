package
{
	import com.bedrockframework.plugin.loader.DataLoader;
	import com.bedrockframework.plugin.event.LoaderEvent;

	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objDataLoader:DataLoader;
		
		
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
			this._objDataLoader = new DataLoader();
			//this.addChild(this._objDataLoader);
			
			this._objDataLoader.addEventListener(LoaderEvent.COMPLETE, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.OPEN, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.INIT, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.UNLOAD, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.HTTP_STATUS, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.PROGRESS, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.IO_ERROR, this.onHandler);
			this._objDataLoader.addEventListener(LoaderEvent.SECURITY_ERROR, this.onHandler);
			
			
			this._objDataLoader.load(new URLRequest("pic1.jpg"));
			trace(this._objDataLoader.request)
			
			this._objDataLoader.loadURL("pic1.jpg");
			trace(this._objDataLoader.request);
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		private function onHandler($event)
		{
			trace("> ", $event.type);
			for (var i in $event.details) {
				trace("   ", i , $event.details[i]);
			}
			trace("")
		}
		
	}
}