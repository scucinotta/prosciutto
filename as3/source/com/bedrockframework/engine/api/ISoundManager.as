package com.bedrockframework.engine.api
{
	import com.bedrockframework.plugin.audio.ISoundBoard;
	import com.bedrockframework.plugin.data.SoundData;
	
	import flash.media.SoundChannel;
	
		
	public interface ISoundManager extends ISoundBoard
	{
		function initialize($sounds:Array = null):void;
	}
}