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
package com.bedrockframework.core.logging
{

	/**
	 *  All loggers within the logging framework must implement this interface.
	 */
	public interface ILogable
	{
	
		function log($level:int,...$arguments:Array):void;
		function debug(...$arguments:Array):void;
		function error(...$arguments:Array):void;
		function fatal(...$arguments:Array):void;
		function status(...$arguments:Array):void;
		function warning(...$arguments:Array):void;
		
		function set silenceLogging($value:Boolean):void;
		
		function get silenceLogging():Boolean;

	}

}