package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.api.IResourceManager;
	import com.bedrockframework.engine.delegate.DefaultResourceDelegate;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.delegate.IDelegate;
	import com.bedrockframework.plugin.delegate.IResponder;
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.loader.DataLoader;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.storage.IMap;
	
	import flash.events.Event;
	
	public class ResourceManager extends StandardWidget implements IResourceManager, IResponder, IMap
	{
		/*
		Variable Declarations
		*/
		private var _clsDelegate:Class;
		private var _objDelegate:IDelegate;
		private var _mapData:HashMap;
		private var _objDataLoader:DataLoader;
		/*
		Constructor
		*/
		public function ResourceManager()
		{
			this._mapData = new HashMap;
			this.delegate = DefaultResourceDelegate;
			this.createLoader();
		}
		/*
		Creation Functions
		*/
		private function createLoader():void
		{
			this._objDataLoader = new DataLoader();
			this._objDataLoader.addEventListener(LoaderEvent.COMPLETE, this.onLoadComplete);
			this._objDataLoader.addEventListener(LoaderEvent.IO_ERROR, this.onLoadError);
			this._objDataLoader.addEventListener(LoaderEvent.SECURITY_ERROR, this.onLoadError);
		}
		private function createDelegate( $data:String ):void
		{
			this._objDelegate = new this._clsDelegate( this );
			this._objDelegate.parse( $data );
		}
		public function load( $path:String ):void
		{
			this._objDataLoader.loadURL( $path );
		}
		
		
		public function saveValue($key:*, $value:*):void
		{
			return this._mapData.saveValue( $key, $value);
		}
		public function removeValue($key:*):void
		{
			return this._mapData.removeValue( $key );
		}
		public function pullValue($key:*):*
		{
			return this._mapData.pullValue( $key );
		}
		
		
		public function containsKey($key:*):Boolean
		{
			return this._mapData.containsKey( $key );
		}
		public function containsValue($value:*):Boolean
		{
			return this._mapData.containsValue( $value );
		}
		
		public function reset():void
		{
			this._mapData.reset();
		}
		public function clear():void
		{
			this._mapData.clear();
		}
		
		public function getKey($value:*):String
		{
			return this._mapData.getKey( $value );
		}
		public function getValue($key:*):*
		{
			return this._mapData.getValue( $key );
		}
		public function getKeys():Array
		{
			return this._mapData.getKeys();
		}
		public function getValues():Array
		{
			return this._mapData.getValues();
		}


		public function get size():int
		{
			return this._mapData.size;
		}
		public function get isEmpty():Boolean
		{
			return this._mapData.isEmpty;
		}

		
		/*
		Responder Functions
		*/
		public function result($data:* = null):void
		{
			if ( $data != null && ( $data is HashMap ) && this._mapData.isEmpty ) {
				this._mapData = $data as HashMap;
				BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.RESOURCE_BUNDLE_LOADED, this));
			} else if (  $data == null && !this._mapData.isEmpty ) {
				BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.RESOURCE_BUNDLE_LOADED, this));
			} else {
				this.fault();
			}
		}
		public function fault($data:*  = null):void
		{
			this.warning("Error Parsing Resource Bundle!");
			BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.RESOURCE_BUNDLE_ERROR, this ));
		}
		/*
		Event Handlers
		*/
		private function onLoadComplete($event:LoaderEvent):void
		{
			this.status("Resource Bundle Loaded");
			this.createDelegate( this._objDataLoader.data );
		}
		private function onLoadError($event:Event):void
		{
			this.warning("Error Parsing Resource Bundle!");
			BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.RESOURCE_BUNDLE_ERROR, this ));
		}
		/*
		Property Definitions
		*/
		public function get loader():DataLoader
		{
			return this._objDataLoader;
		}
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