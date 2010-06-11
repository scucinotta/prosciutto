package com.bedrockframework.engine.api
{
	public interface IDeeplinkManager
	{
		function initialize():void;
		/*
		Set Mode
		*/
		function setPath( $value:String ):void;
		function getPath():String;
		function clearPath():void;
		
		function setPathHierarchy( $paths:Array ):void;
		function getPathHierarchy():Array;
		
		function setAddress( $value:String ):void;
		function getAddress():String;
		function clearAddress():void;
		
		function setQuery( $value:String ):void;
		function getQuery():String;
		function clearQuery():void;
		
		function setTitle( $value:String ):void;
		function getTitle():String;
		function clearTitle():void;
		
		function setStatus( $value:String ):void;
		function getStatus():String;
		function clearStatus():void;
		
		function setParameter( $name:String, $value:String ):void;
		function getParameter($name:String):*;
		
		function setParameters($parameters:Object):void;
		function getParameters():Object;
	}
}