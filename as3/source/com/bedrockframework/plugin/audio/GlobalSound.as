package com.bedrockframework.plugin.audio
{
	/**
	* Manages the global sound within the flash application.
	*
	* @author Alex Toledo
	* @version 1.0.0
	* @created Sat Apr 3 2008 19:16:40 GMT-0400 (EDT)
	*/
	import com.bedrockframework.core.base.StandardWidget;
	
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	public class GlobalSound extends StandardWidget
	{
		/*
		Variable Declarations
		*/
		private var _objAudioMixer:AudioMixer
		private var _objSoundTransform:SoundTransform;
		private var _numVolume:Number;
		/*
		Constructor
		*/
		public function GlobalSound()
		{
			this._objAudioMixer = new AudioMixer;
		}
		
		public function mute():void
		{
			this._objAudioMixer.mute();
			this.applyTransform();
		}
		public function unmute():void
		{
			this._objAudioMixer.unmute();
			this.applyTransform();
		}
		public function toggleMute():Boolean
		{
			var bolMute:Boolean = this._objAudioMixer.toggleMute();
			this.applyTransform();
			return bolMute;
		}
		
		public function fadeVolume( $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objHandlers:Object = $handlers || new Object;
			objHandlers.onUpdate = this.applyTransform;
			this._objAudioMixer.fadeVolume( $value, $time, objHandlers );
		}
		public function fadePanning( $value:Number, $time:Number, $handlers:Object = null ):void
		{
			var objHandlers:Object = $handlers || new Object;
			objHandlers.onUpdate = this.applyTransform;
			this._objAudioMixer.fadePanning( $value, $time, objHandlers );
		}
		
		private function applyTransform():void
		{
			SoundMixer.soundTransform = this._objAudioMixer.transform;
		}
		/**
		* Change the global sound volume of the application.
		* @param value The volume, ranging from 0 (silent) to 1 (full volume). 
	 	*/
		public function set volume($value:Number):void
		{
			this._objAudioMixer.volume = $value;
			this.applyTransform();
		}
		
		public function get volume():Number
		{
			return this._objAudioMixer.volume;
		}
		/**
		* Change the global sound panning of the application.
		* @param value The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). A value of 0 represents no panning (center). 
	 	*/
		
		public function set panning($value:Number):void
		{
			this._objAudioMixer.panning = $value;
			this.applyTransform();
		}
		
		public function get panning():Number
		{
			return this._objAudioMixer.panning;
		}
		
		public function get isMuted():Boolean
		{
			return this._objAudioMixer.isMuted;
		}
	}
}