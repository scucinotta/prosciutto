package
{
	import com.bedrockframework.plugin.audio.GlobalSound;
	
	import flash.media.Sound;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objGlobalSound:GlobalSound;
		
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
			var objSound:Sound = new EuropeBackground();
			objSound.play();
			
			this._objGlobalSound = new GlobalSound;
			
			this.fadeOutButton.addEventListener( MouseEvent.CLICK, this.onFadeOutClicked );
			this.fadeInButton.addEventListener( MouseEvent.CLICK, this.onFadeInClicked );

		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onFadeOutClicked( $event:MouseEvent ) :void
		{
			trace( "Fade Out!" );
			this._objGlobalSound.fadeVolume( 0, 0.5 );
			//this._objGlobalSound.mute();
		}
		
		function onFadeInClicked( $event:MouseEvent ) :void
		{
			trace( "Fade In!" );
			this._objGlobalSound.fadeVolume( 1, 0.5 );
			//this._objGlobalSound.unmute();
		}
	}
}