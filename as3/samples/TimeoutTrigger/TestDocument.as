package
{
	import com.bedrockframework.plugin.timer.TimeoutTrigger;
	import com.bedrockframework.plugin.event.TriggerEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		
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
			var objTimeoutTrigger:TimeoutTrigger = new TimeoutTrigger();
			
			objTimeoutTrigger.start(0.5)
			
			objTimeoutTrigger.addEventListener(TriggerEvent.TRIGGER, this.onTimeoutTriggerHandler);
			objTimeoutTrigger.addEventListener(TriggerEvent.STOP, this.onStopHandler);
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onTimeoutTriggerHandler ($event) {
			trace("trigger");
		}
		
		function onStopHandler($event)
		{
			trace("with listener: STOPPED")
		}
		
	}
}