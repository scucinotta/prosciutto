/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
*/
package com.bedrockframework.core.event
{
	import flash.events.Event;
	import flash.utils.*;

	public class GenericEvent extends Event
	{
		public var origin:Object;
		public var details:Object;
		/*
		Constructor
		*/
		public function GenericEvent($type:String, $origin:Object, $details:Object = null, $bubbles:Boolean=false, $cancelable:Boolean=true)
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