package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class KeyboardCaptureEvent extends GenericEvent
	{
		public static const PHRASE_MATCHED:String = "KeyboardCaptureEvent";
		
		public function KeyboardCaptureEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}