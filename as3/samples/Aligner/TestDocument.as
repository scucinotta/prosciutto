package
{
	
	import com.bedrockframework.plugin.util.AlignmentUtil;
	
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
			AlignmentUtil.alignHorizontal(this.mcTemp, AlignmentUtil.LEFT)
			AlignmentUtil.alignVertical(this.mcTemp, AlignmentUtil.CENTER, this.stage.stageHeight)
			AlignmentUtil.alignVertical(this.mcOutter, AlignmentUtil.CENTER, this.stage.stageHeight)
			AlignmentUtil.alignHorizontal(this.mcTemp.mcInner, AlignmentUtil.RIGHT,this.mcTemp.width)
			AlignmentUtil.alignVertical(this.mcTemp.mcInner, AlignmentUtil.BOTTOM, this.mcTemp.height)
			AlignmentUtil.alignHorizontal(this.mcCenter, AlignmentUtil.CENTER, this.stage.stageWidth)
			AlignmentUtil.alignVertical(this.mcCenter, AlignmentUtil.CENTER, this.stage.stageHeight)
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