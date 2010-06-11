package com.bedrockframework.plugin.data
{
	
	public class TextDisplayData
	{
		public static const MULTI_LINE:String = "multi_line";
		public static const SINGLE_LINE:String = "single_line";
		public static const MULTI_SINGLE_LINE:String = "multi_single_line";
		
		public var text:String;
		
		public var mode:String;
		
		public var resourceKey:String;
		public var resourceGroup:String;
		
		public var width:Number;
		public var height:Number;
		
		public var styleName:String;
		public var styleObject:Object;
		
		public var autoLocale:Boolean;
		public var autoStyle:Boolean;
		
		public function TextDisplayData( )
		{
			this.text = "";
			this.width = 200;
			this.height = 50;
			
			this.autoLocale = false;
			this.autoStyle = true;
			
			this.mode = TextDisplayData.MULTI_LINE;
		}
		
	}
}