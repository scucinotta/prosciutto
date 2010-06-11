package com.bedrockframework.plugin.data
{
	import com.bedrockframework.plugin.view.IView;
	
	import flash.display.Sprite;
	
	public class ViewStackData
	{
		public static const FORWARD:String = "forward";
		public static const REVERSE:String = "reverse";
		public static const SELECT:String = "select";
		
		private var _arrStack:Array;
		
		public var container:Sprite;
		public var mode:String;
		public var wrap:Boolean;
		public var addAsChildren:Boolean;
		
		public var startingIndex:uint;
		public var startingAlias:String;
		
		public var time:Number;
		public var timerEnabled:Boolean;
		
		public var autoInitialize:Boolean;
		public var autoStart:Boolean;
		
		public function ViewStackData():void
		{
			this._arrStack = new Array;
			this.startingIndex = 0;
			this.addAsChildren = true;
			this.wrap = true;
			this.time = 0;
			this.timerEnabled = false;
			this.mode = ViewStackData.SELECT;
			this.autoInitialize = true;
			this.autoStart = true;
		}
		
		public function addToStack($view:IView, $alias:String = null, $initializeData:Object = null, $introData:Object = null, $outroData:Object = null):void
		{
			this._arrStack.push( { view:$view, alias:$alias, initialize:$initializeData, intro:$introData, outro:$outroData } );
		}
		
		public function get stack():Array
		{
			return this._arrStack;
		}
	}
}