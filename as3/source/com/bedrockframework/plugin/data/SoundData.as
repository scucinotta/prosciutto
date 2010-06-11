package com.bedrockframework.plugin.data
{
	import com.bedrockframework.plugin.audio.AudioMixer;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundData
	{
		public var alias:String;
		public var time:Number;
		public var startTime:Number;
		public var delay:Number;
		public var loops:int;
		public var panning:Number;
		public var volume:Number;
		public var playing:Boolean;
		public var allowMultiple:Boolean;
		
		public var resumeTime:Number;
		
		public var sound:Sound;
		public var channel:SoundChannel;
		public var transform:SoundTransform;
		public var mixer:AudioMixer;
				
		public function SoundData($alias:String, $sound:Sound, $allowMultiple:Boolean = true)
		{
			this.alias = $alias;
			this.playing = false;
			this.sound = $sound;
			this.time = 1;
			this.startTime = 0;
			this.resumeTime = 0;
			this.delay = 0;
			this.loops = 0;
			this.volume = 1;
			this.panning = 0;
			this.allowMultiple = $allowMultiple;
			this.mixer = new AudioMixer;
			this.transform = new SoundTransform;
		}

	}
}