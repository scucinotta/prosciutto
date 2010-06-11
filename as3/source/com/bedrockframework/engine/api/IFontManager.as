package com.bedrockframework.engine.api
{
	import com.bedrockframework.plugin.loader.VisualLoader;
	
	public interface IFontManager
	{
		function load($url:String ):void;
		function get loader():VisualLoader;
	}
}