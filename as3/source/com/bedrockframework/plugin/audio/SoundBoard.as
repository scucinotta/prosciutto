package com.bedrockframework.plugin.audio
{
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.data.SoundData;
	import com.bedrockframework.plugin.event.SoundEvent;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.ArrayUtil;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundBoard extends DispatcherWidget implements ISoundBoard
	{
		/*
		Variable Declarations
		*/
		private var _mapSounds:HashMap;
		/*
		Constructor
		*/
		public function SoundBoard()
		{
			this._mapSounds = new HashMap();
		}
		
		/*
		Add a new sound
		*/
		public function add( $data:SoundData ):void
		{
			this._mapSounds.saveValue($data.alias, $data );
		}
		public function remove($alias:String):void
		{
			this._mapSounds.removeValue($alias);
		}
		public function load($alias:String, $url:String, $completeHandler:Function):void
		{
		
		}
		/*
		Yay
		*/
		public function play($alias:String, $startTime:Number = 0, $delay:Number = 0, $loops:int = 0, $volume:Number = 1, $panning:Number = 0):SoundChannel
		{
			var objData:SoundData = this.getDataByAlias($alias);
			if ( objData != null ) {
				objData.startTime = $startTime;
				objData.delay = $delay;
				objData.loops = $loops;
				objData.volume = $volume;
				objData.panning = $panning;
				objData.transform = new SoundTransform( objData.volume, objData.panning );
				return this.playImmediate(objData);
			} else {
				this.warning( "Sound not available - " + $alias );
				return null;
			}
		}
		private function playConditional($data:SoundData):SoundChannel
		{
			if ( $data.delay == 0 ) {
				return this.playImmediate($data);
			} else {
				this.playDelay($data);
				return null;
			}
		}
		private function playImmediate($data:SoundData):SoundChannel
		{
			var objData:SoundData = $data;
			objData.playing = true;
			objData.channel = objData.sound.play(objData.startTime, objData.loops, objData.transform );
			objData.mixer.target = objData.channel;
			//objData.channel.addEventListener( Event.SOUND_COMPLETE, this.onSoundComplete );
			return objData.channel;
		}
		private function playDelay($data:SoundData):void
		{
			TweenLite.delayedCall( $data.delay, this.playImmediate, [$data] );
		}
		public function close($alias:String):void
		{
			var objData:SoundData = this.getDataByAlias( $alias );
			if ( objData.playing ) {
				objData.playing = false;
				objData.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete );
				objData.sound.close();
			}
		}
		public function stop($alias:String):void
		{
			var objData:SoundData = this.getDataByAlias( $alias );
			if ( objData.playing ) {
				objData.playing = false;
				objData.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete );
				objData.channel.stop();
			}
		}
		public function pause( $alias:String ):void
		{
			var objData:SoundData = this.getDataByAlias( $alias );
			if ( objData.playing ) {
				objData.resumeTime = objData.channel.position;
				objData.playing = false;
				objData.channel.stop();
			}
		}
		public function resume( $alias:String ):void
		{
			var objData:SoundData = this.getDataByAlias( $alias );
			if ( !objData.playing ) {
				this.play( $alias, objData.resumeTime, objData.delay, objData.loops, objData.volume, objData.panning );
			}
		}
		/*
		Get Data
		*/
		private function getDataByChannel($channel:SoundChannel):SoundData
		{
			var arrData:Array = this._mapSounds.getValues();
			return ArrayUtil.findItem(arrData, $channel, "channel");
		}
		private function getDataByAlias($alias:String):SoundData
		{
			return this._mapSounds.getValue($alias);
		}
		public function getData($alias:String):SoundData
		{
			return this.getDataByAlias( $alias );
		}
		/*
		Volume Functions
		*/
		public function setVolume($alias:String, $value:Number):void
		{
			this.getDataByAlias( $alias ).mixer.volume = $value;
		}
		public function getVolume($alias:String):Number
		{
			return this.getDataByAlias( $alias ).mixer.volume;
		}
		/*
		Pan Functions
		*/
		public function setPanning($alias:String, $value:Number):void
		{
			this.getDataByAlias( $alias ).mixer.panning = $value;
		}
		public function getPanning($alias:String):Number
		{
			return this.getDataByAlias( $alias ).mixer.panning;
		}
		/*
		Fade Functions
		*/
		public function fadeVolume($alias:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objData:SoundData = this.getDataByAlias( $alias );
			if ( !objData.playing ) this.play($alias, 0, 0, 0, 0, 0);
			objData.mixer.fadeVolume( $value, $time, $handlers );
		}
		
		public function fadePanning($alias:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objData:SoundData = this.getDataByAlias( $alias );
			if ( !objData.playing ) this.play($alias, 0, 0, 0, 0, 0);
			objData.mixer.fadePanning( $value, $time, $handlers );
		}
		/*
		Mute/ Unmute
		*/
		public function mute( $alias:String ):void
		{
			this.getDataByAlias( $alias ).mixer.mute();
		}
		public function unmute( $alias:String ):void
		{
			this.getDataByAlias( $alias ).mixer.unmute();
		}
		public function toggleMute( $alias:String ):Boolean
		{
			return this.getDataByAlias( $alias ).mixer.toggleMute();
		}
		public function isMuted( $alias:String ):Boolean
		{
			return this.getDataByAlias( $alias ).mixer.toggleMute();
		}
		/*
		Event Handlers
		*/
		private function onSoundComplete($event:Event):void
		{
			var objData:SoundData = this.getDataByChannel($event.target as SoundChannel);
			objData.playing = false;
			objData.channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
			
			this.dispatchEvent( new SoundEvent(SoundEvent.SOUND_COMPLETE, this, objData) );
		}
	}
}