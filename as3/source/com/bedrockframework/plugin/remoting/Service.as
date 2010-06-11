package com.bedrockframework.plugin.remoting {
	
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.event.ServiceEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	
	public dynamic class Service extends DispatcherWidget 
	{
		
		public static var objectEncoding:uint = ObjectEncoding.AMF3;
		private var _objConnection:NetConnection;
		private var _strGateway:String;
		private var _strPath:String;
				
		/**
		 * Constructor
		 * 
		 * <P>
		 * This constructs the <code>ServiceProxy</code> class.
		 * 
		 * @param gateway the url of the gateway
		 * @param service the name of the service
		 */
		public function Service($gateway:String, $path:String) {
			if($gateway == null) {
				throw new Error("The gateway parameter is required in the Service class.");
			}
			this._strGateway = $gateway;
			this._strPath = $path;

			this._objConnection = new NetConnection();
			this._objConnection.client = this;
			this._objConnection.addEventListener(NetStatusEvent.NET_STATUS, this.onConnectionStatus);
			this._objConnection.addEventListener(IOErrorEvent.IO_ERROR, this.onConnectionError);
			this._objConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR , this.onConnectionError);
			this._objConnection.objectEncoding = Service.objectEncoding;
			try{
				this._objConnection.connect(this._strGateway);
				this.status("Connected to - " + this._strGateway);
			}catch($error:Error){
				this.warning("Could not connect to remote service!");
			}finally{
				//this._objConnection.connect(strGateway);
			}
			
		}
		
		

		/**
		 * Appends additional information to the gateway url
		 * 
		 * @param value object to be appended to the url
		 */
		public function appendToGatewayUrl($value:String):void {
			this._strGateway += $value;
		}		
		/**
		 * Dispatches a fault event on a connection error
		 */
		private function onConnectionError(event:ErrorEvent):void
		{
			this.dispatchEvent(new ServiceEvent(ServiceEvent.CONNECTION_ERROR, this, {text:"Connection Error: " + event.text}));
		}		
		/**
		 * Dispatches a fault event on a connection error
		 */
		private function onConnectionStatus($event:NetStatusEvent):void {
			var objInfo:Object = $event.info;
			this.status("Connection Status - " + objInfo.code)
			switch(objInfo.code) {
				case "NetConnection.Connect.Failed":
					this.dispatchEvent(new ServiceEvent(ServiceEvent.CONNECTION_ERROR, this, {text:"Connection Error: " + $event.info.code}));
					break;
				default :
					this.dispatchEvent(new ServiceEvent(ServiceEvent.STATUS, this, objInfo));
					break;
			}
		}
		/*
		Property Definitions
		*/
		public function set objectEncoding($encoding:uint):void{
			 this._objConnection.objectEncoding = $encoding;
		}
		public function get objectEncoding():uint{
			return this._objConnection.objectEncoding
		}
		
		public function get connection():NetConnection
		{
			return this._objConnection;
		}
		public function get path():String
		{
			return this._strPath;
		}
	}
}