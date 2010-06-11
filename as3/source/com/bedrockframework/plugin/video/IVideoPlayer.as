package com.bedrockframework.plugin.video
{
	public interface IVideoPlayer
	{
		function play( $url:String = null ):void;
		function queue( $url:String = null ):void;
		function stop():void;
		function clear():void;
		/*
		Muting
		*/
		function mute():void;
		function unmute():void;
		function toggleMute():Boolean;
		/*
		Pausing
		*/
		function pause():void;
		function resume():void;
		/*
		Seek
		*/
		function seekWithTime($time:Number):void;
        function seekWithPercentage($percent:Number):void;
		/*
		Property Definitions
		*/
		function get isPaused():Boolean;
		function get duration():Number;
		function get position():Number;
		
		function set volume($value:Number):void;
		function get volume():Number;
		/**
		* Change the video's sound panning.
		* @param value The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). A value of 0 represents no panning (center). 
	 	*/
		function set panning($value:Number):void;
		function get panning():Number;
		
		function set autoQueue($value:Boolean):void;
		function get autoQueue():Boolean;
		
		function get isMuted():Boolean;
	}
}