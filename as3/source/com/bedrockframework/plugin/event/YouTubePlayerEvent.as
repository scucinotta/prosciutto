package com.bedrockframework.plugin.event
{
	import com.bedrockframework.plugin.event.VideoEvent;

	public class YouTubePlayerEvent extends VideoEvent
	{
		public static const VIDEO_UNSTARTED:String = "YouTubePlayerEvent.onVideoUnstarted";
		public static const VIDEO_ENDED:String = "YouTubePlayerEvent.onVideoEnded";
		public static const PLAYER_HARD_STOP:String = "YouTubePlayerEvent.onPlayerHardStop"
		public static const VIDEO_PLAYING:String = "YouTubePlayerEvent.onVideoPlaying";
		public static const VIDEO_PAUSED:String = "YouTubePlayerEvent.onVideoPaused";
		public static const VIDEO_BUFFERING:String = "YouTubePlayerEvent.onVideoBuffering";
		public static const VIDEO_QUEUED:String = "YouTubePlayerEvent.onVideoQueued";
		public static const PLAY_BUTTON_SELECTED:String = "YouTubePlayerEvent.onPlayButtonSelected";
		public static const PAUSE_BUTTON_SELECTED:String = "YouTubePlayerEvent.onPauseButtonSelected";
		public static const VIDEO_LOAD_ERROR:String = "YouTubePlayerEvent.onVideoLoadError";
		public static const MOUSE_OVER:String = "YouTubePlayerEvent.onMouseOver";
		public static const MOUSE_OUT:String = "YouTubePlayerEvent.onMouseOut";
		
		public static const PLAYER_LOAD_COMPLETE:String = "YouTubePlayerEvent.onPlayerLoadComplete";
		public static const PLAYER_LOAD_ERROR:String = "YouTubePlayerEvent.onPlayerLoadError";
		
		public static const PLAYER_READY:String = "onReady";
		public static const PLAYER_ERROR:String = "onError";
		public static const PLAYER_CHANGE:String = "onStateChange";
		
		public function YouTubePlayerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}