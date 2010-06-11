package
{
	import com.bedrockframework.plugin.timer.StopWatch;
	import com.bedrockframework.plugin.event.StopWatchEvent;
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objStopWatch:StopWatch;
		
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
			this._objStopWatch = new StopWatch();
			this._objStopWatch.addEventListener( StopWatchEvent.UPDATE, this.onUpdate );
			this._objStopWatch.start();
			
			mcTest.addEventListener(MouseEvent.CLICK, this.onStopClicked);
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onStopClicked($event):void
		{
			this._objStopWatch.stop();
		}
		function onUpdate($event):void
		{
			this._objStopWatch.debug( $event.details );
		}
		
	}
}