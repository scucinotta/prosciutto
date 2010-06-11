package com.bedrockframework.plugin.remoting
{

	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.event.CallEvent;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.*;


	/**
	 * Operation
	 */
	public class Call extends DispatcherWidget
	{
		/*
		Variable Declarations
	 	*/
		public static  var TIMEOUT:Number = 60000; // 1 minute
		
		private var _objConnection:NetConnection;
		private var _strPath:String;
		private var _strCall:String;
		private var _objRemoteResponder:Responder;
		private var _arrArguments:Array;
		private var _numID:uint;
		private var _objService:Service;
		private var _objLocalResponder:IResponder;
		public var result:Function;
		public var fault:Function;
		/**
		 * Contains the information to be performed
		 */
		public function Call($call:String, $service:Service, $result:Function=null, $fault:Function=null)
		{
			super(false);
			this._strCall = $call;
			this.setup($service);
			if ($result != null) this.result = $result;
			if ($fault != null) this.fault = $fault;
		}
		/*
		Setup the info the call will need
		*/
		public function setup($service:Service):void
		{
			this._objService = $service;
			this._objConnection = this._objService.connection;
			this._strPath = this._objService.path;
		}
		/*
		Clear Everything
	 	*/
	 	public function clear():void
		{
			this._objLocalResponder = null;
			this.result = null;
			this.fault = null;
		}
		/*
		Execute the call
		*/
		public function execute(... $arguments:Array):void
		{
			this._arrArguments = $arguments;
			this.status("Calling - "+ this._strPath + "." + this._strCall);
			this._objRemoteResponder = new Responder(this.onResult, this.onFault);
			var arrTemp:Array = new Array(this._strPath + "." + this._strCall, this._objRemoteResponder);
			this._objConnection.call.apply(this._objConnection, arrTemp.concat(this._arrArguments));
			this._numID = setTimeout(this.onTimeout, Call.TIMEOUT);
		}		
		/*
		Call External Targets
	 	*/
	 	private function callResult($data:Object):void
		{
			if (this.responder != null) this.responder.result($data);
			if (this.result != null) this.result($data);
			this.dispatchEvent(new CallEvent(CallEvent.RESULT, this, $data));			
		}
		private function callFault($data:Object):void
		{
			if (this.responder != null) this.responder.fault($data);		
			if (this.fault != null) this.fault($data);	
			this.dispatchEvent(new CallEvent(CallEvent.FAULT, this, $data));
		}
		/*
		Event Handlers
	 	*/
		private function onResult($data:Object):void
		{
			this.status("Call successful!");
			clearTimeout(this._numID);
			var objResult:Object = $data || {};
			objResult.call = this._strCall;
			this.callResult(objResult);
		}
		private function onFault($data:Object):void
		{
			this.warning("Call failed!");
			clearTimeout(this._numID);
			var objResult:Object = $data || {};
			objResult.call = this._strCall;
			this.callFault(objResult);
		}
		private function onTimeout():void
		{
			this.warning("Connection Error - Call timed out!");
			this.callFault({text:"Connection Error: Call timed out!"});
		}
		/*
		Property Definitions
		*/
		public function set responder($responder:IResponder):void
		{
			this._objLocalResponder = $responder;
		}
		public function get responder():IResponder
		{
			return this._objLocalResponder;
		}
		public static function set timeout($milliseconds:uint):void
		{
			Call.TIMEOUT = $milliseconds;
		}
		public function get call():String
		{
			return this._strCall;
		}
		
	}
}