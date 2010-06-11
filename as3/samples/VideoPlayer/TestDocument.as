package
{
	import com.bedrockframework.plugin.data.VideoPlayerData;
	import com.bedrockframework.plugin.event.VideoEvent;
	import com.bedrockframework.plugin.video.VideoPlayer;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objVideo:VideoPlayer;
		
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
			var objData:VideoPlayerData = new VideoPlayerData;
			objData.width = 320;
			objData.height = 240;
			objData.bufferTime = 5;
			
			this._objVideo = new VideoPlayer();
			this.addChild(this._objVideo);
			this._objVideo.initialize( objData );
			this._objVideo.play( "cuepoints.flv" );
			this._objVideo.volume = 0;
			
			this.playButton.addEventListener( MouseEvent.CLICK, this.onPlayClicked );
			this.queueButton.addEventListener( MouseEvent.CLICK, this.onQueueClicked );
			this.stopButton.addEventListener( MouseEvent.CLICK, this.onStopClicked );
			this._objVideo.addEventListener( VideoEvent.BUFFER_PROGRESS, this.onBufferProgress );
			this._objVideo.addEventListener( VideoEvent.PLAY_PROGRESS, this.onPlayProgress );
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		private function onBufferProgress ( $event:VideoEvent ):void
		{
			this._objVideo.status("Buffer : " + $event.details.percent)
		}
		private function onPlayProgress ( $event:VideoEvent ):void
		{
			this._objVideo.status("Play : " + $event.details.percent)
		}
		
		private function  onPlayClicked( $event:MouseEvent ):void
		{
			this._objVideo.play("Phone.flv")
		}
		private function  onQueueClicked( $event:MouseEvent ):void
		{
			//this._objVideo.queue("Phone.flv")
		}
		
		private function  onStopClicked( $event:MouseEvent ):void
		{
			this._objVideo.stop();
		}

		
	}
}