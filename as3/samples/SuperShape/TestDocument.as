package
{

	import com.bedrockframework.plugin.display.SuperShape;
	import com.bedrockframework.plugin.data.SuperShapeData;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		
		private var _objSuperShape:SuperShape;
		
		/*
		Constructor
		*/
		public function TestDocument()
		{
			this.stage.showDefaultContextMenu = false;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			//
			this.loaderInfo.addEventListener(Event.INIT, this.onBootUp);
		}

		/*
		Basic view functions
	 	*/
		public function initialize():void
		{
			this._objSuperShape = new SuperShape();
			var objData:SuperShapeData = new SuperShapeData();
			objData.type = SuperShapeData.BITMAP;
			//objData.matchStageSize = true;
			objData.bitmapData = new MarioTile(0,0);
			this.addChild(this._objSuperShape);
			this._objSuperShape.initialize(objData);
			this._objSuperShape.width = this.stage.stageWidth;
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