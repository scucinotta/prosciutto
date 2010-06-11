package com.bedrockframework.engine.api
{
	public interface IState
	{
		/*
		Set 
		*/
		function change($identifier:String):void
		/*
		Clear 
		*/
		function clear():void
		/*
		Get Current 
		*/
		function get current():String
		/*
		Get Previous 
		*/
		function get previous():String
		/*
		*/
		function set siteRendered($status:Boolean):void;
		function get siteRendered():Boolean;
		function set siteInitialized($status:Boolean):void;
		function get siteInitialized():Boolean;
		function set doneDefault($status:Boolean):void;
		function get doneDefault():Boolean;
		function set transitioning($status:Boolean):void;
		function get transitioning():Boolean;
	}
}