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

	/**
	 * The StandardWidget class is meant to serve as a base for any class.
	 */
	public class StandardWidget extends BasicWidget
	{
		public function StandardWidget()
		{
			this.log( LogLevel.CONSTRUCTOR, "Constructed" );
		}
	}
}