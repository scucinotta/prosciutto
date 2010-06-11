package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class VideoEvent extends GenericEvent
	{
		public static const STREAM_BUFFER_EMPTY:String = "NetStream.Buffer.Empty";
		public static const BUFFER_EMPTY:String = "VideoEvent.onBufferEmpty";
		public static const BUFFER_FULL:String = "NetStream.Buffer.Full";
		public static const BUFFER_FLUSH:String = "NetStream.Buffer.Flush";
		public static const BUFFER_PROGRESS:String = "VideoEvent.onBufferProgress";
		
		public static const LOAD_PROGRESS:String = "VideoEvent.onLoadProgress";
		public static const LOAD_COMPLETE:String = "VideoEvent.onLoadComplete";
		public static const QUEUE_COMPLETE:String = "VideoEvent.onQueueComplete";
		
		public static const PUBLISH_START:String = "NetStream.Publish.Start";
		public static const PUBLISH_BADNAME:String = "NetStream.Publish.BadName";
		public static const PUBLISH_IDLE:String = "NetStream.Publish.Idle";
		public static const PUBLISH_FAILED:String = "NetStream.Unpublish.Success";
		
		public static const PLAY_START:String = "NetStream.Play.Start";
		public static const PLAY_STOP:String = "NetStream.Play.Stop";
		public static const PLAY_FAILED:String = "NetStream.Play.Failed";
		public static const PLAY_PROGRESS:String = "VideoEvent.onPlayProgress";
		public static const PLAY_STATUS:String = "VideoEvent.onPlayStatus";
		public static const PLAY_COMPLETE:String = "VideoEvent.onComplete";
		
		public static const CONNECTION_CLOSED:String = "NetConnection.Connect.Closed";
		public static const CONNECTION_FAILED:String = "NetConnection.Connect.Failed";
		public static const CONNECTION_SUCCESS:String = "NetConnection.Connect.Success";
		public static const CONNECTION_REJECTED:String = "NetConnection.Connect.Rejected";
		public static const CONNECTION_SHUTDOWN:String = "NetConnection.Connect.AppShutdown";
		public static const CONNECTION_INVALID:String = "NetConnection.Connect.InvalidApp";
		
		public static const ERROR:String = "VideoEvent.onError";
		
		public static const CUE_POINT:String = "VideoEvent.onCuePoint";
		public static const META_DATA:String = "VideoEvent.onMetaData";
		
		public static const SEEK_START:String = "VideoEvent.onSeekStart"
		public static const SEEK_FAILED:String = "NetStream.Seek.Failed";
		public static const SEEK_INVALID:String = "NetStream.Seek.InvalidTime";
		public static const SEEK_COMPLETE:String = "NetStream.Seek.Notify";
		
		public static const PAUSE:String = "VideoEvent.onPause";
		public static const RESUME:String = "VideoEvent.onResume";
		
		public static const STOP:String = "VideoEvent.onStop";
		public static const CLEAR:String = "VideoEvent.onClear";
		
		public static const PANNING:String = "VideoEvent.onPanning";
		public static const VOLUME:String = "VideoEvent.onVolume";
		public static const MUTE:String = "VideoEvent.onMute";
		public static const UNMUTE:String = "VideoEvent.onUnmute";
		
		public function VideoEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}