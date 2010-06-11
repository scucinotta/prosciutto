package
{
	import com.bedrockframework.plugin.audio.AudioPlayer;
	import com.bedrockframework.plugin.event.AudioEvent;
		
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		
		private var _objAudioPlayer:AudioPlayer
		
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
			this._objAudioPlayer = new AudioPlayer();
			//this._objAudioPlayer.initialize( new Asia );
			this._objAudioPlayer.initialize();
			this._objAudioPlayer.load("europeBackground.mp3");
			
			this._objAudioPlayer.addEventListener(AudioEvent.LOAD_COMPLETE, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.LOAD_PROGRESS, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.OPEN, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.ID3, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.ERROR, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.VOLUME, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.PAN, this.onGenericHandler);
			
			this._objAudioPlayer.addEventListener(AudioEvent.PLAY_COMPLETE, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.PLAY_PROGRESS, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.PLAY, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.STOP, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.PAUSE, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.RESUME, this.onGenericHandler);
			this._objAudioPlayer.addEventListener(AudioEvent.CLOSE, this.onGenericHandler);
			//
			this.fadeOutButton.addEventListener( MouseEvent.CLICK, this.onFadeOutClicked );
			this.fadeInButton.addEventListener( MouseEvent.CLICK, this.onFadeInClicked );
			this.seekButton.addEventListener( MouseEvent.CLICK, this.onSeekClicked );
			
			this.pauseButton.addEventListener( MouseEvent.CLICK, this.onPauseClicked );
			this.resumeButton.addEventListener( MouseEvent.CLICK, this.onResumeClicked );
			//
			this._objAudioPlayer.play();
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		private function onGenericHandler($event)
		{
			//trace($event.type);
		}
		
		
		
		private function onFadeOutClicked( $event:MouseEvent ) :void
		{
			trace( "Fade Out!" );
			this._objAudioPlayer.fadeVolume( 0, 3 );
		}
		
		private function onFadeInClicked( $event:MouseEvent ) :void
		{
			trace( "Fade In!" );
			this._objAudioPlayer.fadeVolume( 1, 3 );
		}
		private function onSeekClicked( $event:MouseEvent ) :void
		{
			trace( "Seek!" );
			this._objAudioPlayer.seekWithPercentage( 50 );
		}
		
		private function onPauseClicked( $event:MouseEvent ) :void
		{
			trace( "Pause!" );
			this._objAudioPlayer.pause();
		}
		private function onResumeClicked( $event:MouseEvent ) :void
		{
			trace( "Resume!" );
			this._objAudioPlayer.resume();
		}
		
	}
}