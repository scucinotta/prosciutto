package com.bedrockframework.plugin.audio
{
	import com.bedrockframework.core.base.BasicWidget;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class AudioMixer extends BasicWidget
	{
		/*
		Variable Declarations
		*/
		private var _numVolume:Number;
		private var _objTarget:*;
		private var _objSoundTransform:SoundTransform;
		private var _bolMuted:Boolean;
		/*
		Constructor
		*/
		public function AudioMixer($target:* = null, $volume:Number = 1, $panning:Number = 0 )
		{
			this._numVolume = $volume;
			this._objSoundTransform = new SoundTransform($volume, $panning);
			this.target = $target || new Object;
		}
		private function applyTransform():void
		{
			this._objTarget.soundTransform = this._objSoundTransform;
		}
		/*
		Mute Functions
		*/
		public function mute():void
		{
			this._objSoundTransform.volume = 0;
			this.applyTransform();
			this._bolMuted = true;
		}
		public function unmute():void
		{
			this._objSoundTransform.volume = this._numVolume;
			this.applyTransform();
			this._bolMuted = false;
		}
		public function toggleMute():Boolean
		{
			if (this.volume != 0) {
				this.mute();
				return true;
			} else {
				this.unmute();
				return false;
			}
		}
		/*
		Fade Functions
		*/
		public function fadeVolume( $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objData:Object = $handlers || new Object;
			objData.volume = $value;
			objData.ease = Linear.easeNone;
			TweenLite.to( this, $time, objData );
		}
		public function fadePanning( $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objData:Object = $handlers || new Object;
			objData.panning = $value;
			objData.ease = Linear.easeNone;
			TweenLite.to( this, $time, objData );
		}
		/*
		Property Definitions
	 	*/
		/**
		* Change the global sound volume of the application.
		* @param value The volume, ranging from 0 (silent) to 1 (full volume). 
	 	*/
		public function set volume($value:Number):void
		{
			this._objSoundTransform.volume = $value;
			this._numVolume = $value;
			this.applyTransform();
		}
		
		public function get volume():Number
		{
			return this._objSoundTransform.volume;
		}
		/**
		* Change the global sound panning of the application.
		* @param value The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). A value of 0 represents no panning (center). 
	 	*/
		public function set panning($value:Number):void
		{
			this._objSoundTransform.pan =$value;
			this.applyTransform();
		}
		
		public function get panning():Number
		{
			return this._objSoundTransform.pan;
		}
		
		public function get isMuted():Boolean
		{
			return this._bolMuted;
		}
		
		public function set target($target:*):void
		{
			this._objTarget = $target;
			if ( $target is SoundChannel ) this._objSoundTransform = $target.soundTransform;
		}
		public function get target():*
		{
			return this._objTarget;
		}
		
		public function set transform( $transform:SoundTransform ):void
		{
			this._objSoundTransform = $transform;
			this.applyTransform();
		}
		public function get transform():SoundTransform
		{
			return this._objSoundTransform;
		}
	}
}