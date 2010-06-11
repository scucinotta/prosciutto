package {
	import com.bedrockframework.plugin.data.RadioButtonData;
	import com.bedrockframework.plugin.event.RadioEvent;
	import com.bedrockframework.plugin.form.RadioButton;
	import com.bedrockframework.plugin.form.RadioGroup;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objRadioGroup:RadioGroup;
		public var radioButton1:RadioButton;
		public var radioButton2:RadioButton;
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
			this.createRadioGroup();
			this.createRadioButtons();
		}
		/*
		Creation Functions
		*/
		private function createRadioGroup():void
		{
			this._objRadioGroup = new RadioGroup;
			this._objRadioGroup.addEventListener(RadioEvent.SELECTED, this.onSelectRadio);
		}
		private function createRadioButtons():void
		{
			var objData1:RadioButtonData = new RadioButtonData;
			objData1.label = "To Be...";
			objData1.value = "No";
			this._objRadioGroup.addButton( this.radioButton1, objData1 );
			
			var objData2:RadioButtonData = new RadioButtonData;
			objData2.label = "Or Not To Be...";
			objData2.value = "Yes";
			this._objRadioGroup.addButton( this.radioButton2, objData2 );
			
			this._objRadioGroup.selectWithIndex( 0 );
			//this._objRadioGroup.selectWithValue( "Yes" );
		}
		/*
		Event Handlers
		*/
		private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		private function onSelectRadio( $event:RadioEvent ):void
		{
			trace( $event.details.index );
			trace( $event.details.value );
		}
	}
}
