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
package com.bedrockframework.engine.view
{
	import com.bedrockframework.plugin.view.IView;
	
	public interface IPreloader extends IView
	{
		function displayProgress( $percent:uint ):void;
		function remove():void;
	}
}