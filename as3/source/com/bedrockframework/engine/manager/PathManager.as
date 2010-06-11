package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.BasicWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.IPathManager;
	import com.bedrockframework.engine.api.IPathDelegate;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.engine.delegate.DefaultPathDelegate;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.event.BulkLoaderEvent;
	import com.bedrockframework.plugin.loader.BulkLoader;

	public class PathManager extends BasicWidget implements IPathManager
	{
		/*
		Variable Declarations
		*/
		private var _clsDelegate:Class;
		private var _objDelegate:IPathDelegate;
		private var _objBulkLoader:BulkLoader;
		/*
		Constructor
		*/
		public function PathManager()
		{
			this.delegate = DefaultPathDelegate;
		}
		public function initialize():void
		{
			this._objDelegate = new this._clsDelegate;
			this.createBulkLoader();
		}
		
		private function createBulkLoader():void
		{
			this._objBulkLoader = new BulkLoader;
			this._objBulkLoader.addEventListener( BulkLoaderEvent.COMPLETE, this.onLoadComplete );
			this._objBulkLoader.addEventListener( BulkLoaderEvent.ERROR, this.onLoadError );
		}
		
		public function load( $locale:String = null, $useLoadManager:Boolean = false):void
		{
			if ( BedrockEngine.config.getSettingValue( BedrockData.FONTS_ENABLED ) && BedrockEngine.localeManager.isFileLocalized( "fonts" ) ) {
				this.addToQueue( this._objDelegate.getFontPath( $locale ), BedrockEngine.fontManager.loader, $useLoadManager );
			} else if ( BedrockEngine.config.getSettingValue( BedrockData.FONTS_ENABLED ) ) {
				this.addToQueue( this._objDelegate.getFontPath(), BedrockEngine.fontManager.loader, $useLoadManager );
			}
			
			if ( BedrockEngine.config.getSettingValue( BedrockData.CSS_ENABLED ) && BedrockEngine.localeManager.isFileLocalized( "css" ) ) {
				this.addToQueue( this._objDelegate.getCSSPath( $locale ), BedrockEngine.cssManager.loader, $useLoadManager );
			} else if ( BedrockEngine.config.getSettingValue( BedrockData.CSS_ENABLED ) ) {
				this.addToQueue( this._objDelegate.getCSSPath(), BedrockEngine.cssManager.loader, $useLoadManager );
			}
			
			if ( BedrockEngine.config.getSettingValue( BedrockData.RESOURCE_BUNDLE_ENABLED ) && BedrockEngine.localeManager.isFileLocalized( "resource_bundle" ) ) {
				this.addToQueue( this._objDelegate.getResourceBundlePath( $locale ), BedrockEngine.resourceManager.loader, $useLoadManager );
			} else if ( BedrockEngine.config.getSettingValue( BedrockData.RESOURCE_BUNDLE_ENABLED ) ) {
				this.addToQueue( this._objDelegate.getResourceBundlePath(), BedrockEngine.resourceManager.loader, $useLoadManager );
			}
			
			if ( BedrockEngine.config.getSettingValue( BedrockData.SHARED_ENABLED ) && BedrockEngine.localeManager.isFileLocalized( "shared" ) ) {
				this.addToQueue( this._objDelegate.getSharedPath( $locale ), BedrockEngine.containerManager.getContainer( BedrockData.SHARED_CONTAINER ), $useLoadManager );
			} else if ( BedrockEngine.config.getSettingValue( BedrockData.SHARED_ENABLED ) ) {
				this.addToQueue( this._objDelegate.getSharedPath(), BedrockEngine.containerManager.getContainer( BedrockData.SHARED_CONTAINER ), $useLoadManager );
			}
			
			if ( !$useLoadManager ) this._objBulkLoader.loadQueue();
		}
		
		private function addToQueue( $path:String, $loader:*, $useLoadManager:Boolean = false ):void
		{
			if ( !$useLoadManager ) {
				this._objBulkLoader.addToQueue( $path, $loader );
			} else {
				BedrockEngine.loadManager.addToQueue( $path, $loader );
			}
		}
		
		/*
		Event Handlers
		*/
		private function onLoadComplete($event:BulkLoaderEvent):void
		{
			this.status( "Completed File Load" );
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.LOCALE_LOADED, this ) );
		}
		private function onLoadError( $event:BulkLoaderEvent ):void
		{
			this.warning( "Error Loading File" );
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.LOCALE_ERROR, this ) );
		}
		/*
		Property Definitions
		*/
		
		public function get delegate():Class
		{
			return this._clsDelegate;
		}
		public function set delegate( $class:Class ):void
		{
			this._clsDelegate = $class;
		}
	}
}