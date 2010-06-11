package com.bedrockframework.plugin.timer
{
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.data.TimeData;
	import com.bedrockframework.plugin.event.StopWatchEvent;
	import com.bedrockframework.plugin.util.TimeUtil;
	
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;

	public class StopWatch extends DispatcherWidget
	{
		/*
		Variable Declarations
		*/
		private var _numStart:uint;
		private var _numEnd:uint;
		private var _numDifference:uint;
		private var _numID:uint;
		private var _bolRunning:Boolean;
		private var _numInterval:Number;
		/*
		Constructor
		*/
		public function StopWatch( $interval:Number = 1 )
		{
			this._numInterval = $interval;
			this.clear();
		}
		/*
		Start the timer
		*/
		public function start( $interval:Number = 1 ):void
		{
			if (!this._bolRunning){
				this.status("Start");
				this.clear();
				this._bolRunning = true;
				this._numInterval = ($interval != -1) ? $interval : this._numInterval;
				this.dispatchEvent(new StopWatchEvent(StopWatchEvent.START, this) );
				this._numStart = getTimer();
				this._numID = setInterval( this.update, this._numInterval );
			}
		}
		/*
		Stop the timer
		*/
		public function stop():void
		{
			if (this._bolRunning) {
				var objElapsed:TimeData = this.elapsed;
				clearInterval(this._numID);
				this.status("Time Elapsed\n	- Minutes : " + objElapsed.minutes + "\n	- Seconds : " + objElapsed.seconds + "\n	- Milliseconds : " + objElapsed.milliseconds + "\n	- Total : " + objElapsed.total);
				this.dispatchEvent( new StopWatchEvent(StopWatchEvent.STOP, this, objElapsed) );
				this._bolRunning = false;
			}		
		}
		/*
		Clear the timer
		*/
		public function clear():void
		{
			this._numStart = 0;
			this._numEnd = 0;
			this._numDifference = 0;
			this._bolRunning = false;
		}
		/*
		Update difference
		*/
		private function refresh():void
		{
			this._numEnd = getTimer();
			this._numDifference = (this._numEnd - this._numStart);
		}
		private function update():void
		{
			this.dispatchEvent( new StopWatchEvent( StopWatchEvent.UPDATE, this, this.elapsed ) );
		}
		/*
		Get elapsed time
		*/
		public function get elapsed():TimeData
		{
			this.refresh();
			return TimeUtil.parseMilliseconds(this._numDifference);
		}
		public function get elapsedMilliseconds():uint
		{
			this.refresh();
			return this._numDifference;
		}
		/*
		Check wether or not the timer is running
		*/
		public function get running():Boolean
		{
			return this._bolRunning;
		}
	}
}