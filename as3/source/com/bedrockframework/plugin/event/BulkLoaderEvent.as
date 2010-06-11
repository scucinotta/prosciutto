package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class BulkLoaderEvent extends GenericEvent
	{
		public static  const BEGIN:String="BulkLoaderEvent.onBegin";
		public static  const ERROR:String="BulkLoaderEvent.onError";
		public static  const COMPLETE:String="BulkLoaderEvent.onComplete";
		public static  const CLOSE:String="BulkLoaderEvent.onClose";
		public static  const PROGRESS:String="BulkLoaderEvent.onProgress";
		public static  const NEXT:String="BulkLoaderEvent.onNext";
		public static  const RESET:String="BulkLoaderEvent.onReset";

		public static  const FILE_ADDED:String = "BulkLoaderEvent.onFileAdded";
		public static  const FILE_OPEN:String=LoaderEvent.OPEN;
		public static  const FILE_PROGRESS:String=LoaderEvent.PROGRESS;
		public static  const FILE_COMPLETE:String=LoaderEvent.COMPLETE;
		public static  const FILE_INIT:String=LoaderEvent.INIT;
		public static  const FILE_UNLOAD:String=LoaderEvent.UNLOAD;
		public static  const FILE_HTTP_STATUS:String=LoaderEvent.HTTP_STATUS;
		public static  const FILE_ERROR:String=LoaderEvent.IO_ERROR;
		public static  const FILE_SECURITY_ERROR:String=LoaderEvent.SECURITY_ERROR;

		public function BulkLoaderEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
		
	}
}