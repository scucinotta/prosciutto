package com.bedrockframework.engine.delegate
{
	import com.bedrockframework.core.base.BasicWidget;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.IPathDelegate;
	import com.bedrockframework.engine.data.BedrockData;

	public class DefaultPathDelegate extends BasicWidget implements IPathDelegate
	{
		public function DefaultPathDelegate()
		{
		}
		
		public function getFontPath( $locale:String = null ):String
		{
			var strPath:String = BedrockEngine.config.getEnvironmentValue( BedrockData.FONTS_PATH );
			strPath += BedrockEngine.config.getSettingValue( BedrockData.FONTS_FILE_NAME );
			
			if ( $locale == null ) {
				strPath += ".swf";
			} else {
				strPath += BedrockEngine.localeManager.delimiter + $locale + ".swf";
			}
			return strPath;
		}
		
		public function getCSSPath( $locale:String = null ):String
		{
			var strPath:String = BedrockEngine.config.getEnvironmentValue( BedrockData.CSS_PATH );
			strPath += BedrockEngine.config.getSettingValue( BedrockData.CSS_FILE_NAME );
			
			if ( $locale == null ) {
				strPath += ".css";
			} else {
				strPath += BedrockEngine.localeManager.delimiter + $locale + ".css";
			}
			return strPath;
		}
		
		public function getResourceBundlePath( $locale:String = null ):String
		{
			var strPath:String = BedrockEngine.config.getEnvironmentValue( BedrockData.RESOURCE_BUNDLE_PATH );
			strPath += BedrockEngine.config.getSettingValue( BedrockData.RESOURCE_BUNDLE_FILE_NAME );
			
			if ( $locale == null ) {
				strPath += ".xml";
			} else {
				strPath += BedrockEngine.localeManager.delimiter + $locale + ".xml";
			}
			return strPath;
		}
		
		public function getSharedPath( $locale:String = null ):String
		{
			var strPath:String = BedrockEngine.config.getEnvironmentValue( BedrockData.SHARED_PATH );
			strPath += BedrockEngine.config.getSettingValue( BedrockData.SHARED_FILE_NAME );
			
			if ( $locale == null ) {
				strPath +=  ".swf";
			} else {
				strPath += BedrockEngine.localeManager.delimiter + $locale + ".swf";
			}
			return strPath;
		}
		
	}
}