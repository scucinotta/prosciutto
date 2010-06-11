package com.bedrockframework.plugin.data
{
	public class YouTubePlayerData
	{
		public static const REAL:String = "real";
		public static const FAKE:String = "fake";
		
		public static const SMALL:String = "small";
		public static const MEDIUM:String = "medium";
		public static const LARGE:String = "large";
		public static const HD720:String = "hd720";
		public static const DEFAULT:String = "default";
		
		public var width:Number;
		public var height:Number;
		public var playerURL:String;
		public var autoQueue:Boolean;
		public var allowSeekAhead:Boolean;
		public var id:String;
		public var quality:String;
		public var completeType:String;
		
		public var fakePercentage:uint;
		
		public function YouTubePlayerData()
		{
			this.width = 320;
			this.height = 240;
			this.autoQueue = true;
			this.allowSeekAhead = true;
			this.quality = YouTubePlayerData.DEFAULT;
			this.playerURL = "http://www.youtube.com/apiplayer?version=3";
			this.completeType = YouTubePlayerData.REAL;
			this.fakePercentage = 99;
		}

	}
}