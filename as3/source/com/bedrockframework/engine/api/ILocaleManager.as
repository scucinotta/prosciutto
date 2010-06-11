package com.bedrockframework.engine.api
{
	public interface ILocaleManager
	{
		function initialize( $localizedFiles:Array, $locales:Array, $defaultLocale:String = null, $currentLocale:String = null, $delimiter:String = "_" ):void
		function load($locale:String = null ):void;
		function isLocaleAvailable($locale:String):Boolean;
		function isFileLocalized($file:String):Boolean;
		
		function set delimiter( $delimiter:String ):void;
		function get delimiter():String;
		function get locales():Array;
		function get currentLocale():String;
		function get defaultLocale():String;
	}
}