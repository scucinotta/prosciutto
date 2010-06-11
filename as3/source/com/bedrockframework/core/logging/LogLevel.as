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
	public class LogLevel
	{
		/**
	     *  Designates events that are very
	     *  harmful and will eventually lead to application failure.
	     */
	    public static const FATAL:int = 1000;
	
	    /**
	     *  Designates error events that might
	     *  still allow the application to continue running.
	     */
	    public static const ERROR:int = 10;
	    
	    /**
	     *  Designates events that could be
	     *  harmful to the application operation.
	     */
	    public static const WARNING:int = 8;
	    
	    public static const ATTENTION:int = 7;
	    /**
	     *  Designates informational level
	     *  messages that are fine grained and most helpful when debugging an
	     *  application.
	     */
	    public static const DEBUG:int = 6;
	    
	    /**
	     *  Designates informational messages that
	     *  highlight the progress of the application at coarse-grained level.
	     */
	    public static const STATUS:int = 4;	
	    
	    public static const CONSTRUCTOR:int = 2;	    
	    
	    /**
	     *  Tells a target to process all messages.
	     */
	    public static const ALL:int = 0;
	    
	     /**
	     *  Tells a target to process no messages.
	     */
	    public static const NONE:int = int.MAX_VALUE;
	}
}