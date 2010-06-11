package
{
	import com.bedrockframework.plugin.view.ViewStack;
	import com.bedrockframework.plugin.data.ViewStackData;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objViewStack:ViewStack;
		
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
			this._objViewStack = new ViewStack();
			this.addChild( this._objViewStack );
			
			var objViewStackData = new ViewStackData();
			objViewStackData.autoInitialize = true;
			//objViewStackData.autoStart = false;
			objViewStackData.addToStack( new Burst1() );
			objViewStackData.addToStack( new Burst2() );
			objViewStackData.addToStack( new Burst3() );
			objViewStackData.addToStack( new Burst4() );
			

			//objViewStackData.container = this;
			this._objViewStack.initialize(objViewStackData);
			//
			//
			this.startButton.addEventListener("click", this.onStartClicked);
			this.stopButton.addEventListener("click", this.onStopClicked);
			this.modeButton.addEventListener("click", this.onChangeModeClicked );
			this.nextButton.addEventListener("click", this.onNextClicked);
			this.previousButton.addEventListener("click", this.onPreviousClicked);
			
			this.oneButton.addEventListener("click", this.onOneClicked );
			this.twoButton.addEventListener("click", this.onTwoClicked);
			this.threeButton.addEventListener("click", this.onThreeClicked);
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onStartClicked($event)
		{
			this._objViewStack.startTimer( 3 );
		}
		function onStopClicked($event)
		{
			this._objViewStack.stopTimer();
		}
		function onChangeModeClicked ($event)
		{
			this._objViewStack.toggleMode();
		}
		function onNextClicked($event){
			this._objViewStack.selectNext()
		}
		function onPreviousClicked($event){
			this._objViewStack.selectPrevious()
		}
		
		
		function onOneClicked ($event)
		{
			this._objViewStack.selectByIndex( 0 );
		}
		function onTwoClicked($event){
			this._objViewStack.selectByIndex( 1 );
		}
		function onThreeClicked($event){
			this._objViewStack.selectByIndex( 2 );
		}
		
	}
}