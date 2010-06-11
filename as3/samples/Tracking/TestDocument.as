package
{
	import com.bedrockframework.engine.manager.TrackingManager;
	import com.bedrockframework.plugin.tracking.Urchin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objTrackingManager:TrackingManager;
		
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
			this._objTrackingManager = new TrackingManager();
			this._objTrackingManager.initialize();
			this._objTrackingManager.addService("urchin", new Urchin());
			this._objTrackingManager.track("urchin", {item:"corn", title:"wall"});
			this._objTrackingManager.track("urchin", {item:"corn", title:"wall"});
			this._objTrackingManager.track("urchin", {item:"corn", title:"wall"});
			this._objTrackingManager.track("urchin", {item:"corn", title:"wall"});
			this._objTrackingManager.track("urchin", {item:"corn", title:"wall"});
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
	}
}