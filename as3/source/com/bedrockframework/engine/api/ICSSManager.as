package com.bedrockframework.engine.api
{
	import com.bedrockframework.plugin.loader.DataLoader;
	
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	
	public interface ICSSManager
	{
		/*
		Parse the StyleSheet
		*/
		function parseCSS($stylesheet:String):void;
		/*
		Apply Tag
		*/
		function applyTag($text:String, $tag:String):String;
		/*
		Apply Style
		*/
		function applyClass($text:String, $style:String):String;
		/*
		Get Style Object
		*/
		function getStyleAsObject($style:String):Object;
		/*
		Get Text Format Object
		*/
		function getStyleAsTextFormat($style:String):TextFormat;
		/*
		Property Definitions
		*/
		function get styleNames():Array;
		function get styleSheet():StyleSheet;
		
		function get loader():DataLoader;
	}
}