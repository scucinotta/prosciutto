package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class CallEvent extends GenericEvent
	{		
		public static const RESULT:String = "CallEvent.onResult";
		public static const FAULT:String = "CallEvent.onFault";
		
		public function CallEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}