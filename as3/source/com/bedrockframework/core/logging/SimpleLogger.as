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
	import com.bedrockframework.core.logging.ILogable;
	import com.bedrockframework.core.logging.LogLevel;
	import com.bedrockframework.core.logging.Logger;

	public class SimpleLogger implements ILogable
	{
		public function SimpleLogger()
		{
		}

		public function log($level:int, ...$arguments):void
		{
			Logger.send(this, $level, $arguments);
		}
		
		public function debug(...$arguments):void
		{
			Logger.send(this, LogLevel.DEBUG, $arguments);
		}
		
		public function error(...$arguments):void
		{
			Logger.send(this, LogLevel.ERROR, $arguments);
		}
		
		public function fatal(...$arguments):void
		{
			Logger.send(this, LogLevel.FATAL, $arguments);
		}
		
		public function status(...$arguments):void
		{
			Logger.send(this, LogLevel.STATUS, $arguments);
		}
		
		public function warning(...$arguments):void
		{
			Logger.send(this, LogLevel.WARNING, $arguments);
		}
		
		public function set silenceLogging($value:Boolean):void
		{
		}
		public function get silenceLogging():Boolean
		{
			return false;
		}
	}
}