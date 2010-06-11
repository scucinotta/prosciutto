package com.bedrockframework.plugin.tools
{
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.event.KeyboardCaptureEvent;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class KeyboardCapture extends DispatcherWidget
	{
		/*
		Variable Declarations
		*/	
		private var _objStage:Stage;
		private var _strPhrase:String;
		private var _arrPhrases:Array;
		private var _strCapture:String;
		/*
		Constructor
		*/				
		public function KeyboardCapture()
		{
			this.reset();
		}
		
		public function initialize($stage:Stage):void
		{
			this.status("Initialized!");
			this._objStage = $stage;
			this._objStage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
		}
		public function reset():void
		{
			this._arrPhrases = new Array;
			this._strCapture = "";
		}
		public function clear():void
		{
			this._objStage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
		}
		/*
		Add Character to phrase
		*/
		private function addCharacterToCapture($character:String):String
		{
			this._strCapture += $character;
			return this._strCapture;
		}
		public function addPhrase($phrase:String):void
		{
			this._strPhrase = $phrase.toUpperCase();
			this._arrPhrases.push(this._strPhrase);
		}
		/*
	
		*/
		private function searchForPhrase($capture:String):void
		{
			var numLength:int = this._arrPhrases.length;
			for (var i:int = 0 ; i < numLength; i++) {
				var strPhrase:String = this._arrPhrases[i];
				if ($capture.search(strPhrase) != -1) {
					this.status("Phrase matched!");
					this.dispatchEvent(new KeyboardCaptureEvent(KeyboardCaptureEvent.PHRASE_MATCHED, this, {phrase:strPhrase.toLowerCase()}));
					this.reset();
				}
			}
		}
		/*
		Event Handlers
		*/
		private function onKeyDownHandler($event:KeyboardEvent):void
		{
			this.searchForPhrase(this.addCharacterToCapture(String.fromCharCode($event.keyCode)));
		}
		/*
		Property Definitions
		*/
	}
}