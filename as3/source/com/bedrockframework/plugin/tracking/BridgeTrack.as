package com.bedrockframework.plugin.tracking
{
	import com.bedrockframework.core.base.StandardWidget;
	
	import flash.external.ExternalInterface;

	public class BridgeTrack extends StandardWidget implements ITrackingService
	{
		public function BridgeTrack()
		{
		}
		public function track($details:Object):void
		{
			if (ExternalInterface.available) {
				this.status($details);
				ExternalInterface.call("doBridgeTrackMovieEvent", $details.event);
			}
		}
	}
}