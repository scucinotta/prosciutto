package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.ILocaleManager;
	import com.bedrockframework.engine.bedrock;
	import com.bedrockframework.plugin.util.ArrayUtil;
	
	public class LocaleManager extends StandardWidget implements ILocaleManager
	{
		/*
		Variable Declarations
		*/
		private var _strDelimiter:String;
		private var _strDefaultLocale:String;
		private var _strCurrentLocale:String;
		private var _arrLocales:Array;
		private var _arrLocalizedFiles:Array;
		/*
		Constructor
		*/
		public function LocaleManager()
		{
			this._arrLocales = new Array;
			this._arrLocalizedFiles = new Array;
		}
		public function initialize( $localizedFiles:Array, $locales:Array, $defaultLocale:String = null, $currentLocale:String = null, $delimiter:String = "_" ):void
		{
			this._arrLocalizedFiles = $localizedFiles;
			this._arrLocales = $locales;
			this._strDefaultLocale = $defaultLocale;
			this._strCurrentLocale = $currentLocale || this._strDefaultLocale;
			this._strDelimiter = $delimiter;
		}
		
		public function load($locale:String = null ):void
		{
			if ( !this.isLocaleAvailable($locale) ) {
				this.warning( "Locale not available - " + $locale );
			} else {
				this.status( "Loading Locale - " + $locale );
				this._strCurrentLocale = $locale;
				BedrockEngine.bedrock::fileManager.load( this._strCurrentLocale );
			}
		}
		
		public function isLocaleAvailable($locale:String):Boolean
		{
			return ArrayUtil.containsItem( this._arrLocales, $locale );
		}
		public function isFileLocalized( $file:String ):Boolean
		{
			return ( ArrayUtil.findIndex( this._arrLocalizedFiles, $file ) != -1 );
		}
		/*
		Property Definitions
		*/
		public function set delimiter( $delimiter:String ):void
		{
			this._strDelimiter = $delimiter;
		}
		public function get delimiter():String
		{
			return this._strDelimiter;
		}
		public function get locales():Array
		{
			return this._arrLocales;
		}
		public function get currentLocale():String
		{
			return this._strCurrentLocale;
		}
		public function get defaultLocale():String
		{
			return this._strDefaultLocale;
		}
	}
}