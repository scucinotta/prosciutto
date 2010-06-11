package
{
	import com.bedrockframework.core.base.MovieClipWidget;
	import com.bedrockframework.plugin.data.YouTubePlayerData;
	import com.bedrockframework.plugin.event.VideoEvent;
	import com.bedrockframework.plugin.util.ButtonUtil;
	import com.bedrockframework.plugin.video.YouTubePlayer;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TestDocument extends MovieClipWidget
	{
		/*
		Variable Declarations
		*/
		public var playButton:MovieClip;
		public var playOffsetButton:MovieClip;
		public var queueButton:MovieClip;
		public var stopButton:MovieClip;
		public var pauseButton:MovieClip;
		public var resumeButton:MovieClip;
		public var seekButton:MovieClip;
		
		public var player:YouTubePlayer;
		/*
		Constructor
		*/
		public function TestDocument()
		{
			this.loaderInfo.addEventListener( Event.INIT, this.onBootUp );
		}

		/*
		Basic view functions
	 	*/
		public function initialize():void
		{
			this.createYouTubePlayer();
			this.createListeners();
		}
		private function createYouTubePlayer():void
		{
			var objData:YouTubePlayerData = new YouTubePlayerData;
			
			this.player = new YouTubePlayer;
			this.player.addEventListener( VideoEvent.PLAY_PROGRESS, this.onPlayProgress );
			this.player.addEventListener( VideoEvent.LOAD_PROGRESS, this.onLoadProgress );
			this.addChild( this.player );
			this.player.initialize( objData );
		}
		private function createListeners():void
		{
			ButtonUtil.addListeners( this.playButton, { down:this.onPlay } );
			ButtonUtil.addListeners( this.playOffsetButton, { down:this.onPlayWithOffset } );
			ButtonUtil.addListeners( this.queueButton, { down:this.onQueue } );
			ButtonUtil.addListeners( this.stopButton, { down:this.onStop } );
			ButtonUtil.addListeners( this.pauseButton, { down:this.onPause } );
			ButtonUtil.addListeners( this.resumeButton, { down:this.onResume } );
			ButtonUtil.addListeners( this.seekButton, { down:this.onSeek } );
		}
		/*
		Event Handlers
		*/
		private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		/*
		Mouse Events
		*/
		private function onPlay( $event:MouseEvent ):void
		{
			this.player.play( "hgDHWLyztCI" );
		}
		private function onPlayWithOffset( $event:MouseEvent ):void
		{
			this.player.playWithOffset( "hgDHWLyztCI", 30 );
		}
		private function onSeek( $event:MouseEvent ):void
		{
			this.player.seekWithPercentage( 30 );
		}
		private function onQueue( $event:MouseEvent ):void
		{
			this.player.queue( "hgDHWLyztCI" );
		}
		private function onStop( $event:MouseEvent ):void
		{
			this.player.stop();
		}
		private function onPause( $event:MouseEvent ):void
		{
			this.player.pause();
		}
		private function onResume( $event:MouseEvent ):void
		{
			this.player.resume();
		}
		private function onLoadProgress( $event:VideoEvent ):void
		{
			debug( $event.details );
		}
		private function onPlayProgress( $event:VideoEvent ):void
		{
			debug( $event.details );
		}
	}
}