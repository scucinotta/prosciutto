package com.bedrockframework.plugin.data
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class SuperShapeData
	{
		public static const BITMAP:String = "bitmap";
		public static const FILL:String = "fill";
		public static const GRADIENT:String = "gradient";
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		public static const LINEAR:String = GradientType.LINEAR;
		public static const RADIAL:String = GradientType.RADIAL;
		
		
		// Shared Properties
		public var type:String;
		public var width:int;
		public var height:int;
		public var matchStageSize:Boolean;
		public var matrix:Matrix;
		public var rotation:Number;
		public var rectangle:Rectangle;
		
		// Fill Properties
		public var fillColor:uint;
		public var alpha:Number;
		
		// Bitmap Properties
		public var bitmapData:BitmapData;
		public var repeat:Boolean
		public var smooth:Boolean

		
		// Gradient Properties
		public var gradientType:String;
		public var colors:Array;
		public var alphas:Array;
		public var ratios:Array;		
		public var spreadMethod:String
		public var interpolationMethod:String
		public var focalPointRatio:Number;		
		
		
		public function SuperShapeData()
		{
			this.width = 100;
			this.height = 100;

			this.type = SuperShapeData.FILL;
			this.rotation = 0;
			this.matrix = null;
			this.gradientType = GradientType.LINEAR;
			this.fillColor = 0xFF00FF;
			this.alpha = 1;
			this.repeat = true;
			this.smooth = true;
			this.matchStageSize = false;
			this.alphas = [1,1];
			this.ratios = [0, 255];
		}
		
	}
}