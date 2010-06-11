package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.IPreloaderManager;
	import com.bedrockframework.engine.bedrock;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.event.StopWatchEvent;
	import com.bedrockframework.plugin.event.TriggerEvent;
	import com.bedrockframework.plugin.timer.StopWatch;
	import com.bedrockframework.plugin.timer.TimeoutTrigger;
	import com.bedrockframework.plugin.util.MathUtil;
	
	public class PreloaderManager extends StandardWidget implements IPreloaderManager
	{
		/*
		Variable Declarations
		*/
		private var _objTimeout:TimeoutTrigger;
		private var _numPercentage:Number;
		private var _objStopWatch:StopWatch;
		private var _bolTimerDone:Boolean;
		private var _bolLoaderDone:Boolean;
		private var _objShellData:PreloaderData;
		private var _objPageData:PreloaderData;
		private var _objCurrentData:PreloaderData;
		/*
		Constructor
		*/
		public function PreloaderManager()
		{
			
		}
		public function initialize( $shellPreloaderTime:Number = 0, $pagePreloaderTime:Number = 0 ):void
		{
			this._objShellData = new PreloaderData( $shellPreloaderTime );
			this._objPageData = new PreloaderData( $pagePreloaderTime );
			
			this.setMode( BedrockData.SHELL_PRELOADER ); 
			
			this.createTimers($shellPreloaderTime);
			this.createListeners();
		}
		private function createListeners():void
		{
			BedrockDispatcher.addEventListener(BedrockEvent.LOAD_BEGIN, this.onLoadBegin);
			BedrockDispatcher.addEventListener(BedrockEvent.LOAD_PROGRESS, this.onLoadProgress);
			BedrockDispatcher.addEventListener(BedrockEvent.LOAD_COMPLETE, this.onLoadComplete);
		}
		private function createTimers($preloaderTime:Number = 0):void
		{
			this._objTimeout = new TimeoutTrigger($preloaderTime);
			this._objTimeout.addEventListener( TriggerEvent.TRIGGER, this.onTimeout );
			this._objTimeout.silenceLogging  = true;
			
			this._objStopWatch = new StopWatch;
			this._objStopWatch.addEventListener( StopWatchEvent.UPDATE, this.onUpdate);
			this._objStopWatch.silenceLogging  = true;
		}
		/*
		Set Mode
		*/
		public function setMode( $status:String ):void
		{
			switch ( $status ) {
				case BedrockData.SHELL_PRELOADER :
					this._objCurrentData = this._objShellData;
					break;
				case BedrockData.PAGE_PRELOADER :
					this._objCurrentData = this._objPageData;
					break;
			}
		}
		/*
		Update
		*/
		private function startPreloader():void
		{
			this._numPercentage = 0;
			this._bolLoaderDone = false;
			this._bolTimerDone = false;
			if ( this._objCurrentData.useTimer ) {
				this._objTimeout.start( this._objCurrentData.timeInSeconds );
				this._objStopWatch.start();
			}
			this.updatePreloader( this._numPercentage );
		}
		private function stopPreloader():void
		{
			if (this._objCurrentData.useTimer) {
				if ( this._bolTimerDone && this._bolLoaderDone ) {
					this.killPreloader();
				}				
			} else {
				this.killPreloader();
			}
		}
		private function killPreloader():void
		{
			this._numPercentage = 100;
			if (this._objCurrentData.useTimer) {
				this._objTimeout.stop();
				this._objStopWatch.stop();
				this._objStopWatch.clear();
			}
			this.updatePreloader(this._numPercentage);
			BedrockEngine.bedrock::transitionManager.preloaderView.outro();
		}
		private function updatePreloader($percent:Number):void
		{
			var numPercentage:uint = this.calculatePercentage($percent);
			BedrockEngine.bedrock::transitionManager.preloaderView.displayProgress( numPercentage );
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.PRELOADER_UPDATE, this, { percentage:numPercentage } ) );
		}
		private function calculatePercentage($percent:Number):uint
		{
			var numPercentage:uint;
			if ( this._objCurrentData.useTimer ) {
				var numTimerPercentage:uint = MathUtil.calculatePercentage( this._objStopWatch.elapsedMilliseconds, this._objCurrentData.timeInMilliseconds );
				numPercentage = (numTimerPercentage < this._numPercentage) ? numTimerPercentage : this._numPercentage;
			} else {
				numPercentage =  this._numPercentage;
			}
			return numPercentage;
		}
		/*
		Framework Event Handlers
		*/
		private function onLoadBegin($event:BedrockEvent):void
		{
			this.startPreloader();
		}
		private function onLoadProgress($event:BedrockEvent):void
		{
			this._numPercentage = $event.details.overallPercent;
			this.updatePreloader($event.details.overallPercent);
		}
		private function onLoadComplete($event:BedrockEvent):void
		{
			this._bolLoaderDone = true;
			this.stopPreloader();
		}
		
		/*
		Trigger Handlers
		*/
		private function onUpdate( $event:StopWatchEvent ):void
		{
			this.updatePreloader(this._numPercentage);
		}
		private function onTimeout($event:TriggerEvent):void
		{
			this._bolTimerDone = true;
			this.stopPreloader();
		}
		
	}

}
	

class PreloaderData
{
	public var timeInSeconds:Number;
	public var timeInMilliseconds:Number;
	public var useTimer:Boolean;
	
	public function PreloaderData( $time:Number ):void
	{
		this.timeInSeconds = $time;
		this.timeInMilliseconds = $time * 1000;
		this.useTimer = ( this.timeInSeconds == 0 ) ? false : true;
	}
}
