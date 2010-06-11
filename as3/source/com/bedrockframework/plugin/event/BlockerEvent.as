package com.bedrockframework.plugin.event
{
	import flash.events.MouseEvent;
	import com.bedrockframework.core.event.GenericEvent;

	public class BlockerEvent extends GenericEvent
	{
		public static  const SHOW:String = "BlockerEvent.onShow";
		public static  const HIDE:String = "BlockerEvent.onHide";
		public static  const MOUSE_DOWN:String = "BlockerEvent.onMouseDown";
		public static  const MOUSE_UP:String = "BlockerEvent.onMouseUp";
		public static  const MOUSE_OVER:String = "BlockerEvent.onMouseOver";
		public static  const MOUSE_OUT:String = "BlockerEvent.onMouseOut";

		public function BlockerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}