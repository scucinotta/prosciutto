package __template.view
{
	import com.bedrockframework.engine.view.BedrockView;
	import com.bedrockframework.plugin.data.TextDisplayData;
	import com.bedrockframework.plugin.gadget.TextDisplay;
	import com.bedrockframework.plugin.util.ButtonUtil;
	import com.bedrockframework.plugin.view.IView;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class HomepageView extends BedrockView implements IView
	{
		/*
		Variable Declarations
		*/
		public var changeButton1:MovieClip;
		public var changeButton2:MovieClip;
		
		public var textDisplay1:TextDisplay;
		public var textDisplay2:TextDisplay;
		/*
		Constructor
		*/
		public function HomepageView()
		{
			this.alpha = 0;
		}
		public function initialize($properties:Object=null):void
		{
			ButtonUtil.addListeners(this.changeButton1, {down:this.onChange1 });
			ButtonUtil.addListeners(this.changeButton2, {down:this.onChange2 });
			
			this.populateOnStageDisplay();
			this.createTextDisplay();
			
			this.initializeComplete();
		}
		public function intro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:1, onComplete:this.introComplete});
			//this.introComplete();
		}
		public function outro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:0, onComplete:this.outroComplete});
			//this.outroComplete();
		}
		public function clear():void
		{
			this.status("clear");
		}
		private function populateOnStageDisplay():void
		{
			var objData:TextDisplayData = new TextDisplayData;
			//objData.text = "\u05DB\u05DC\u0020\u05D1\u05E0\u05D9\u0020\u05D0\u05D3\u05DD\u0020\u05E0\u05D5\u05DC";
			objData.text = "Much stains quickly, outlasts find superior guaranteed ultimate. Save save handling fast more herbal calories happy look picky mega, velvety yummy. Most it's wherever effective quality sweet one sale, enjoy blast, light velvety offer improved whenever. Permanent jumbo so comes appreciate sporty yours supreme."
				
			this.textDisplay1.initialize( objData );
		}
		private function createTextDisplay():void
		{
			var objData:TextDisplayData = new TextDisplayData;
			//objData.text = "\u05DB\u05DC\u0020\u05D1\u05E0\u05D9\u0020\u05D0\u05D3\u05DD\u0020\u05E0\u05D5\u05DC";
			objData.text = "Much stains quickly, outlasts find superior guaranteed ultimate. Save save handling fast more herbal calories happy look picky mega, velvety yummy. Most it's wherever effective quality sweet one sale, enjoy blast, light velvety offer improved whenever. Permanent jumbo so comes appreciate sporty yours supreme."
			objData.width = 500;
			objData.height = 100;
			
			this.textDisplay2 = new TextDisplay;
			this.textDisplay2.initialize( objData );
			this.textDisplay2.x = ( this.stage.stageWidth /2 ) - ( objData.width /2 );
			this.textDisplay2.y = this.stage.stageHeight /2;
			this.addChild( this.textDisplay2 );
		}
		/*
		Event Handlers
		*/
		private function onChange1($event:MouseEvent):void
		{
			this.textDisplay1.populate( "Quisque at mi id leo aliquam feugiat a vitae sem. Nunc interdum, arcu in dictum adipiscing, dolor magna vestibulum risus, nec vestibulum metus est vitae magna." );
			trace( this.textDisplay1.width );
		}
		private function onChange2($event:MouseEvent):void
		{
			this.textDisplay2.populate( "Suspendisse mi id leo consectetur diam sed mauris adipiscing commodo. Mauris ipsum justo, aliquet accumsan gravida eget, hendrerit sit amet purus." );
			trace( this.textDisplay2.width );
		}
	}
}