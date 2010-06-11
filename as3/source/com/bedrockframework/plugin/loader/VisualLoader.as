package com.bedrockframework.plugin.loader
{
	import com.bedrockframework.core.logging.LogLevel;
	import com.bedrockframework.core.logging.Logger;
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.gadget.IClonable;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.MathUtil;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class VisualLoader extends Loader implements IClonable
	{
		/*
		Variable Declarations
		*/
		public static var cachePrevention:Boolean = false;
		public static var cacheKey:String = "";
		
		private static var __objReplacements:HashMap;
		
		private var _objURLRequest:URLRequest;
		private var _numID:int;
		private var _numRow:int;
		private var _numColumn:int;
		private var _strURL:String;
		/*
		Constructor
		*/
		VisualLoader.setupReplacements();
		
		public function VisualLoader($url:String = null)
		{
			Logger.log(this, LogLevel.CONSTRUCTOR, "Constructed" );
			
			this.setupListeners(this.contentLoaderInfo);
			
			if ($url != null) this.loadURL($url);
		}
		private static function setupReplacements():void
		{
			var arrStandardEvents:Array = new Array(Event.COMPLETE, Event.OPEN, Event.INIT, Event.UNLOAD, HTTPStatusEvent.HTTP_STATUS, ProgressEvent.PROGRESS, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR);
			var arrLoaderEvents:Array=new Array("COMPLETE","OPEN","INIT","UNLOAD", "HTTP_STATUS", "PROGRESS", "IO_ERROR", "SECURITY_ERROR" );
			__objReplacements=new HashMap  ;
			//
			var numLength:Number=arrStandardEvents.length;
			for (var i:Number=0; i < numLength; i++) {
				__objReplacements.saveValue(arrStandardEvents[i],LoaderEvent[arrLoaderEvents[i]]);
			}
		}
		
		public function setupListeners($loaderInfo:LoaderInfo):void
		{
			$loaderInfo.addEventListener(Event.COMPLETE, this.dispatchEvent);
			$loaderInfo.addEventListener(Event.OPEN, this.dispatchEvent);
			$loaderInfo.addEventListener(Event.INIT, this.dispatchEvent);
			$loaderInfo.addEventListener(Event.UNLOAD, this.dispatchEvent);
			$loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.dispatchEvent);
			$loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.dispatchEvent);
			
			$loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.dispatchEvent);
			$loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
			$loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.dispatchEvent);
			$loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
		}
		public function loadURL($url:String, $context:LoaderContext = null):void
		{
			this._strURL = $url;
			this._objURLRequest=new URLRequest(this.getURL(this._strURL));
			try {
				this.load(this._objURLRequest, $context);
			} catch (error:Error) {
				Logger.warning(this, "Unable to load : " + this._strURL + "!");
			}
		}
		
		private function getURL($url:String):String
		{
			if ( VisualLoader.cachePrevention) {
				var strPrefix:String = (this._strURL.indexOf("?") != -1) ? "&" : "?";
				return this._strURL + strPrefix + "cache=" + VisualLoader.cacheKey;
			} else {
				return this._strURL;
			}
		}
		
		override public function dispatchEvent($event:Event):Boolean
		{
			return super.dispatchEvent(this.recastEvent($event));
		}
		private function recastEvent($event:*):Event
		{
			var objDetails:Object=new Object;
			switch ($event.type) {
				case Event.COMPLETE :
					objDetails.bytesLoaded=this.contentLoaderInfo.bytesLoaded;
					objDetails.bytesTotal=this.contentLoaderInfo.bytesTotal;
					objDetails.contentType=this.contentLoaderInfo.contentType;
					objDetails.content = this.content;
					objDetails.url=this._strURL;
					break;
				case Event.OPEN : 
					objDetails.url=this._strURL;
					break;
				case Event.INIT :
					objDetails.url=this._strURL;
					objDetails.contentType=this.contentLoaderInfo.contentType;
					break;
				case Event.UNLOAD :
					objDetails.url=this._strURL;
					break;
				case HTTPStatusEvent.HTTP_STATUS :
					objDetails.status=HTTPStatusEvent($event).status;
					break;
				case ProgressEvent.PROGRESS :
					objDetails.bytesLoaded=ProgressEvent($event).bytesLoaded;
					objDetails.bytesTotal=ProgressEvent($event).bytesTotal;
					objDetails.percent=MathUtil.calculatePercentage(objDetails.bytesLoaded,objDetails.bytesTotal);
					objDetails.percentage=objDetails.percent;
					break;
				case IOErrorEvent.IO_ERROR :
					objDetails.text=IOErrorEvent($event).text;
					break;
				case SecurityErrorEvent.SECURITY_ERROR :
					objDetails.text=SecurityErrorEvent($event).text;
					break;
				default :
					return $event;
					break;
			}
			
			return new LoaderEvent(VisualLoader.__objReplacements.getValue($event.type),this,objDetails);
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
		public function set index($id:int):void
		{
			this._numID = $id;
		}
		public function get index():int
		{
			return this._numID;
		}
		public function set row($row:int):void
		{
			this._numRow = $row;
		}
		public function get row():int
		{
			return this._numRow;
		}
		public function set column($column:int):void
		{
			this._numColumn = $column;
		}
		public function get column():int
		{
			return this._numColumn;
		}
		public function get url():String
		{
			return this._strURL;
		}
	}
}