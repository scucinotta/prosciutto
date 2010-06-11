package __template.view
{
	import com.bedrockframework.engine.view.BedrockView;
	import com.bedrockframework.engine.view.IPreloader;
	
	import flash.text.TextField;
	
	import com.greensock.TweenLite;
	
	public class ShellPreloaderView extends BedrockView implements IPreloader
	{
		/*
		Variable Declarations
		*/
		public var display:TextField;
		/*
		Constructor
		*/
		public function ShellPreloaderView()
		{
			this.alpha = 0 ;
		}
		/*
		Basic view functions
	 	*/
		public function initialize($properties:Object=null):void
		{
			this.displayProgress(0);
			this.x=this.stage.stageWidth / 2;
			this.y=this.stage.stageHeight / 2;
			this.initializeComplete();
		}
		public function intro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:1, onComplete:this.introComplete});
			//this.introComplete();
		}
		public function displayProgress($percent:uint):void
		{
			this.display.text=$percent + " %";
		}
		public function outro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:0, onComplete:this.outroComplete});
			//this.outroComplete();
		}
		public function clear():void
		{
		}
		

	}
}