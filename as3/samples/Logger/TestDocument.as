package
{
	import com.bedrockframework.core.logging.*;

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
			Logger.log(this, LogLevel.FATAL, {info:"fjddhfkdhfkjs", yay:{corn:"live", nothing:767676767, live:new LogFormatter}});

			trace("poop")
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