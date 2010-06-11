package com.bedrockframework.engine.api
{
	import com.bedrockframework.engine.view.IPreloader;
	
	public interface IPreloaderManager
	{
		function initialize( $shellPreloaderTime:Number = 0, $pagePreloaderTime:Number = 0 ):void;
		function setMode( $status:String ):void;
	}
}