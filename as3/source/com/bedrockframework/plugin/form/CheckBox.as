package com.bedrockframework.plugin.form
{
	import com.bedrockframework.core.base.MovieClipWidget;
	import com.bedrockframework.plugin.event.CheckBoxEvent;
	import com.bedrockframework.plugin.util.ButtonUtil;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class CheckBox extends MovieClipWidget
	{
		/*
		Variable Declarations
		*/		
		private var _bolSelected:Boolean;
		private var _objData:Object;
		public var label:TextField;		
		/*
		Constructor
		*/
		public function CheckBox()
		{
			this.stop();
			this._bolSelected = false;
			this.setup();
		}
		/*
		Setup mouse events
	 	*/
		private function setup():void
		{
			this.createMouseListeners();
			if ( this.label != null ) this.label.autoSize = TextFieldAutoSize.LEFT;
		}
		/*
		Create Mouse Listeners
		*/
		private function createMouseListeners():void
		{
			ButtonUtil.addListeners(this,{down:this.onClicked});
		}
		/**
		* Sets the check box status to selected and changes it's appearance
	 	*/
		public function select():void
		{
			this._bolSelected = true;
			this.gotoAndStop(2);
			this.dispatchEvent(new CheckBoxEvent(CheckBoxEvent.CHECK, this, this._objData));
		}
		/*
		Sets the check box status to deselected and changes it's appearance
	 	*/
		public function deselect():void
		{
			this._bolSelected = false;
			this.gotoAndStop(1);
			this.dispatchEvent(new CheckBoxEvent(CheckBoxEvent.UNCHECK, this, this._objData));
		}
		/*
		Event Handlers
	 	*/
		private function onClicked($event:Event):void
		{
			if (!this._bolSelected) {
				this.select();
			} else {
				this.deselect();
			}
		}
		/*
		Property Definitions
	 	*/
	 	public function set selected($status:Boolean):void
	 	{
	 		($status) ? this.select() : this.deselect();
	 	}
		public function get selected():Boolean
		{
			return this._bolSelected;
		}
		
		public function set data($data:Object):void
	 	{
	 		this._objData = $data;
	 		if ( this.label != null ) this.label.text = $data.label;
	 	}
	 	public function get data():Object
	 	{
	 		return this._objData;
	 	}
	}
}
