package com.bedrockframework.engine.model
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.api.IState;
		
	public class State extends StandardWidget implements IState
	{
		/*
		Variable Declarations
		*/
		public static const INITIALIZED:String="initialized";
		public static const AVAILABLE:String="available";
		public static const UNAVAILABLE:String="unavailable";
		
		private var _strCurrent:String;
		private var _strPrevious:String;
		
		private var _bolSiteRendered:Boolean;
		private var _bolSiteInitialized:Boolean;
		private var _bolDoneDefault:Boolean;
		private var _bolTransitioning:Boolean;
		/*
		Constructor
		*/
		public function State()
		{
			this._bolSiteRendered = false;
			this._bolSiteInitialized = false;
			this._bolDoneDefault = false;
			this._bolTransitioning = false;
			
			this.clear();
			this.change(State.INITIALIZED);
		}
		/*
		Set 
		*/
		public function change($identifier:String):void
		{
			try {
				var strState:String=$identifier;
				if (strState != this._strCurrent) {
					this._strPrevious=this._strCurrent;
					this._strCurrent=strState;
					this.status("Changing state to - " + this._strCurrent);
				} else {
					this.warning("No stage change!");
				}
			} catch ($e:Error) {
				this.error("State does not exist!");
			}
		}
		/*
		Clear 
		*/
		public function clear():void
		{
			this._strCurrent=null;
			this._strPrevious=null;
		}
		/*
		Get Current 
		*/
		public function get current():String
		{
			return this._strCurrent;
		}
		/*
		Get Previous 
		*/
		public function get previous():String
		{
			return this._strPrevious;
		}
		/*
		*/
		public function set siteRendered($status:Boolean):void
		{
			this._bolSiteRendered = $status;
		}
		public function get siteRendered():Boolean
		{
			return this._bolSiteRendered;
		}
		
		public function set siteInitialized($status:Boolean):void
		{
			this._bolSiteInitialized = $status;
		}
		public function get siteInitialized():Boolean
		{
			return this._bolSiteInitialized;
		}
		
		public function set doneDefault($status:Boolean):void
		{
			this._bolDoneDefault = $status;
		}
		public function get doneDefault():Boolean
		{
			return this._bolDoneDefault;
		}
		
		public function set transitioning($status:Boolean):void
		{
			this._bolTransitioning = $status;
		}
		public function get transitioning():Boolean
		{
			return this._bolTransitioning;
		}
	}
}