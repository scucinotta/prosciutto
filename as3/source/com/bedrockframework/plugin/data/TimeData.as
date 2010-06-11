package com.bedrockframework.plugin.data
{
	import com.bedrockframework.plugin.util.TimeUtil;
	
	public class TimeData
	{
		public var minutes:uint;
		public var seconds:uint;
		public var milliseconds:uint;
		
		public var total:Number;
		
		public function TimeData()
		{
		}
		public function get displaySeconds():String
		{
			return TimeUtil.getDisplaySeconds( this.seconds );
		}
		public function get displayMinutes():String
		{
			return TimeUtil.getDisplayMinutes( this.minutes );
		}
		public function get displayMilliseconds():String
		{
			return TimeUtil.getDisplayMilliseconds( this.milliseconds );
		}
	}
}