package com.bedrockframework.plugin.data
{
	public class VideoPlayerData
	{
		public var width:Number;
		public var height:Number;
		public var smoothing:Boolean;
		public var deblocking:int;
		public var bufferTime:Number;
		public var loadAndPause:Boolean;
		public var connection:String;
		public var url:String;
		
		public function VideoPlayerData()
		{
			this.width = 320;
			this.height = 240;
			this.loadAndPause = false;
			this.smoothing = true;
		}
	}
}