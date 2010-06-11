
package com.bedrockframework.plugin.storage
{

	public interface IMap
	{

		function saveValue($key:*, $value:*):void;
		function removeValue($key:*):void;
		function pullValue($key:*):*;
		
		function containsKey($key:*):Boolean;
		function containsValue($value:*):Boolean;
		
		function reset():void;
		function clear():void;
		
		function getKey($value:*):String;
		function getValue($key:*):*;
		function getKeys():Array;
		function getValues():Array;

		function get size():int;
		function get isEmpty():Boolean;
	}
}