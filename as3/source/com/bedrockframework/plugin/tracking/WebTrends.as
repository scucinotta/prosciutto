package com.bedrockframework.plugin.tracking
{
	import com.bedrockframework.core.base.StandardWidget;
	
	import flash.external.ExternalInterface;

	public class WebTrends extends StandardWidget implements ITrackingService
	{
		/*
		Constructor
		*/
		public function WebTrends()
		{
		}
		/**
		 * Will make the call to javascript using the external interface.
		 * @param $details Generic object which will contain all of the necessary information for tracking.
		 */
		public function track($details:Object):void
		{
			if (ExternalInterface.available) {
				this.status( $details );
				var strURL:String = $details.url || ( $details.page + "/" + $details.item );
				var arrItems:Array = this.buildParameters( strURL, $details.groups );
				this.attention( arrItems );
				ExternalInterface.call.apply( null, arrItems );
			}
		}
		private function buildParameters($url:String, $groups:Array = null ):Array
		{
			var arrParameters:Array = new Array;
			arrParameters.push("dcsMultiTrack");
			arrParameters.push("DCS.dcsuri");
			arrParameters.push($url);
			
			if ( $groups != null ) {
				var numLength:int = $groups.length;
				for (var i:int = 0 ; i < numLength; i++) {
					if ($groups[i].value != null) {
						arrParameters.push($groups[i].name || "WT.ti");
						arrParameters.push($groups[i].value);
					}
				}
			}
			return arrParameters;
		}
	}
}