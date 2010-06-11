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
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class RemoteLogger implements IRemoteLogger
	{
		/*
		Variable Declarations
		*/
		public var connection:URLLoader;
		public var request:URLRequest;
		/*
		Constructor
		*/
		public function RemoteLogger()
		{
			this.connection = new URLLoader;
			this.request = new URLRequest();
		}

		public function log($target:*, $category:int, $message:String):void
		{
			if (this.request.url != null) {
				this.connection.load(this.request);
			}
		}
		/*
		Property Definitions
	 	*/
		public function set loggerURL($url:String):void
		{
			this.request.url = $url;
		}
		public function get loggerURL():String
		{
			return this.request.url;
		}
	}
}