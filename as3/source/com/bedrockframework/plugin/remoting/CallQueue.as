package com.bedrockframework.plugin.remoting
{
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.event.CallQueueEvent;
	import com.bedrockframework.plugin.event.CallEvent;

	public class CallQueue extends DispatcherWidget
	{
		/*
		Variable Delarations
		*/
		private var _numCallIndex:int;
		private var _numTotalCalls:int;
		private var _arrQueue:Array;
		private var _bolComplete:Boolean;
		private var _bolRunning:Boolean;
		private var _numPercentage:Number;
		/*
		Constructor
		*/
		public function CallQueue()
		{
			this._arrQueue = new Array();
			this._numTotalCalls = 0;
			this._numCallIndex = 0;
			this._bolRunning=false;
			this._bolComplete=false;
		}
		
		public function reset():void
		{
			this._arrQueue = new Array();
			this._numTotalCalls = 0;
			this._numCallIndex = 0;
			this._bolRunning=false;
			this._bolComplete=false;
			this._numPercentage = 0;
			this.status("Reset");
			this.dispatchEvent(new CallQueueEvent(CallQueueEvent.RESET,this));
		}
		/*
		Add Listeners
		*/
		private function addListeners($target:*):void
		{
			$target.addEventListener(CallEvent.RESULT,this.onResult);
			$target.addEventListener(CallEvent.FAULT,this.onFault);
			
		}
		private function removeListeners($target:*):void
		{
			$target.removeEventListener(CallEvent.RESULT,this.onResult);
			$target.removeEventListener(CallEvent.FAULT,this.onFault);
		}
		/*
		Add a call to the queue, needs service, function name and parameters
		*/
		public function addToQueue($call:Call, ...$arguments:Array):void
		{
			if (this._bolComplete) {
				this.reset();
			}
			if (! this._bolRunning) {
				this._arrQueue.push({call:$call, arguments:$arguments});
				this._numTotalCalls=this._arrQueue.length;
			} else {
				this.status("Cannot add to queue while loading!","warning");
			}
		}
		/*
		
		*/
		public function runQueue():void
		{
			if (this._arrQueue.length > 0) {
				this.recalculate();
				this.begin();
			} else {
				this.status("Unable to call, queue is empty!","warning");
			}
		}
		/*
		
		*/
		private function begin():void
		{
			if (! this._bolRunning) {
				this._bolRunning=true;
				this.status("Begin Calling");
				this.doCall(0);
				this.dispatchEvent(new CallQueueEvent(CallQueueEvent.BEGIN,this,{total:this._numTotalCalls}));
			}
		}
		/*
		
		*/
		private  function doCall($index:int):void
		{
			this.recalculate();
			this._numCallIndex = $index;
			var objItem:Object = this.getItem($index);
			var objCall:Call = objItem.call;
			this.addListeners(objCall);
			objCall.execute.apply(this, objItem.arguments);
		}
		
		private function getItem($index:int):Object
		{
			return this._arrQueue[$index];	
		}
		
		private function callsComplete():void
		{
			this._bolComplete = true;
			this.dispatchEvent(new CallQueueEvent(CallQueueEvent.COMPLETE,this, {results:this.getResultArray(), result:this.getResultObject()}));
			this.status("Complete")
		}
		
		public function getResultArray():Array
		{
			var arrResults:Array = new Array();
			var numLength:int = this._arrQueue.length;
			for (var i:int = 0; i < numLength; i ++){
				arrResults.push(this._arrQueue[i].result)
			}
			return arrResults;
		}
		public function getResultObject():Object
		{
			var objResult:Object = new Object();
			var numLength:int = this._arrQueue.length;
			for (var i:int = 0; i < numLength; i ++){
				objResult[this._arrQueue[i].call] = this._arrQueue[i].result;
			}
			return objResult;
		}
		
		private function callNext():void
		{
			if (this._bolRunning) {
				var numTempIndex:Number=this._numCallIndex + 1;
				if (numTempIndex != this._numTotalCalls) {
					this.doCall(numTempIndex);
					var objDetails:Object = {call:this.getItem(numTempIndex).call.call,total:this._numTotalCalls, index:this._numCallIndex}
					this.dispatchEvent(new CallQueueEvent(CallQueueEvent.NEXT,this, objDetails));
				} else {
					this.callsComplete();
				}
			}
		}
		/*
		
		*/
		private function recalculate():void
		{
			this._numPercentage=Math.round(this._numCallIndex / this._numTotalCalls * 100);
		}
		/*
		Event Handlers
		*/
		private function onResult($event:CallEvent):void
		{
			var objItem:Object = this.getItem(this._numCallIndex);
			objItem.result = $event.details;
			this.removeListeners(objItem.call);
			this.callNext();
		}
		private function onFault($event:CallEvent):void
		{
			this.reset();
			this.dispatchEvent(new CallQueueEvent(CallQueueEvent.ERROR, this, $event.details));
		}
		
	}
}