package 
{
	import com.bedrockframework.plugin.view.MovieClipView;
	import com.bedrockframework.plugin.view.IView;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.greensock.TweenLite;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	public class TestView extends MovieClipView implements IView
	{

		/*
		Variable Declarations
		*/
		public var txtDisplay:TextField;
		public var txtLabel:TextField;
		/*
		Constructor
		*/
		public function TestView()
		{
			this.alpha=0;
		}
		public function initialize($properties:Object=null):void
		{
			this.displayProgress(10000);
			this.txtLabel.text = "Meh";
			this.x=this.stage.stageWidth / 2;
			this.y=this.stage.stageHeight / 2;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, this.onClick);
			this.initializeComplete();
		}
		public function intro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:1, onComplete:this.introComplete});
			//this.introComplete();
		}
		public function displayProgress($percent:Number):void
		{
			this.txtDisplay.text=$percent + " %";
		}
		public function outro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:0, onComplete:this.outroComplete});
			//this.outroComplete();
		}
		public function clear():void
		{

		}
		/*
		Event Handlers
		*/
		private function onClick($event:MouseEvent):void
		{
			this.outro();
		}
	}
}