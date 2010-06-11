package
{
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.gadget.PaginationCloner;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objPaginationCloner:PaginationCloner;
		
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
			var objClonerData = new ClonerData();
			objClonerData.spaceX = 51;
			objClonerData.spaceY = 51;
			objClonerData.pattern = "grid";
			objClonerData.wrap = 3;
			objClonerData.clone = Square;
			
			this._objPaginationCloner = new PaginationCloner();
			this.addChild( this._objPaginationCloner );
			
			this._objPaginationCloner.initialize(objClonerData)
			
			var numLength:Number =  50;
			var arrData:Array = new Array()
			for (var i = 0; i < numLength; i ++) { 
				arrData.push(i)
			}
			
			
			this._objPaginationCloner.populate(arrData, 4)
			
			mcNext.addEventListener("click", this.onNextClicked)
			mcPrevious.addEventListener("click", this.onPreviousClicked)
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		function onNextClicked ($event) {
			this._objPaginationCloner.nextPage();
		}
		
		function onPreviousClicked ($event) {
			this._objPaginationCloner.previousPage();
		}
		
	}
}