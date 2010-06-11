package com.bedrockframework.plugin.form
{
	// Alex, you need to clean this up
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.data.RadioButtonData;
	import com.bedrockframework.plugin.event.RadioEvent;
	import com.bedrockframework.plugin.util.ArrayUtil;
	
	public class RadioGroup extends DispatcherWidget
	{
		/*
		Variable Declarations
		*/
		private var _arrRadioButtons:Array;
		private var _arrData:Array;
		private var _numSelected:int;
		/*
		Constructor
		*/		
		public function RadioGroup()
		{
			this._arrRadioButtons = new Array();
			this._arrData = new Array();
			this._numSelected = -1;
		}
		/**
		 * Add a new button to the radio button array.
	 	*/
		public function addButton($radio:RadioButton, $data:RadioButtonData):void
		{
			$data.index = this._arrRadioButtons.length;
			$radio.index = this._arrRadioButtons.length;
			$radio.group = this;
			$radio.data = $data;
			this._arrRadioButtons.push( $radio );
			this._arrData.push( $data );
		}
		/*
		Manages the states of the radio buttons
	 	*/
		private function manageSelection():void
		{
			var numLength:int = this._arrRadioButtons.length;
			for (var i:int = 0 ; i < numLength; i++) {
				if (i == this.selectedIndex) {
					this.getRadioButton(i).select();
				} else {
					this.getRadioButton(i).deselect();
				}
			}
		}
		
		public function selectWithIndex( $index:int ):void
		{
			this._numSelected = $index;
			this.manageSelection();
			this.dispatchEvent( new RadioEvent( RadioEvent.SELECTED, this, this._arrRadioButtons[ $index ].data ) );
		}
		public function selectWithValue( $value:* ):void
		{
			var numIndex:int  = ArrayUtil.findIndex( this._arrData, $value, "value" );
			if ( numIndex != - 1 ) {
				this.selectWithIndex( numIndex );
			} else {
				this.warning( "Value not found!" );
			}
		}
		/*
		Get Radio Button
		*/
		private function getRadioButton($index:uint):RadioButton
		{
			return this._arrRadioButtons[ $index ];
		}
		/*
		Accessor Definitions
	 	*/
	 	/**
		 * Returns the index of the selected radio button.
	 	*/
		public function get selectedIndex():int
		{
			return this._numSelected;
		}
		public function get selectedData():Object
		{
			return this._arrData[ this._numSelected ];
		}
	}
}

