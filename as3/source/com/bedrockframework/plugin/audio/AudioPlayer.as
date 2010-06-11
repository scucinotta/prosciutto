package com.bedrockframework.plugin.audio
{
	/**
	 * Generic, auxiliary functions
	 *
	 * @author		Alex Toledo
	 * @version	1.0.0
	 * @created	
	 */
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.event.AudioEvent;
	import com.bedrockframework.plugin.event.TriggerEvent;
	import com.bedrockframework.plugin.timer.IntervalTrigger;
	import com.bedrockframework.plugin.util.MathUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class AudioPlayer extends DispatcherWidget
	{
		/*
		Variable Declarations
		*/
		private var _strURL:String;
		private var _numResumeTime:Number;
		
		private var _objSound:Sound;
		private var _objChannel:SoundChannel;
		private var _objAudioMixer:AudioMixer;
		private var _objPositionTrigger:IntervalTrigger;
		
		private var _bolPaused:Boolean;
		private var _bolPlaying:Boolean;
		/*
		Constructor
		*/
		public function AudioPlayer()
		{
			this._bolPlaying = false;
			this._bolPaused = false;			
			this._objPositionTrigger = new IntervalTrigger(0.05);
			this._objPositionTrigger.addEventListener(TriggerEvent.TRIGGER, this.onProgressTrigger);
			this._objPositionTrigger.silenceLogging = true;
		}
		
		public function initialize($sound:Sound = null):void
		{
			this.createAudioMixer();
			this.createSound($sound);
		}
		/*
		Creation Functions
		*/
		private function createAudioMixer():void
		{
			this._objAudioMixer = new AudioMixer;
		}
		/*
		Setting Sound
		*/
		private function createSound($sound:Sound = null):void
		{
			this._objSound = $sound || new Sound();
			this._objSound.addEventListener(Event.COMPLETE, this.onLoadComplete);
			this._objSound.addEventListener(Event.OPEN, this.onOpen);
			this._objSound.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			this._objSound.addEventListener(Event.ID3, this.onID3);
			this._objSound.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
		}
		private function clearSound():void
		{
			this._objSound.removeEventListener(Event.COMPLETE, this.onLoadComplete);
			this._objSound.removeEventListener(Event.OPEN, this.onOpen);
			this._objSound.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
			this._objSound.removeEventListener(Event.ID3, this.onID3);
			this._objSound.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
		}
		/*
		Load File
		*/
		public function load($url:String):void
		{
			if( this._objSound != null ){
				this._bolPlaying = false;
				this.regenerateSound();
			}
			this._objSound.load( new URLRequest( $url ) );
		}
		/*
		Play
		*/
		public function play($startTime:Number = 0, $loops:int = 0, $transform:SoundTransform = null):SoundChannel 
		{
			if ( !this._bolPlaying ) {
				this._bolPlaying = true;
				this._bolPaused = false;
				this._objPositionTrigger.start();
				this._objChannel = this._objSound.play($startTime, $loops, $transform);
				this._objChannel.addEventListener(Event.SOUND_COMPLETE, this.onPlayComplete);
				this._objAudioMixer.target = this._objChannel;
				this.dispatchEvent(new AudioEvent(AudioEvent.PLAY, this, { duration:this._objSound.length } ));
				return this._objChannel;			
			}
			return null;
		}
		public function stop():void
		{
			if ( this._bolPlaying ) {
				this._bolPlaying = false;
				this._bolPaused = false;
				this._objChannel.stop();
				this._objPositionTrigger.stop();
				this.dispatchEvent(new AudioEvent(AudioEvent.STOP, this));
			}
		}
		/*
		Pause/ Resume
		*/
		public function pause():void
		{
			if ( this._bolPlaying && !this._bolPaused ) {
				this._bolPlaying = false;
				this._bolPaused = true;
				this._numResumeTime = this._objChannel.position;
				this._objPositionTrigger.stop();
				this._objChannel.stop();
				this.dispatchEvent(new AudioEvent(AudioEvent.PAUSE, this));
			}
		}
		public function resume():void
		{
			if ( !this._bolPlaying && this._bolPaused) {
				this.play( this._numResumeTime );
				this._objPositionTrigger.start();
				this.dispatchEvent(new AudioEvent(AudioEvent.RESUME, this));
			}			
		}
		/*
		Muting
		*/
		public function mute():void
		{
			this._objAudioMixer.mute();
			this.dispatchEvent(new AudioEvent(AudioEvent.MUTE, this));
		}
		public function unmute():void
		{
			this._objAudioMixer.unmute();
			this.dispatchEvent(new AudioEvent(AudioEvent.UNMUTE, this));
		}
		public function toggleMute():Boolean
		{
			if ( this._objAudioMixer.isMuted ) {
				this.unmute();
			} else {
				this.mute();
			}
			return this._objAudioMixer.isMuted;
		}
		/*
		Fade Functions
		*/
		public function fadeVolume( $value:Number, $time:Number, $handlers:Object = null ):void
		{
			this._objAudioMixer.fadeVolume( $value, $time, $handlers );
		}
		public function fadePanning( $value:Number, $time:Number, $handlers:Object = null ):void
		{
			this._objAudioMixer.fadePanning( $value, $time, $handlers );
		}
		
		public function seekWithPercentage( $percent:Number ):void
		{
			this.seekWithTime( MathUtil.getPercentage( $percent, this.duration ) );
		}
		public function seekWithTime( $time:Number ):void
		{
			this.stop();
			this.play( $time );
		}
		/*
		Recreate Sound Object
		*/
		private function regenerateSound():void
		{
			this.clearSound();
			this.createSound();
		}
		/*
		Event Handlers
		*/
		private function onLoadComplete($event:Event):void
		{
			this.dispatchEvent(new AudioEvent(AudioEvent.LOAD_COMPLETE, this, { length:this._objSound.length } ) );
		}
		private function onProgress($event:ProgressEvent):void
		{
			var objDetails:Object = new Object();
			objDetails.bytesLoaded = $event.bytesLoaded;
			objDetails.bytesTotal = $event.bytesTotal;
			objDetails.percent = MathUtil.calculatePercentage(objDetails.bytesLoaded,objDetails.bytesTotal);
			this.dispatchEvent(new AudioEvent(AudioEvent.LOAD_PROGRESS, this, objDetails));
		}
		private function onOpen($event:Event):void
		{
			this.dispatchEvent(new AudioEvent(AudioEvent.OPEN, this, {url:this._strURL}));
		}
		private function onID3($event:Event):void
		{
			this.dispatchEvent(new AudioEvent(AudioEvent.ID3, this, { ID3:this._objSound.id3, length:this._objSound.length }));
		}
		private function onIOError($event:IOErrorEvent):void
		{
			this.dispatchEvent(new AudioEvent(AudioEvent.ERROR, this, {url:this._strURL}));
		}
		private function onPlayComplete($event:Event):void
		{
			this._objPositionTrigger.stop();
			this.dispatchEvent(new AudioEvent(AudioEvent.PLAY_COMPLETE, this, {}));			
		}
		private function onProgressTrigger($event:TriggerEvent):void
		{
			var objDetails :Object = new Object();
			objDetails.position = this.position;
			objDetails.duration = this.duration;
			objDetails.percent = MathUtil.calculatePercentage(objDetails.position, objDetails.duration);
			this.dispatchEvent(new AudioEvent(AudioEvent.PLAY_PROGRESS, this, objDetails));
		}
		
		/*
		Property Definitions
		*/
		public function get isPlaying():Boolean
		{
			return this._bolPlaying;
		}
		public function get isPaused():Boolean
		{
			return this._bolPaused;
		}
		public function get isMuted():Boolean
		{
			return this._objAudioMixer.isMuted;
		}
		
		public function set volume($value:Number):void
		{
			this._objAudioMixer.volume = $value;
			this.dispatchEvent(new AudioEvent(AudioEvent.VOLUME, this, { volume:$value } ) );
		}
		public function get volume():Number
		{
			return this._objAudioMixer.volume;
		}
		public function set panning($value:Number):void
		{
			this._objAudioMixer.panning = $value;
			this.dispatchEvent(new AudioEvent(AudioEvent.PAN, this, { panning:$value } ) );
		}
		public function get panning():Number
		{
			return this._objAudioMixer.panning;
		}
		public function get sound():Sound
		{
			return this._objSound;
		}
		public function get channel():SoundChannel
		{
			return this._objChannel;	
		}
		 public function get transform():SoundTransform
		 {
		 	return this._objAudioMixer.transform;
		 }
		 
		 public function get position():Number
		 {
		 	return this._objChannel.position;
		 }
		 
		 public function get duration():Number
		 {
		 	return this._objSound.length;
		 }
	}
}