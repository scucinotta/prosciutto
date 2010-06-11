package
{
	import  com.bedrockframework.plugin.audio.AudioMixer;

	import flash.media.Sound;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objAudioMixer:AudioMixer;
		private var _objSound:Sound;
		
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
			this._objSound = new Asia();

			this._objAudioMixer = new AudioMixer( this._objSound.play( 0, 5 ) );
			
			
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
		
		private function onFadeOutClicked( $event:MouseEvent ) :void
		{
			trace( "Fade Out!" );
			this._objAudioMixer.fadeVolume( 0, 3 );
		}
		
		private function onFadeInClicked( $event:MouseEvent ) :void
		{
			trace( "Fade In!" );
			this._objAudioMixer.fadeVolume( 1, 3 );
		}
		
	}
}