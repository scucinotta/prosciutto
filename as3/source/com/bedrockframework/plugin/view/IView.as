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
package com.bedrockframework.plugin.view
{
	
	public interface IView
	{
		function initialize($data:Object=null):void;
		function intro($data:Object=null):void;
		function outro($data:Object=null):void;
		function clear():void;
	}
}