package
{
	import com.bedrockframework.plugin.data.TextDisplayData;
	import com.bedrockframework.plugin.gadget.TextDisplay;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		public var multilineText:TextDisplay;
		public var singlelineText:TextDisplay;
		public var multisinglelineText:TextDisplay;
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
			this.initializeMultiline();
			this.initializeSingleline();
			this.initializeMultiSingleline();
		}
		
		private function initializeMultiline():void
		{
			var objData:TextDisplayData = new TextDisplayData;
			objData.mode = TextDisplayData.MULTI_LINE;
			objData.autoLocale = false;
			// autoLocale only works when running along with the Bedrock engine
			
			this.multilineText = new TextDisplay;
			this.multilineText.x = 50;
			this.multilineText.y = 50;
			this.multilineText.initialize( objData );
			this.multilineText.populate( "Little Ms. Muffet sat on her tuffet, eating her turds in waves." );
			this.addChild( this.multilineText );
		}
		private function initializeSingleline():void
		{
			var objData:TextDisplayData = new TextDisplayData;
			objData.mode = TextDisplayData.SINGLE_LINE;
			objData.autoLocale = false;
			objData.width = 400;
			
			this.singlelineText = new TextDisplay;
			this.singlelineText.x = 50;
			this.singlelineText.y = 150;
			this.singlelineText.initialize( objData );
			this.singlelineText.populate( "Little Ms. Muffet sat on her tuffet, eating her turds in waves." );
			this.addChild( this.singlelineText );
		}
		private function initializeMultiSingleline():void
		{
			var objData:TextDisplayData = new TextDisplayData;
			objData.mode = TextDisplayData.MULTI_SINGLE_LINE;
			objData.autoLocale = false;
			objData.width = 150;
			
			this.multisinglelineText = new TextDisplay;
			this.multisinglelineText.x = 50;
			this.multisinglelineText.y = 250;
			this.multisinglelineText.initialize( objData );
			this.multisinglelineText.populate( "Little Ms. Muffet sat on her tuffet, eating her turds in waves." );
			this.addChild( this.multisinglelineText );
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