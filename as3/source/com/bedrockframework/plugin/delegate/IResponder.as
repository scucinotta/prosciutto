package com.bedrockframework.plugin.delegate
{
	public interface IResponder
	{
		function result($data:* = null):void;
		function fault($data:*  = null):void;
	}
}