package com.bedrockframework.engine.api
{
	public interface IHistory
	{
		
		
		function addHistoryItem($info:Object):void
		function getHistoryItem($index:Number):Object

		/*
		Get Current Queue
		*/
		function get current():Object
		/*
		Get Previous Queue
		*/
		function get previous():Object
		/*
		Get History
		*/
		function get list():Array
	}
}