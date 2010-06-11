package com.bedrockframework.engine.api
{
	import flash.display.DisplayObjectContainer;
	
	public interface IConfig
	{
		function initialize($data:String, $url:String, $root:DisplayObjectContainer ):void;
		
		function outputValues():void;
		/*
		Save the page information for later use.
		*/
		function addPage($alias:String, $data:Object):void;
		/**
		 * Returns a framework setting independent of environment.
	 	*/
		function getSettingValue($key:String):*;
		function saveSettingValue($key:String, $value:*):void;
		/**
		 * Returns a environment value that will change depending on the current environment.
		 * Environment values are declared in the config xml file.
	 	*/
		function getEnvironmentValue($key:String):*;
		
		function getParamValue($key:String):*;
		
		function getAvailableValue($key:String):*;
		/*
		Pull the information for a specific page.
		*/
		function getPage($alias:String):Object;
		function getPages():Array;
		
		
		function parseParamObject($data:Object):void;
		function parseParamString($values:String, $variableSeparator:String ="&", $valueSeparator:String =  "="):void;
		
	}
}