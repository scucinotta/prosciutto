package com.bedrockframework.plugin.util
{
	import com.bedrockframework.core.base.StaticWidget;
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	
	public class AlignmentUtil extends StaticWidget
	{
		public static  const LEFT:String="left";
		public static  const RIGHT:String="right";
		public static  const CENTER:String="center";
		public static  const BOTTOM:String="bottom";
		public static  const TOP:String="top";

		public static function alignHorizontal($target:DisplayObject,$alignment:String, $base:Number = 0, $offset:Number =0):void
		{
			var objTarget:DisplayObject=$target;
			var numSize:Number=objTarget.width;			
			var numBase:Number = $base
			var numOffset:Number = $offset;
			
			var numPosition:Number;
			switch ($alignment.toLowerCase()) {
				case AlignmentUtil.LEFT :
					numPosition=0+numOffset;
					break;
				case AlignmentUtil.CENTER :
					numPosition= ( ( numBase - numSize )  / 2 )+numOffset;
					break;
				case AlignmentUtil.RIGHT :
					numPosition=(numBase-numSize)+numOffset;
					break;

			}
			objTarget.x=numPosition;
		}
		public static function alignVertical($target:DisplayObject,$alignment:String, $base:Number = 0, $offset:Number =0):void
		{
			var objTarget:DisplayObject=$target;
			var numSize:Number=objTarget.height;
			var numBase:Number = $base;
			var numOffset:Number = $offset;
			
			var numPosition:Number;
			switch ($alignment.toLowerCase()) {
				case AlignmentUtil.TOP :
						numPosition=0+numOffset;
					break;
				case AlignmentUtil.CENTER :
					numPosition=( ( numBase - numSize )  / 2 )+numOffset;
					break;
				case AlignmentUtil.BOTTOM :
					numPosition=(numBase-numSize)+numOffset;
					break;
			}
			objTarget.y=numPosition;
		}
	}
}