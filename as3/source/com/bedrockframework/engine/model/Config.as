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
package com.bedrockframework.engine.model
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.api.IConfig;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.plugin.util.StringUtil;
	import com.bedrockframework.plugin.util.VariableUtil;
	import com.bedrockframework.plugin.util.XMLUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.system.Capabilities;	
	
	public class Config extends StandardWidget implements IConfig
	{
		/*
		Variable Declarations
		*/		
		private var _objSettingValues:Object;
		private var _objEnvironmentValues:Object;
		private var _objPageValues:Object;
		private var _objParamValues:Object;
		private var _arrPages:Array;
		/*
		Constructor
		*/
		public function Config()
		{
			this._objSettingValues = new Object;
			this._objEnvironmentValues = new Object;
			this._objPageValues = new Object;
			this._objParamValues = new Object;
			this._arrPages = new Array;
		}
		/*
		Initialize
		*/
		public function initialize( $data:String, $url:String, $root:DisplayObjectContainer ):void
		{
			this.saveSettingValue(BedrockData.URL, $url);
			this.saveSettingValue(BedrockData.MANUFACTURER, Capabilities.manufacturer);
			this.saveSettingValue(BedrockData.SYSTEM_LANGUAGE, Capabilities.language);
			this.saveSettingValue(BedrockData.OS, Capabilities.os);
			
			this.saveSettingValue( BedrockData.ROOT, $root );
			
			this.parseXML($data);
		}

		
		private function parseXML($data:String):void
		{
			var xmlConfig:XML = this.getXML($data);
			
			this.parseSettingsValues( xmlConfig.settings.general );
			this.parseSettingsValues( xmlConfig.settings.file_names );
			
			this.saveSettingValue( BedrockData.LAYOUT, XMLUtil.convertToArray( xmlConfig.layout, true ) );
			this.saveSettingValue( BedrockData.DEFAULT_PAGE, this.getDefaultPage( xmlConfig.pages ) );
			
			var strEnvironment:String = this.getSettingValue( BedrockData.FORCE_ENVIRONMENT ) || this.getEnvironment( xmlConfig.environments, this.getSettingValue( BedrockData.URL ) );
			this.saveSettingValue( BedrockData.ENVIRONMENT,  strEnvironment);
			this.saveEnvironmentValues( xmlConfig.environments, strEnvironment);
			
			this.saveLocaleSettings( xmlConfig.settings.locale );
			this.saveCacheSettings();
			
			this.parsePages( xmlConfig.pages );
		}
		private function getXML($data:String):XML
		{
			var xmlConfig:XML = new XML($data);
			XML.ignoreComments=true;
			XML.ignoreWhitespace=true;
			return xmlConfig;
		}
		public function outputValues():void
		{
			this.attention("Environment - " + this.getSettingValue(BedrockData.ENVIRONMENT));
			this.attention( this._objParamValues );
			this.attention( this._objSettingValues );
			this.attention( this._objEnvironmentValues );
		}
		/*
		Settings Functions
		*/
		private function parseSettingsValues($node:XMLList):void
		{
			var objData:Object = XMLUtil.convertToObject($node);
			for (var d:String in objData) {
				this.saveSettingValue(d, objData[d]);
			}
		}
		private function saveCacheSettings():void
		{
			if (this.getSettingValue(BedrockData.CACHE_PREVENTION_ENABLED)) {
				this.saveSettingValue(BedrockData.CACHE_KEY, StringUtil.generateUniqueKey(10) );
			} else {
				this.saveSettingValue(BedrockData.CACHE_KEY, "");
			}
		}
		public function saveSettingValue($key:String, $value:*):void
		{
			this._objSettingValues[ $key ] = $value;
		}
		/**
		 * Returns a framework setting independent of environment.
	 	*/
		public function getSettingValue($key:String):*
		{
			return this._objSettingValues[ $key ];
		}
		/*
		Environment Functions
		*/
		private function getEnvironment($node:XMLList, $url:String):String
		{
			var strURL:String = $url;
			var xmlEnvironments:XML=new XML($node);
			var xmlPatterns:XML
			var strEnvironmentName:String;
			var numOuterLength:int = xmlEnvironments.children().length();
			var numInnerLength:int;
			var strPattern:String
			for (var i:int = 0 ; i < numOuterLength; i ++) {
				strEnvironmentName = XMLUtil.getAttributeObject(xmlEnvironments.environment[i]).name;
				try {
					xmlPatterns = new XML(xmlEnvironments.environment[i].patterns);
					numInnerLength = xmlPatterns.children().length();
				} catch($error:Error){
					numInnerLength =0;
				}
				for (var p: int =0; p < numInnerLength; p++) {
					strPattern = xmlPatterns.child(p).toString();
					if (strURL.indexOf(strPattern) > -1) {
						return strEnvironmentName;
					}
				}
			}			
			return BedrockData.PRODUCTION;
		}
		private function saveEnvironmentValues($node:XMLList, $environment:String):void
		{
			var xmlData:XML = new XML($node);
			
			this.parseEnvironmentValues( XMLUtil.filterByAttribute( xmlData, "name", BedrockData.DEFAULT ) );
			this.parseEnvironmentValues( XMLUtil.filterByAttribute( xmlData, "name", $environment ) );
			
			delete this._objEnvironmentValues["patterns"];
		}
		
		private function parseEnvironmentValues( $xml:XML ):void
		{
			var objData:Object = XMLUtil.convertToObject($xml);
			for (var d:String in objData) {
				this.saveEnvironmentValue(d, objData[d]);
			}
		}
		public function saveEnvironmentValue($key:String, $value:*):void
		{
			this._objEnvironmentValues[ $key ] = $value;
		}
		/**
		 * Returns a environment value that will change depending on the current environment.
		 * Environment values are declared in the config xml file.
	 	*/
		public function getEnvironmentValue($key:String):*
		{
			return this._objEnvironmentValues[ $key ]; 
		}
		/*
		Pages Functions
		*/
		private function parsePages($node:XMLList):void
		{
			var xmlPages:XML=new XML($node);
			var xmlPage:XMLList;
			//
			var objPage:Object;
			for (var s:String in xmlPages.children()) {
				objPage=new Object();
				xmlPage=xmlPages.child(s);
				for (var d:String in xmlPage.children()) {
					if (! xmlPage.child(d).hasComplexContent()) {
						objPage[xmlPage.child(d).name()]=XMLUtil.convertValue(xmlPage.child(d));
					} else {
						if (xmlPage.child(d).name() == "files") {
							objPage[xmlPage.child(d).name()]=this.sanitizePaths(xmlPage.child(d));
						} else {
							objPage[xmlPage.child(d).name()]=XMLUtil.convertToArray(xmlPage.child(d));
						}
					}
				}
				this.addPage( objPage.alias, objPage);
			}
		}
		public function addPage($alias:String, $data:Object):void
		{
			this._objPageValues[$alias] = $data;
			this._arrPages.push( $data );
		}
		private function savePages($value:*):void
		{
			this._objPageValues = $value;
		}
		public function getPage($key:String):Object
		{
			var objPage:Object= this._objPageValues[ $key ];
			if (objPage == null) {
				this.warning("Page \'" + $key + "\' does not exist!");
			}
			return objPage;
		}
		public function getPages():Array
		{
			return this._arrPages;
		}
		
		private function getDefaultPage($node:XMLList):String
		{
			var xmlData:XML = new XML($node);
			var xmlDefaultPage:XML = XMLUtil.filterByAttribute($node, BedrockData.DEFAULT_PAGE, "true");
			return XMLUtil.convertValue(xmlDefaultPage.alias);
		}
		/*
		Locales
		*/
		private function saveLocaleSettings( $node:XMLList ):void
		{
			if ( this.getSettingValue( BedrockData.LOCALE_ENABLED ) ) {
				
				var objData:Object = XMLUtil.convertToObject( $node );
				for ( var d:String in objData ) {
					this.saveSettingValue( d, objData[ d ] );
				}
				
				this.parseLocales();
				this.parseLocalizedFiles();
				
				if ( this.getSettingValue( BedrockData.LOCALE_LIST ).length > 0 && this.getSettingValue( BedrockData.DEFAULT_LOCALE ) == null ) {
					this.saveSettingValue( BedrockData.DEFAULT_LOCALE, this.getSettingValue( BedrockData.LOCALE_LIST )[ 0 ] );	
				}
				this.saveSettingValue( BedrockData.CURRENT_LOCALE, this.getSettingValue( BedrockData.DEFAULT_LOCALE ) );
				
			}
		}
		private function parseLocales():void
		{
			var strLocales:String = this._objSettingValues[ BedrockData.LOCALE_LIST ];
			if ( strLocales.length > 0 ) {
				var arrLocales:Array = strLocales.split( "," );
				var numLength:int = arrLocales.length;
				for (var i:int = 0; i < numLength; i ++) {
					arrLocales[ i ] = StringUtil.trim( arrLocales[ i ] );
				}
				this.saveSettingValue( BedrockData.LOCALE_LIST, arrLocales );
			} else {
				this.saveSettingValue( BedrockData.LOCALE_LIST, new Array );
			}
		}
		private function parseLocalizedFiles():void
		{
			var strLocales:String = this._objSettingValues[ BedrockData.LOCALIZED_FILES ];
			if ( strLocales.length > 0 ) {
				var arrLocales:Array = strLocales.split( "," );
				var numLength:int = arrLocales.length;
				for (var i:int = 0; i < numLength; i ++) {
					arrLocales[ i ] = StringUtil.trim( arrLocales[ i ] );
				}
				this.saveSettingValue( BedrockData.LOCALIZED_FILES, arrLocales );
			} else {
				this.saveSettingValue( BedrockData.LOCALIZED_FILES, new Array );
			}
		}
		
		/*
		Param Functions
		*/
		public function parseParamObject($data:Object):void
		{
			for (var d:String in $data){
				this.saveParamValue( d, VariableUtil.sanitize($data[d]) ); 
			}
		}
		public function parseParamString($values:String, $variableSeparator:String ="&", $valueSeparator:String =  "="):void
		{
			if ($values != null) {
				var strValues:String = $values;
				var strVariableSeparator:String = $variableSeparator;
				var strValueSeparator:String = $valueSeparator;
				//
				var arrValues:Array = strValues.split( strVariableSeparator );
				var numLength:int = arrValues.length;
				for (var v:int = 0; v < numLength; v++) {
					var arrVariable:Array = arrValues[v].split(strValueSeparator);
					this.saveParamValue( arrVariable[0], arrVariable[1] ); 
				}
			} else {
				this.warning("No params to parse!");
			}
		}
		public function saveParamValue($key:String, $value:*):void
		{
			this._objParamValues[ $key ] = $value;
		}
		public function getParamValue($key:String):*
		{
			return this._objParamValues[ $key ];
		}
		/*
		Get Available
		*/
		public function getAvailableValue( $key:String ):*
		{
			return this.getParamValue( $key ) || this.getEnvironmentValue( $key ) || this.getSettingValue( $key ) || "";
		}
		/*
		Internal string replacement functions
		*/
		private function sanitizePaths($node:XMLList):Array
		{
			var arrFiles:Array=XMLUtil.convertToArray( $node );
			var numLength:Number=arrFiles.length;
			for (var i:Number=0; i < numLength; i++) {
				arrFiles[ i ] = this.replacePathFlag( arrFiles[ i ] );
			}
			return arrFiles;
		}
		private function replacePathFlag($path:String):String
		{
			var numLastIndex:int=$path.lastIndexOf( "]" );
			var strName:String=$path.substring( 1, numLastIndex );
			var strFile:String=$path.substring( numLastIndex + 1, $path.length );
			var strPath:String=this.getEnvironmentValue( strName ) + strFile;
			return strPath;
		}
	}
}

