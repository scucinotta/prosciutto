package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class AudioEvent extends GenericEvent
	{
		public static const LOAD_COMPLETE:String = "AudioEvent.onLoadComplete";
		public static const LOAD_PROGRESS:String = "AudioEvent.onLoadProgress";
		public static const OPEN:String = "AudioEvent.onOpen";
		public static const ID3:String = "AudioEvent.onID3";
		public static const ERROR:String ="AudioEvent.onError";
		
		public static const VOLUME:String = "AudioEvent.onVolume";
		public static const PAN:String = "AudioEvent.onPan";
		
		public static const MUTE:String = "AudioEvent.onMute";
		public static const UNMUTE:String = "AudioEvent.onUnmute";
		
		public static const PLAY_COMPLETE:String = "AudioEvent.onPlayComplete";
		public static const PLAY_PROGRESS:String = "AudioEvent.onPlayProgress";
		public static const PLAY:String = "AudioEvent.onPlay";
		public static const STOP:String = "AudioEvent.onStop";
		public static const PAUSE:String = "AudioEvent.onPause";
		public static const RESUME:String = "AudioEvent.onResume";
		public static const CLOSE:String = "AudioEvent.onClose";		
		
		public function AudioEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}