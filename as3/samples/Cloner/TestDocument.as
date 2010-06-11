package
{
	import com.bedrockframework.plugin.gadget.Cloner;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.loader.VisualLoader;
	import flash.events.MouseEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objCloner:Cloner;
		private var _objData:ClonerData;
		
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
			this._objData = new ClonerData;
			this._objData.total = 20;
			this._objData.spaceX = 75;
			this._objData.spaceY = 75;
			this._objData.paddingX = 5;
			this._objData.paddingY = 5;
			this._objData.pattern = ClonerData.GRID;
			this._objData.wrap = 5;
			this._objData.clone = BlueMovie;
			this._objData.positionClonesAt = ClonerData.COMPLETION;
			this._objData.autoSpacing = true;
			this._objData.autoPositioning = true;
			
			this._objCloner = new Cloner();
			this._objCloner.addEventListener(ClonerEvent.CREATE, this.onCloneCreate);
			this._objCloner.addEventListener(ClonerEvent.COMPLETE, this.onCloneComplete);
			this.addChild( this._objCloner );
			this._objCloner.initialize(this._objData);
			
			
			this.mcTemp.addEventListener(MouseEvent.MOUSE_DOWN, this.onChangeDown);
			this.mcTemp2.addEventListener(MouseEvent.MOUSE_DOWN, this.onCreateDown);
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		
		function onCloneCreate($event)
		{
			//objCloner.debug( $event.details );
		}
		function onCloneComplete($event)
		{
			//objCloner.positionClones();
		}
		
		function onChangeDown($event)
		{
			//trace($event.details.details.child);
			trace(this._objCloner.getClone(0).index);
			this._objData.wrap = 3;
			this._objCloner.clear();
			this._objCloner.initialize(this._objData);
		}
		function onCreateDown ($event)
		{
			this._objCloner.createClone()
		}

		
	}
}