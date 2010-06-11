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
 **/
package com.bedrockframework.core.base
{
	import com.bedrockframework.core.logging.LogLevel;
	import com.bedrockframework.core.logging.Logger;
	
	/**
	 * The StaticWidget class is meant to serve as a base for any class that will only contain static methods. If a user tries to create a new instance an error will be thrown.
	 */
	public class StaticWidget
	{
		public function StaticWidget()
		{
			Logger.log(this, LogLevel.ERROR, "Cannot Instantiate static class!");
		}
	}
}