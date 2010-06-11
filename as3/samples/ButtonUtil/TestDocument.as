package
{
	import flash.events.MouseEvent;
	import com.bedrockframework.plugin.util.ButtonUtil;

	
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
			ButtonUtil.addListeners(this.mcRectangle, {down:this.onHandler, up:this.onHandler, over:this.onHandler, out:this.onHandler, doubleclick:this.onHandler});
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onHandler($event:MouseEvent)
		{
			trace($event.type);
		}
		
	}
}