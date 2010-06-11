package com.bedrockframework.engine.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class BedrockEvent extends GenericEvent
	{
		public static const SET_QUEUE:String="BedrockEvent.onSetQueue";
		public static const LOAD_QUEUE:String="BedrockEvent.onLoadQueue";
		public static const DEFAULT_QUEUE:String="BedrockEvent.onDefaultQueue";

		public static const DO_DEFAULT:String="BedrockEvent.onDoDefault";
		public static const DO_CHANGE:String="BedrockEvent.onDoChange";
		
		public static const DO_LOAD:String="BedrockEvent.onDoLoad";
		public static const DO_INITIALIZE:String="BedrockEvent.onDoInitialize";

		public static const RENDER_VIEW:String="BedrockEvent.onRenderView";
		public static const RENDER_SITE:String="BedrockEvent.onRenderSite";
		public static const RENDER_PAGE:String="BedrockEvent.onRenderPage";
		public static const RENDER_PRELOADER:String="BedrockEvent.onRenderPreloader";

		public static const CONFIG_LOADED:String="BedrockEvent.onConfigLoaded";
		public static const BEDROCK_BOOT_UP:String="BedrockEvent.onBedrockBootUp";
		public static const BEDROCK_PROGRESS:String="BedrockEvent.onBedrockProgress";
		public static const BEDROCK_COMPLETE:String="BedrockEvent.onBedrockComplete";

		public static const URL_CHANGE:String="BedrockEvent.onURLChange";

		public static const LOAD_BEGIN:String="BedrockEvent.onLoadBegin";
		public static const LOAD_ERROR:String="BedrockEvent.onLoadError";
		public static const LOAD_COMPLETE:String="BedrockEvent.onLoadComplete";
		public static const LOAD_CLOSE:String="BedrockEvent.onLoadClose";
		public static const LOAD_PROGRESS:String="BedrockEvent.onLoadProgress";
		public static const LOAD_NEXT:String="BedrockEvent.onLoadNext";
		public static const LOAD_RESET:String="BedrockEvent.onLoadReset";

		public static const FILE_ADDED:String="BedrockEvent.onFileAdded";
		public static const FILE_OPEN:String="BedrockEvent.onFileOpen";
		public static const FILE_PROGRESS:String="BedrockEvent.onFileProgress";
		public static const FILE_COMPLETE:String="BedrockEvent.onFileComplete";
		public static const FILE_INIT:String="BedrockEvent.onFileInitialize";
		public static const FILE_UNLOAD:String="BedrockEvent.onFileUnload";
		public static const FILE_HTTP_STATUS:String="BedrockEvent.onFileStatus";
		public static const FILE_ERROR:String="BedrockEvent.onFileError";
		public static const FILE_SECURITY_ERROR:String="BedrockEvent.onFileSecurityError";

		public static const SITE_INITIALIZE_COMPLETE:String="BedrockEvent.onSiteInitializeComplete";
		public static const SITE_INTRO_COMPLETE:String="BedrockEvent.onSiteIntroComplete";
		public static const SITE_OUTRO_COMPLETE:String="BedrockEvent.onSiteOutroComplete";
		
		public static const PAGE_INITIALIZE_COMPLETE:String="BedrockEvent.onPageInitializeComplete";
		public static const PAGE_INTRO_COMPLETE:String="BedrockEvent.onPageIntroComplete";
		public static const PAGE_OUTRO_COMPLETE:String="BedrockEvent.onPageOutroComplete";
		
		public static const PRELOADER_INITIALIZE_COMPLETE:String="BedrockEvent.onPreloaderInitializeComplete";
		public static const PRELOADER_INTRO_COMPLETE:String="BedrockEvent.onPreloaderIntroComplete";
		public static const PRELOADER_OUTRO_COMPLETE:String="BedrockEvent.onPreloaderOutroComplete";
		public static const PRELOADER_UPDATE:String="BedrockEvent.onPreloaderUpdate";

		public static const SHOW_BLOCKER:String="BedrockEvent.onShowBlocker";
		public static const HIDE_BLOCKER:String="BedrockEvent.onHideBlocker";
		
		public static const RESOURCE_BUNDLE_CHANGE:String="BedrockEvent.onResourceBundleChange";
		public static const RESOURCE_BUNDLE_LOADED:String="BedrockEvent.onResourceBundleLoaded";
		public static const RESOURCE_BUNDLE_ERROR:String="BedrockEvent.onResourceBundleError";
		
		public static const LOCALE_CHANGE:String="BedrockEvent.onLocaleChange";
		public static const LOCALE_LOADED:String="BedrockEvent.onLocaleLoaded";
		public static const LOCALE_ERROR:String="BedrockEvent.onLocaleError";
		
		public static const ADD_SOUND:String = "BedrockEvent.onAddSound";
		public static const PLAY_SOUND:String = "BedrockEvent.onPlaySound";
		public static const STOP_SOUND:String = "BedrockEvent.onStopSound";
		public static const SET_PANNING:String = "BedrockEvent.onSetPanning";
		public static const SET_VOLUME:String = "BedrockEvent.onSetVolume";
		public static const FADE_VOLUME:String = "BedrockEvent.onFadeVolume";
		public static const FADE_PANNING:String = "BedrockEvent.onFadePanning";		
		public static const MUTE:String = "BedrockEvent.onMute";
		public static const UNMUTE:String = "BedrockEvent.onUnmute";
		
		public static const SHARED_ASSETS_LOADED:String = "BedrockEvent.onSharedAssetsLoaded";

		public function BedrockEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}