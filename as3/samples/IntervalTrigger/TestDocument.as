package
{
	import com.bedrockframework.plugin.timer.IntervalTrigger;
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
			
			var objIntervalTrigger:IntervalTrigger = new IntervalTrigger();
			
			objIntervalTrigger.start(0.5, 4)
			
			objIntervalTrigger.addEventListener(TriggerEvent.TRIGGER, this.onIntervalTriggerHandler);
			objIntervalTrigger.addEventListener(TriggerEvent.STOP, this.onStopHandler);

		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		

		function onIntervalTriggerHandler ($event) {
			trace($event.details.index);
		}
		
		function onStopHandler($event)
		{
			trace("with listener: STOPPED")
		}
		
	}
}