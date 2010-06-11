package com.bedrockframework.plugin.loader
{
	import com.bedrockframework.core.logging.LogLevel;
	import com.bedrockframework.core.logging.Logger;
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.MathUtil;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class DataLoader extends URLLoader
	{
		/*
		Variable Declarations
		*/
		public static var cachePrevention:Boolean = false;
		public static var cacheKey:String = "";
		
		private static var __objReplacements:HashMap;
		
		private var _objURLRequest:URLRequest;
		private var _strURL:String;
		/*
		Constructor
		*/	
		DataLoader.setupReplacements();
		
		public function DataLoader($url:String=null)
		{
			Logger.log(this, LogLevel.CONSTRUCTOR, "Constructed");
			
			if ($url != null) {
				this.loadURL($url);
			}
			this.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
			this.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
		}
		private static function setupReplacements():void
		{
			var arrStandardEvents:Array = new Array(Event.COMPLETE, Event.OPEN, HTTPStatusEvent.HTTP_STATUS, ProgressEvent.PROGRESS, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR);
			var arrLoaderEvents:Array=new Array("COMPLETE","OPEN","HTTP_STATUS", "PROGRESS", "IO_ERROR", "SECURITY_ERROR" );
			__objReplacements=new HashMap;
			//
			var numLength:Number=arrStandardEvents.length;
			for (var i:Number=0; i < numLength; i++) {
				__objReplacements.saveValue(arrStandardEvents[i],LoaderEvent[arrLoaderEvents[i]]);
			}
		}
		public function loadURL($url:String, $context:LoaderContext = null):void
		{
			this._strURL = $url;
			this._objURLRequest = new URLRequest(this.getURL(this._strURL));
			try {
				this.load(this._objURLRequest);
			} catch (error:Error) {
				Logger.warning(this, "Unable to load : " + this._strURL + "!");
			}
		}
		private function getURL($url:String):String
		{
			// Alex, add more checks for existing params
			if (DataLoader.cachePrevention) {
				var strPrefix:String = (this._strURL.indexOf("?") != -1) ? "&" : "?";
				return this._strURL + strPrefix + "cache=" + DataLoader.cacheKey;
			} else {
				return this._strURL;
			}
		}
		
		override public function dispatchEvent($event:Event):Boolean
		{
			return super.dispatchEvent(this.recastEvent($event));
		}
		private function recastEvent($event:Event):Event
		{
			var objDetails:Object=new Object;
			switch ($event.type) {
				case Event.COMPLETE :
					objDetails.bytesLoaded=this.bytesLoaded;
					objDetails.bytesTotal=this.bytesTotal;
					objDetails.data=this.data;
					objDetails.url = this._strURL;
					break;
				case Event.OPEN :
					objDetails.url = this._strURL;
					break;
				case HTTPStatusEvent.HTTP_STATUS :
					objDetails.status=HTTPStatusEvent($event).status;
					break;
				case ProgressEvent.PROGRESS :
					objDetails.bytesLoaded=ProgressEvent($event).bytesLoaded;
					objDetails.bytesTotal=ProgressEvent($event).bytesTotal;
					objDetails.percent=MathUtil.calculatePercentage(objDetails.bytesLoaded,objDetails.bytesTotal);
					break;
				case IOErrorEvent.IO_ERROR :
					objDetails.text=IOErrorEvent($event).text;
					break;
				case SecurityErrorEvent.SECURITY_ERROR :
					objDetails.text=SecurityErrorEvent($event).text;
					break;
			}
			
			return new LoaderEvent(DataLoader.__objReplacements.getValue($event.type),this,objDetails);
		}
		/*
		Event Handlers
		*/
		private function onIOError($event:IOErrorEvent):void
		{
			Logger.warning(this, $event.text);
		}
		private function onSecurityError($event:IOErrorEvent):void
		{
			Logger.warning(this, $event.text);
		}
		/*
		Property Definitions
		*/
		public function get request():URLRequest
		{
			return this._objURLRequest;
		}
	}
}