package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class CallQueueEvent extends GenericEvent
	{
		
		public static const BEGIN:String="CallQueueEvent.onBegin";
		public static const NEXT:String = "CallQueueEvent.onNext";
		public static const COMPLETE:String = "CallQueueEvent.onComplete";
		public static const PROGRESS:String = "CallQueueEvent.onProgress";
		public static const RESET:String = "CallQueueEvent.onReset";
		public static const ERROR:String="CallQueueEvent.onError";
		
		public function CallQueueEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}