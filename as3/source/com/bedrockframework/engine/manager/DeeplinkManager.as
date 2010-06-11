
package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.core.logging.Logger;
	import com.bedrockframework.engine.api.IDeeplinkManager;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.event.TriggerEvent;
	import com.bedrockframework.plugin.timer.IntervalTrigger;
	import com.bedrockframework.plugin.util.StringUtil;
	import com.bedrockframework.plugin.util.VariableUtil;
	
	import flash.external.ExternalInterface;
	
	public class DeeplinkManager extends StandardWidget implements IDeeplinkManager
	{
		/*
		Variable Declarations
		*/
		private static const INTERVAL:Number = 0.1;
		private var _objTrigger:IntervalTrigger;
		private var _strAddress:String;
		/*
		Constructor
		*/
		public function DeeplinkManager()
		{
			
		}

		public function initialize():void
		{
			this.status( "Initialize" );
			ExternalInterface.call( "initialize" );
			this.createTrigger();
			this.checkForChange( false );
			this.enableChangeHandler();
		}
		/*
		Creation Functions
		*/
		private function createTrigger():void
		{
			this._objTrigger = new IntervalTrigger;
			this._objTrigger.addEventListener( TriggerEvent.TRIGGER, this.onTrigger );
			this._objTrigger.silenceLogging = true;
		}
		/*
		Enable/ Disable Change Event
		*/
		private function enableChangeHandler():void
		{
			this._objTrigger.start( DeeplinkManager.INTERVAL );
		}
		private function disableChangeHandler():void
		{
			this._objTrigger.stop();
		}
		
		private function checkForChange( $notify:Boolean = true ):void
		{
			if ( this.available ) {
				var strAddress:String = ExternalInterface.call( "getHashAddress" );
				if ( strAddress != this._strAddress ) {
					this._strAddress = strAddress;
					if ( $notify ) {
						this.status( "Change" );
						
						var objDetails:Object = new Object();
						objDetails.parameters = this.getParameters();
						objDetails.paths = this.getPathHierarchy();
						BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.URL_CHANGE, this, objDetails ) );
					}
				}
			}
		}
		
		public function setPath( $value:String ):void
		{
			this.disableChangeHandler();
			ExternalInterface.call( "setHashPath", $value );
			this.checkForChange( false );
			this.enableChangeHandler();
		}
		public function getPath():String
		{
			return ExternalInterface.call( "getHashPath" ) || "";
		}
		public function clearPath():void
		{
			this.setPath( "" );
		}
		
		public function setPathHierarchy( $paths:Array ):void
		{
			var strPaths:String = $paths.toString();
			this.setPath( StringUtil.replace( strPaths, ",", "/" ) );
		}
		public function getPathHierarchy():Array
		{
			return this.getPath().split( "/" );
		}
 
		public function setAddress( $value:String ):void
		{
			this.disableChangeHandler();
			ExternalInterface.call( "setHashAddress", $value );
			this.checkForChange( false );
			this.enableChangeHandler();
		}
		public function getAddress():String
		{
			return ExternalInterface.call( "getHashAddress" ) || ""; 
		}
		public function clearAddress():void
		{
			this.setAddress( "" );
		}
		
		public function setQuery( $value:String ):void
		{
			this.disableChangeHandler();
			ExternalInterface.call( "setHashQuery", $value );
			this.checkForChange( false );
			this.enableChangeHandler();
		}
		public function getQuery():String
		{
			return ExternalInterface.call( "getHashQuery" ) || "";
		}
		public function clearQuery():void
		{
			this.setQuery( "" );
		}
		
		public function setTitle( $value:String ):void
		{
			ExternalInterface.call( "setTitle", $value ); 
		}
		public function getTitle():String
		{
			return ExternalInterface.call( "getTitle" ) || "";
		}
		public function clearTitle():void
		{
			this.setTitle( "" );
		}
		
		public function setStatus( $value:String ):void
		{
			ExternalInterface.call( "setStatus", $value ); 
		}
		public function getStatus():String
		{
			return ExternalInterface.call( "getStatus" ) || "";
		}
		public function clearStatus():void
		{
			this.setStatus( "" );
		}
		/*
		*/
		public function setParameter( $name:String, $value:String ):void
		{
			var objParameters:Object = this.getParameters();
			objParameters[ $name ] = $value;
			this.setQuery( VariableUtil.serialize( objParameters ) );
		}
		public function getParameter($name:String):*
		{
			return this.getParameters()[ $name ];
		}
		
		public function setParameters($parameters:Object):void
		{
			this.setQuery( VariableUtil.serialize( $parameters ) );
		}
		public function getParameters():Object
		{
			var strQuery:String = this.getQuery();
			return VariableUtil.deserialize( strQuery );
		}
		/*
		Event Handlers
		*/
		private function onTrigger( $event:TriggerEvent ):void
		{
			this.checkForChange();
		}
		
		public function get available():Boolean
		{
			return ExternalInterface.available;
		}
	}
}