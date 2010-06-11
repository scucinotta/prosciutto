package
{
	import com.bedrockframework.plugin.storage.SuperArray;

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
			var arrData:Array = new Array();

			var objOperator:SuperArray = new SuperArray(arrData);
			
			objOperator.push( 1 );
			objOperator.push( 2 );
			objOperator.push( 3 );
			objOperator.push( 4 );
			
			objOperator.swap( 1, 0 );
			
			trace(arrData);
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