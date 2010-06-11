package com.bedrockframework.plugin.data
{
	public class StageMonitorData
	{
		public static  const LEFT:String="left";
		public static  const RIGHT:String="right";
		public static  const CENTER:String="center";
		public static  const BOTTOM:String="bottom";
		public static  const TOP:String="top";
		public static  const NONE:String="none";
		
		public var horizontalAlignment:String;
		public var verticalAlignment:String;
		public var horizontalOffset:Number;
		public var verticalOffset:Number;
		
		public var widthResize:Boolean;
		public var heightResize:Boolean;

		public function StageMonitorData()
		{
			this.widthResize = false;
			this.heightResize = false;
			this.horizontalAlignment = StageMonitorData.NONE;
			this.verticalAlignment = StageMonitorData.NONE;
		}
	}
}