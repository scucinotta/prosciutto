package com.bedrockframework.plugin.audio
{
	import flash.media.SoundTransform;
	
	public interface IAudioMixer
	{
		function mute():void;
		function unmute():void;
		function toggleMute():Boolean;
		/*
		Fade Functions
		*/
		function fadeVolume( $value:Number, $time:Number, $handlers:Object = null ):void;
		function fadePanning( $value:Number, $time:Number, $handlers:Object = null ):void;
		/*
		Property Definitions
	 	*/
		/**
		* Change the global sound volume of the application.
		* @param value The volume, ranging from 0 (silent) to 1 (full volume). 
	 	*/
		function set volume($value:Number):void;
		function get volume():Number;
		/**
		* Change the global sound panning of the application.
		* @param value The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). A value of 0 represents no panning (center). 
	 	*/
		function set panning($value:Number):void;
		function get panning():Number;
		
		function get isMuted():Boolean;
	}
}