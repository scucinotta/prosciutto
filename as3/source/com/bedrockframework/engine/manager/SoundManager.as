package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.api.ISoundManager;
	import com.bedrockframework.plugin.audio.GlobalSound;
	import com.bedrockframework.plugin.audio.SoundBoard;
	import com.bedrockframework.plugin.data.SoundData;
	
	import flash.media.SoundChannel;

	public class SoundManager extends StandardWidget implements ISoundManager
	{
		/*
		Variable Declarations
		*/
		public static const GLOBAL:String = "global";
		
		private var _objSoundBoard:SoundBoard;
		private var _objGlobalSound:GlobalSound;
		/*
		Constructor
		*/
		public function SoundManager()
		{
			this.createGlobalSound();
			this.createSoundBoard();
		}
		public function initialize($sounds:Array = null):void
		{
			this.createSounds($sounds);
		}
		/*
		Creation Functions
		*/
		private function createSoundBoard():void
		{
			this._objSoundBoard = new SoundBoard;
		}
		private function createGlobalSound():void
		{
			this._objGlobalSound = new GlobalSound;
		}
		private function createSounds($sounds:Array):void
		{
			var arrSounds:Array = $sounds;
			var numLength:int = $sounds.length;
			for (var i:int = 0 ; i < numLength; i++) {
				this.add( new SoundData( arrSounds[i].alias, arrSounds[i].value ) );
			}
		}
		/*
		Audio Functions
		*/
		public function add( $data:SoundData ):void
		{
			this._objSoundBoard.add( $data );
		}
		public function load($alias:String, $url:String, $completeHandler:Function):void
		{
		}
		public function play($alias:String, $startTime:Number=0, $delay:Number = 0, $loops:int=0, $volume:Number = 1, $panning:Number = 0):SoundChannel
		{
			return this._objSoundBoard.play($alias, $startTime, $delay, $loops, $volume, $panning);
		}
		public function stop($alias:String):void
		{
			this._objSoundBoard.stop($alias);
		}
		public function close($alias:String):void
		{
			this._objSoundBoard.close($alias);
		}
		public function pause($alias:String):void
		{
			this._objSoundBoard.pause($alias);
		}
		public function resume($alias:String):void
		{
			this._objSoundBoard.resume($alias);
		}
		/*
		Volume/ Pan
		*/
		public function setVolume($alias:String, $value:Number):void
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.volume = $value;
					break;
				default :
					this._objSoundBoard.setVolume($alias, $value);
					break;
			}
		}
		public function getVolume($alias:String):Number
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.volume;
					break;
				default :
					return this._objSoundBoard.getVolume($alias);
					break;
			}
		}
		public function setPanning($alias:String, $value:Number):void
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.panning = $value;
					break;
				default :
					this._objSoundBoard.setVolume($alias, $value);
					break;
			}
		}
		public function getPanning($alias:String):Number
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.panning;
					break;
				default :
					return this._objSoundBoard.getPanning($alias);
					break;
			}
		}
		public function fadeVolume($alias:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.fadeVolume( $value, $time, $handlers );
					break;
				default :
					this._objSoundBoard.fadeVolume($alias, $value, $time, $handlers );
					break;
			}
		}
		public function fadePanning($alias:String, $value:Number, $time:Number, $handlers:Object = null ):void
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.fadePanning( $value, $time, $handlers );
					break;
				default :
					this._objSoundBoard.fadePanning($alias, $value, $time, $handlers );
					break;
			}
		}
		/*
		Global Sound Functions
		*/
		public function mute( $alias:String ):void
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.mute();
					break;
				default :
					this._objSoundBoard.mute( $alias );
					break;
			}
		}
		public function unmute( $alias:String ):void
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					this._objGlobalSound.unmute();
					break;
				default :
					this._objSoundBoard.unmute( $alias );
					break;
			}
		}
		public function toggleMute( $alias:String ):Boolean
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.toggleMute();
					break;
				default :
					return this._objSoundBoard.toggleMute( $alias );
					break;
			}
		}
		public function isMuted( $alias:String ):Boolean
		{
			switch ( $alias ) {
				case SoundManager.GLOBAL :
					return this._objGlobalSound.isMuted;
					break;
				default :
					return this._objSoundBoard.isMuted( $alias );
					break;
			}
		}
		/*
		Get Data
		*/
		public function getData( $alias:String ):SoundData
		{
			return this._objSoundBoard.getData( $alias );
		}
	}
}