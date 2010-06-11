package __template.view
{
	import com.bedrockframework.engine.view.BedrockView;
	import com.bedrockframework.engine.view.IPreloader;
	import com.greensock.TweenLite;
	
	import flash.text.TextField;
	
	public class DefaultPreloaderView extends BedrockView implements IPreloader
	{
		/*
		Variable Declarations
		*/
		public var display:TextField;
		/*
		Constructor
		*/
		public function DefaultPreloaderView()
		{
			this.alpha = 0;
		}
		/*
		Basic view functions
	 	*/
		public function initialize($properties:Object=null):void
		{
			this.displayProgress(0);
			this.initializeComplete();
		}
		public function intro($properties:Object=null):void
		{
			TweenLite.to(this, 1, { alpha:1, onComplete:this.introComplete } );
			//this.introComplete();
		}
		public function outro($properties:Object=null):void
		{
			TweenLite.to(this, 1, { alpha:0, onComplete:this.outroComplete } );
			//this.outroComplete();
		}
		public function displayProgress($percent:uint):void
		{
			this.display.text=$percent + " %";
		}
		public function clear():void
		{
		}
		

	}
}