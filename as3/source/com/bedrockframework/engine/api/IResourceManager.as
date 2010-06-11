package com.bedrockframework.engine.api
{
	import com.bedrockframework.plugin.loader.DataLoader;
	import com.bedrockframework.plugin.storage.IMap;
	
	public interface IResourceManager extends IMap
	{
		function load( $path:String ):void;
		function get loader():DataLoader;
		function get delegate():Class;
		function set delegate( $class:Class ):void;
	}
}