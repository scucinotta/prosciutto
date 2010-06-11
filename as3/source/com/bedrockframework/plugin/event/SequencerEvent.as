package com.bedrockframework.plugin.event
{
	import com.bedrockframework.core.event.GenericEvent;

	public class SequencerEvent extends GenericEvent
	{		
		public static  const INITIALIZE_COMPLETE:String = "SequencerEvent.onNext";
		public static  const INTRO_COMPLETE:String = "SequencerEvent.onNext";
		public static  const OUTRO_COMPLETE:String = "SequencerEvent.onPrevious";
	
		public static const SHOW:String = "SequencerEvent.onShow";
		public static const NEXT:String = "SequencerEvent.onNext";
		public static const PREVIOUS:String = "SequencerEvent.onPrevious";
		public static const BEGINNING:String =  "SequencerEvent.onBeginning";
		public static const ENDING:String =  "SequencerEvent.onEnding";
		
		public function SequencerEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=true)
		{
			super($type, $origin, $details, $bubbles, $cancelable);
		}
	}
}