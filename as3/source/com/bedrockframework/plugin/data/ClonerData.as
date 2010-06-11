package com.bedrockframework.plugin.data
{
	import flash.display.DisplayObjectContainer;
	
	public class ClonerData
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		public static const LINEAR:String = "linear";
		public static const GRID:String = "grid";
		public static const RANDOM:String = "random";
		
		public static const CREATION:String = "creation";
		public static const COMPLETION:String = "completion";

		public var spaceX:int;
		public var spaceY:int;
		public var rangeX:int;
		public var rangeY:int;
		
		public var offsetX:int;
		public var offsetY:int;
		
		public var wrap:uint;
		public var total:uint;

		public var direction:String;
		public var pattern:String;
		
		public var paddingX:int;
		public var paddingY:int;
		
		public var autoSpacing:Boolean;
		public var autoPositioning:Boolean;
		
		public var clone:Class;
		
		public var positionClonesAt:String;

		public function ClonerData():void
		{
			this.autoSpacing = false;
			this.autoPositioning = true;
			
			this.wrap = 0;
			this.total = 0;
			
			this.direction = ClonerData.VERTICAL;
			this.pattern = ClonerData.LINEAR;
			
			this.positionClonesAt = ClonerData.CREATION;
		}

	}

}