package com.bedrockframework.plugin.controller
{
	import com.bedrockframework.plugin.data.ScrollerData;
	import com.bedrockframework.plugin.gadget.Scroller;
	
	public interface IScrollerController
	{
		function initialize( $scroller:Scroller, $data:ScrollerData ):void;
		/**
		This function is used to refresh the size calculations made by the scroller. Call this function if the content size has changed since the scroller was initialized.
		 */ 
		function refresh():void;
		function reset():void;
		
		function moveScrubber( $position:Number ):void;
		function moveContent( $position:Number ):void;
		function moveWithIncrement( $increment:Number=0 ):void;
	}
}