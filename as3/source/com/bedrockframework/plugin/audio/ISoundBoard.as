package com.bedrockframework.plugin.audio
{
	import com.bedrockframework.plugin.data.SoundData;
	
	import flash.media.SoundChannel;
	
	public interface ISoundBoard
	{
		function add( $data:SoundData ):void;
		function load($alias:String, $url:String, $completeHandler:Function):void
		
		function play($alias:String, $startTime:Number = 0, $delay:Number = 0, $loops:int = 0, $volume:Number = 1, $panning:Number = 0):SoundChannel;
		function stop($alias:String):void;
		function close($alias:String):void;
		
		function pause($alias:String):void;
		function resume($alias:String):void;
		
		function setVolume($alias:String, $value:Number):void;
		function getVolume($alias:String):Number;
		function fadeVolume($alias:String, $value:Number, $time:Number, $handlers:Object = null ):void;
		
		function setPanning($alias:String, $value:Number):void;
		function getPanning($alias:String):Number;
		function fadePanning($alias:String, $value:Number, $time:Number, $handlers:Object = null ):void;
		
		function mute( $alias:String ):void;
		function unmute( $alias:String ):void;
		function toggleMute( $alias:String ):Boolean;
		function isMuted( $alias:String ):Boolean;
		
		function getData($alias:String):SoundData;
	}
}