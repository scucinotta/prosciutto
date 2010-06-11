package
{
	import com.bedrockframework.plugin.util.DisplayObjectUtil;
	import flash.display.*

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
			var mcDup:MovieClip = DisplayObjectUtil.duplicate(this.mcCopy);
			trace("children:", this.numChildren);
			this.addChild(mcDup);
			trace(mcDup, "x:", mcDup.x, "y:", mcDup.y)
			mcDup.x +=100
			mcDup.y += 100
			trace(mcDup, "x:", mcDup.x, "y:", mcDup.y)
			trace("children:", this.numChildren);
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