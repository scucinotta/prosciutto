package com.bedrockframework.plugin.event
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class TriggerEvent extends TimerEvent
	{
		public static  const START:String = "TriggerEvent.onStart";
		public static  const STOP:String = "TriggerEvent.onStop";
		public static  const TRIGGER:String = "TriggerEvent.onTrigger";
		
		public var origin:Object;
		public var details:Object;
		
		public function TriggerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type,$bubbles,$cancelable);
			this.origin=$origin;
			this.details=$details;
		}
		override public function clone():Event
		{
			var strName:String=getQualifiedClassName(this);
			var clsClone:Class = getDefinitionByName(strName) as Class;
			return new clsClone(this.type,this.origin,this.details, this.bubbles, this.cancelable);
		}
	}
}