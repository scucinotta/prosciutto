package
{
	import com.bedrockframework.plugin.tools.Pagination;

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
			var objPagination = new Pagination();
			objPagination.update(41, 10);
			trace(objPagination.selectedPage);
			objPagination.nextPage();
			trace(objPagination.hasNextPage());
			objPagination.nextPage();
			trace(objPagination.hasNextPage());
			objPagination.nextPage();
			objPagination.nextPage();
			objPagination.nextPage();
			objPagination.nextPage();
			objPagination.nextPage();
			trace(objPagination.hasNextPage());
			objPagination.previousPage();
			trace(objPagination.hasPreviousPage());
			objPagination.previousPage();
			trace(objPagination.hasPreviousPage());
			objPagination.previousPage();
			trace(objPagination.hasPreviousPage());
			objPagination.previousPage();
			trace(objPagination.hasPreviousPage());
			objPagination.previousPage();
			trace(objPagination.hasPreviousPage());
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