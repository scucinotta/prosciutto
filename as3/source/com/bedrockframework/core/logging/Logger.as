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
	import com.bedrockframework.core.base.StaticWidget;

	public class Logger extends StaticWidget
	{
		/*
		Variable Declarations
		*/
		public static var localLevel:int = LogLevel.ALL;
		public static var eventLevel:int = LogLevel.FATAL;
		public static var remoteLevel:int = LogLevel.FATAL;
		
		public static var formatter:ILogFormatter = new LogFormatter;
		
		public static var localLogger:ILogger = new LocalLogger;
		public static var eventLogger:ILogger = new EventLogger;
		public static var remoteLogger:IRemoteLogger = new RemoteLogger;
		
		
		public static function send($target:* = null, $category:int = 0, $arguments:Array = null):void
		{
			if ($arguments.length > 0) {
				var strMessage:String  = Logger.formatter.format($target, $category, $arguments);
				if ($category >= Logger.localLevel) {
					Logger.localLogger.log($target, $category, strMessage);
				}
				if ($category >= Logger.eventLevel) {
					Logger.eventLogger.log($target, $category, strMessage);
				}
				if ($category >= Logger.remoteLevel) {
					Logger.remoteLogger.log($target, $category, strMessage);
				}
			} else {
				throw new ArgumentError("Incorrect number of arguments!");
			}
		}
		
		public static function log($target:* = null, $category:int = 0, ...$arguments:Array):void
		{
			Logger.send($target, $category, $arguments);
		}
		
		public static function debug($target:* = null, ...$arguments):void
		{
			Logger.send($target, LogLevel.DEBUG, $arguments);
		}
		
		public static function attention($target:* = null, ...$arguments):void
		{
			Logger.send($target, LogLevel.ATTENTION, $arguments);
		}
		
		public static function error($target:* = null, ...$arguments):void
		{
			Logger.send($target, LogLevel.ERROR, $arguments);
		}
		
		public static function fatal($target:* = null, ...$arguments):void
		{
			Logger.send($target, LogLevel.FATAL, $arguments);
		}
		
		public static function status($target:* = null, ...$arguments):void
		{
			Logger.send($target, LogLevel.STATUS, $arguments);
		}
		
		public static function warning($target:* = null, ...$arguments):void
		{
			Logger.send($target, LogLevel.WARNING, $arguments);
		}
		
		/*
		Property Definitions
	 	*/
		public static function set filter($value:String):void
		{
		}
		public static function get filter():String 
		{
			return ""
		}
		
		
		public static function set remoteLogURL($url:String):void
		{
			Logger.remoteLogger.loggerURL = $url;
		}
	}
}
