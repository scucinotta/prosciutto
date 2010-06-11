package com.bedrockframework.plugin.gadget
{
	/**
	* Handles the positioning and resizing of targets relative to the stage
	*
	* @author Alex Toledo
	* @version 1.0.0
	* @created Wed May 21 2008 10:36:34 GMT-0400 (EDT)
	*/
	import com.bedrockframework.core.base.StaticWidget;
	import com.bedrockframework.core.logging.LogLevel;
	import com.bedrockframework.core.logging.Logger;
	import com.bedrockframework.plugin.data.StageMonitorData;
	import com.bedrockframework.plugin.storage.HashMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;

	public class StageMonitor extends StaticWidget
	{
		/*
		Variable Declarations
		*/
		private static var __objStage:Stage;
		private static var __mapTargets:HashMap;
		/*
		Constructor
		*/
		Logger.log(StageMonitor, LogLevel.CONSTRUCTOR, "Constructed");
		/*
		Initialize passing in an instance of stage
	 	*/
	 	public static function initialize($stage:Stage):void
		{
			StageMonitor.__mapTargets = new HashMap;
			StageMonitor.__objStage = $stage;
			StageMonitor.__objStage.addEventListener(Event.RESIZE, StageMonitor.onResize);
		}
		/*
		Add/ Remove targets from the hash map
	 	*/
	 	public static function addTarget($name:String, $target:DisplayObjectContainer, $data:StageMonitorData, $auto:Boolean = true):void
		{
			if (StageMonitor.__objStage != null) {
				StageMonitor.__mapTargets.saveValue($name, {target:$target, data:$data});
				if ($auto) StageMonitor.updateTarget($target, $data);
			} else {
				Logger.log(StageMonitor, LogLevel.ERROR, "Stage value is null!");
			}
		}
		public static function removeTarget($name:String):void
		{
			StageMonitor.__mapTargets.removeValue($name);
		}
		/*
		Resize single target relative to the stage
	 	*/
	 	private static function resizeTarget($target:DisplayObjectContainer, $data:StageMonitorData):void
		{
			if ($data.widthResize) $target.width = StageMonitor.__objStage.stageWidth;
			if ($data.heightResize) $target.height = StageMonitor.__objStage.stageHeight;
		}
		/*
		Align single target relative to the stage
	 	*/
	 	private static function alignTarget($target:DisplayObjectContainer, $data:StageMonitorData):void
		{
			$target.x = StageMonitor.getHorzontalPosition($target, $data.horizontalAlignment, $data.horizontalOffset);
			$target.y = StageMonitor.getVerticalPosition($target, $data.verticalAlignment, $data.verticalOffset);
		}
	 	/*
		Resize and align all available target relative to the stage
	 	*/
	 	public static function updateAvailableTargets():void
		{
			var arrTargets:Array = StageMonitor.__mapTargets.getValues();
			var numLength:int = arrTargets.length;
			for (var i:int = 0 ; i < numLength; i++) {
				StageMonitor.updateTarget(arrTargets[i].target, arrTargets[i].data);
			}
		}
		/*
		Resize and align single target relative to the stage
	 	*/
		private static function updateTarget($target:DisplayObjectContainer, $data:StageMonitorData):void
		{
			StageMonitor.alignTarget($target, $data);
			StageMonitor.resizeTarget($target, $data);
		}
		/*
		Position calculations
	 	*/
		private static function getHorzontalPosition($target:DisplayObjectContainer, $alignment:String, $offset:int):Number
		{
			var numPosition:Number = 0;
			var objPoint:Point = $target.parent.globalToLocal(new Point(0, 0));
			switch ($alignment) {
				case StageMonitorData.LEFT :
					numPosition = objPoint.x + $offset;
					break;
				case StageMonitorData.CENTER :
					numPosition = objPoint.x + ((StageMonitor.__objStage.stageWidth/2) + $offset);
					break;
				case StageMonitorData.RIGHT :
					numPosition = objPoint.x + (StageMonitor.__objStage.stageWidth + $offset);
					break;
				case StageMonitorData.NONE :
					numPosition = $target.x;
					break;
			}
			return numPosition;
		}
		private static function getVerticalPosition($target:DisplayObjectContainer, $alignment:String, $offset:int):Number
		{
			var numPosition:Number = 0;
			var objPoint:Point = $target.parent.globalToLocal(new Point(0, 0));
			switch ($alignment) {
				case StageMonitorData.TOP :
					numPosition = objPoint.y + $offset;
					break;
				case StageMonitorData.CENTER :
					numPosition = objPoint.y + ((StageMonitor.__objStage.stageHeight/2) + $offset);
					break;
				case StageMonitorData.BOTTOM :
					numPosition = objPoint.y + (StageMonitor.__objStage.stageHeight + $offset);
					break;
				case StageMonitorData.NONE :
					numPosition = $target.y;
					break;
			}
			return numPosition;
		}
		/*
		Event Handlers
	 	*/
	 	private static function onResize($event:Event):void
		{
			StageMonitor.updateAvailableTargets();
		}
	}
}