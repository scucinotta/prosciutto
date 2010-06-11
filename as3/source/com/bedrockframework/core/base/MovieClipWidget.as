/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
 **/
package com.bedrockframework.core.base
{
	import com.bedrockframework.core.logging.ILogable;
	import com.bedrockframework.core.logging.LogLevel;
	import com.bedrockframework.core.logging.Logger;
	import com.bedrockframework.plugin.util.MovieClipUtil;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class MovieClipWidget extends MovieClip implements ILogable
	{
		/*
		Variable Declarations
		*/	
		private var _bolSilenceLogging:Boolean;
		/*
		Constructor
		*/
		public function MovieClipWidget($silenceConstruction:Boolean = false)
		{
			super();
			this._bolSilenceLogging = false;
			if (!$silenceConstruction) {
				this.log(LogLevel.CONSTRUCTOR, "Constructed");
			}
		}
		/*
		Overrides adding additional functionality
		*/
		override public  function dispatchEvent($event:Event):Boolean
		{
			return super.dispatchEvent($event);
		}
		override public  function addEventListener($type:String,$listener:Function,$capture:Boolean=false,$priority:int=0,$weak:Boolean=true):void
		{
			super.addEventListener($type,$listener,$capture,$priority,$weak);
		}
		/*
		Logging Functions
	 	*/
	 	private function sendLogMessage($level:int, $arguments:Array):void
		{
			if (!this._bolSilenceLogging) {
				Logger.send(this, $level, $arguments);
			}
		}
		
		public function log($level:int, ...$arguments:Array):void
		{
			this.sendLogMessage($level, $arguments);
		}
		public function status(...$arguments:Array):void
		{
			this.sendLogMessage(LogLevel.STATUS, $arguments);
		}
		public function debug(...$arguments:Array):void
		{
			this.sendLogMessage(LogLevel.DEBUG, $arguments);
		}
		public function attention(...$arguments:Array):void
		{
			this.sendLogMessage(LogLevel.ATTENTION, $arguments);
		}
		public function warning(...$arguments:Array):void
		{
			this.sendLogMessage(LogLevel.WARNING, $arguments);
		}
		public function error(...$arguments:Array):void
		{
			this.sendLogMessage(LogLevel.ERROR, $arguments);
		}
		public function fatal(...$arguments:Array):void
		{
			this.sendLogMessage(LogLevel.FATAL, $arguments);
		}
		
		/*
		Property Definitions
	 	*/
		public function set silenceLogging($value:Boolean):void
		{
			this._bolSilenceLogging=$value;
		}
		public function get silenceLogging():Boolean
		{
			return this._bolSilenceLogging;
		}
		/*
		Returns an Array of the children of the Movieclip.
		*/
		public function get children():Array
		{
			var arrChildren:Array = new Array;
			var numLength:uint = this.numChildren;
			for(var i:uint = 0; i < numLength; i++) {
				arrChildren.push( this.getChildAt( i ) );
			}
			return arrChildren;
		}
		/*        
		Removes all of the children of the Movieclip.
		*/        
		public function removeChildren():void
		{
			var numLength:int = this.children.length;
			for ( var i:int = 0; i < numLength; i ++ ) {
				this.removeChildAt(0);
			}
		}
		
	}
}