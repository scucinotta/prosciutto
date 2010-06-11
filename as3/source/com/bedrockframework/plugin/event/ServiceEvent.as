package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class ServiceEvent extends GenericEvent
	{
		public static const CONNECTION_ERROR:String = "ServiceEvent.onConnectionError";
		public static const STATUS:String = "ServiceEvent.onStatus";
		
		
		public function ServiceEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}