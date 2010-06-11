package
{
	import com.bedrockframework.plugin.data.ScrollerData;
	import com.bedrockframework.plugin.gadget.Scroller;
	
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
			var objPropertiesH = new ScrollerData;
			objPropertiesH.content = this.content;
			objPropertiesH.mask = this.contentMask;
			objPropertiesH.scrubberContainer = this.horizontalTrack;
			objPropertiesH.scrubberBackground = this.horizontalTrack.background;
			objPropertiesH.scrubber = this.horizontalTrack.mcDrag;
			objPropertiesH.resize = true;
			objPropertiesH.alignment = ScrollerData.LEFT;
			objPropertiesH.direction = ScrollerData.HORIZONTAL;
			//
			objScrollerH = new Scroller();
			objScrollerH.initialize(objPropertiesH);
			//
			var objPropertiesV = new ScrollerData;
			objPropertiesV.content = this.content;
			objPropertiesV.mask = this.contentMask;
			objPropertiesV.scrubberContainer = this.verticalTrack;
			objPropertiesV.scrubberBackground = this.verticalTrack.background;
			objPropertiesV.scrubber = this.verticalTrack.mcDrag;
			objPropertiesV.resize = true;
			objPropertiesV.alignment = ScrollerData.CENTER;
			objPropertiesV.direction = ScrollerData.VERTICAL;
			//
			objScrollerV = new Scroller();
			objScrollerV.initialize(objPropertiesV);
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