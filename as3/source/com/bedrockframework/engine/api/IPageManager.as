package com.bedrockframework.engine.api
{
	import com.bedrockframework.engine.view.ContainerView;
	
	public interface IPageManager
	{
		function initialize($autoDefault:Boolean = true):void
		function setupPageLoad($page:Object):void
		function getDefaultPage($details:Object = null):String
		/*
		Set Queue
		*/
		function setQueue($page:Object):Boolean
		/*
		Load Queue
		*/
		function loadQueue():Object
		/*
		Clear Queue
		*/
		function clearQueue():void
		/*
		Get Queued Page
		*/
		function get queue():Object
		/*
		Get Current Page
		*/
		function get current():Object
		/*
		Get Previous Page
		*/
		function get previous():Object
	}
}