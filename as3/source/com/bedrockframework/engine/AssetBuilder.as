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
package com.bedrockframework.engine
{
	import com.bedrockframework.core.base.MovieClipWidget;
	
	public class AssetBuilder extends MovieClipWidget
	{
		public function AssetBuilder()
		{
			this.visible = false;
		}
		
		protected function addView( $alias:String, $linkage:String ):void
		{
			BedrockEngine.assetManager.addView( $alias, $linkage );
		}
		protected function addPreloader( $alias:String, $linkage:String ):void
		{
			BedrockEngine.assetManager.addPreloader( $alias, $linkage );
		}
		protected function addBitmap( $alias:String, $linkage:String ):void
		{
			BedrockEngine.assetManager.addBitmap( $alias, $linkage );
		}
		protected function addSound( $alias:String, $linkage:String ):void
		{
			BedrockEngine.assetManager.addSound( $alias, $linkage );
		}
	}
}