package com.bedrockframework.engine.api
{
	import com.bedrockframework.engine.view.ContainerView;
	
	import flash.display.DisplayObjectContainer;
	
	
	public interface IContainerManager
	{
		function initialize($root:DisplayObjectContainer):void;
		function createContainer($name:String,$child:DisplayObjectContainer=null,$properties:Object=null,$container:DisplayObjectContainer=null,$depth:int=-1):*;
		function replaceContainer($name:String,$child:DisplayObjectContainer,$properties:Object=null,$container:DisplayObjectContainer=null,$depth:int=-1):*;
		function buildLayout($layout:Array):void;
		
		function createPageLoader():void;
		/*
		Depth Functions
		*/
		function getDepth($name:String):int;
		/*
		Container Functions
		*/
		function getContainer($name:String):*;
		function getContainerParent($name:String):*;
		function removeContainer($name:String):void;
		function hasContainer($name:String):Boolean;
		/*
		Swapping Functions
		*/
		function swapChildren($name1:String,$name2:String):void;
		function swapTo($name:String,$depth:Number):void;
		function swapToTop($name:String,$offset:Number=0):void;		
		function swapToBottom($name:String,$offset:Number=0):void;
		/*
		Property Definitions
		*/
		function get root():DisplayObjectContainer;
		function get pageContainer():ContainerView;
		function get preloaderContainer():ContainerView;
	}
}