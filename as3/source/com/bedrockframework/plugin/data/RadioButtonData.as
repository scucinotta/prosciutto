package com.bedrockframework.plugin.data
{
	public class RadioButtonData
	{
		public var index:uint;
		public var label:String;
		public var value:*;
		public var autoPopulate:Boolean;
		
		public function RadioButtonData()
		{
			this.label = "N/A";
			this.autoPopulate = true;
		}

	}
}