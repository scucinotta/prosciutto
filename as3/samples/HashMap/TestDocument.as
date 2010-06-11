package
{
	import com.bedrockframework.plugin.storage.HashMap;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		
		/*
		Constructor
		*/
		public function TestDocument()
		{
			this.loaderInfo.addEventListener(Event.INIT, this.onBootUp);
		}

		/*
		Basic view functions
	 	*/
		public function initialize():void
		{
			var objHash = new HashMap();
			objHash.saveValue("quiche", {id:140, text:"Mini Crustless Tofu Quiches"});
			objHash.saveValue("danish", {id:152, text:"Mmmmm delicious..."});
			trace(objHash.getValue("danish"));
			trace(objHash.pullValue("danish")); // will return and then delete the value
			trace(objHash.getValue("danish")); // value is gone at this point
			trace(objHash.getValue("quiche").text);
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
	}
}