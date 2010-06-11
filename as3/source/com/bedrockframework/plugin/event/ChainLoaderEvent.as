package com.bedrockframework.plugin.event
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import com.bedrockframework.core.event.GenericEvent;
	import com.bedrockframework.plugin.event.LoaderEvent;

	public dynamic class ChainLoaderEvent extends GenericEvent
	{
		
		public static const BEGIN:String="ChainLoaderEvent.onBegin";
		public static const ERROR:String="ChainLoaderEvent.onError";
		public static const COMPLETE:String="ChainLoaderEvent.onComplete";
		public static const CLOSE:String="ChainLoaderEvent.onClose";
		public static const PROGRESS:String="ChainLoaderEvent.onProgress";
		public static const NEXT:String="ChainLoaderEvent.onNext";
		public static const RESET:String="ChainLoaderEvent.onReset";

		public static const FILE_ADDED:String = "ChainLoaderEvent.onFileAdded";
		public static const FILE_OPEN:String=LoaderEvent.OPEN;
		public static const FILE_PROGRESS:String=LoaderEvent.PROGRESS;
		public static const FILE_COMPLETE:String=LoaderEvent.COMPLETE;
		public static const FILE_INIT:String=LoaderEvent.INIT;
		public static const FILE_UNLOAD:String=LoaderEvent.UNLOAD;
		public static const FILE_HTTP_STATUS:String=LoaderEvent.HTTP_STATUS;
		public static const FILE_ERROR:String=LoaderEvent.IO_ERROR;
		public static const FILE_SECURITY_ERROR:String=LoaderEvent.SECURITY_ERROR;

		public function ChainLoaderEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}

	}
}