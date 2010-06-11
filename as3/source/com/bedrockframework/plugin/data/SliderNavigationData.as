package com.bedrockframework.plugin.data
{
	import com.bedrockframework.plugin.data.ClonerData;
	import com.greensock.easing.Quad;

	public class SliderNavigationData extends ClonerData
	{
		public var width:Number;
		public var height:Number;
		public var visibleItems:uint;
		
		public var alwaysShowMaxItems:Boolean;
		
		public var time:Number;
		public var ease:Function;
		
		public function SliderNavigationData()
		{
			this.width = 100;
			this.height = 100;
			this.visibleItems = 0;
			
			this.alwaysShowMaxItems = false;
			
			this.time = 1;
			this.ease = Quad.easeOut;
		}
		
	}
}