package com.bedrockframework.plugin.event
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import com.bedrockframework.core.event.GenericEvent;

	public class LoaderEvent extends GenericEvent
	{
		public static  const COMPLETE:String="LoaderEvent.onComplete";
		public static  const OPEN:String="LoaderEvent.onOpen";
		public static  const INIT:String="LoaderEvent.onInit";
		public static  const UNLOAD:String="LoaderEvent.onUnload";
		public static  const HTTP_STATUS:String="LoaderEvent.onStatus";
		public static  const PROGRESS:String="LoaderEvent.onProgress";
		public static  const IO_ERROR:String="LoaderEvent.onIOError";
		public static  const SECURITY_ERROR:String="LoaderEvent.onSecurityError";

		public function LoaderEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}