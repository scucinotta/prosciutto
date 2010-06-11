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
	import com.bedrockframework.core.event.GenericEvent;

	public class CustomEvent extends GenericEvent
	{
		public function CustomEvent($type:String, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, this.target, $details, $bubbles, $cancelable);
			this.injectDetails(this.details);
		}
		private function injectDetails($details:Object):void
		{
			try {
				for (var d:String in $details) {
					this[d] = $details[d];
				}
			} catch($e:Error) {
				
			}
		}
	}
}