package
{
	import com.bedrockframework.plugin.display.Blocker;
	import com.bedrockframework.plugin.event.BlockerEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objBlocker:Blocker;
		
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
			this._objBlocker = new Blocker(0.25);
			this.addChild(this._objBlocker);
			
			this._objBlocker.addEventListener(BlockerEvent.SHOW, this.handler);
			this._objBlocker.addEventListener(BlockerEvent.HIDE, this.handler);
			this._objBlocker.addEventListener(BlockerEvent.MOUSE_DOWN, this.handler);
			this._objBlocker.addEventListener(BlockerEvent.MOUSE_UP, this.handler);
			this._objBlocker.addEventListener(BlockerEvent.MOUSE_OVER, this.handler);
			this._objBlocker.addEventListener(BlockerEvent.MOUSE_OUT, this.handler);
			this._objBlocker.show();
	
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		
		private function handler($event)
		{
			trace($event.type);
		}
	}
}