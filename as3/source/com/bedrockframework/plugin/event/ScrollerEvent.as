package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;
	
	import flash.events.MouseEvent;

	public class ScrollerEvent extends GenericEvent
	{
		public static  const RESET:String = "ScrollerEvent.onReset";
		public static  const UPDATE:String = "ScrollerEvent.onUpdate";
		public static  const CHANGE:String = "ScrollerEvent.onChange";		
		public static  const SHOW_SCROLLER:String = "ScrollerEvent.onShowScroller";
		public static  const HIDE_SCROLLER:String = "ScrollerEvent.onHideScroller";
		
		public static  const START_DRAG:String = "ScrollerEvent.onStartDrag";
		public static  const STOP_DRAG:String = "ScrollerEvent.onStopDrag";

		public function ScrollerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}