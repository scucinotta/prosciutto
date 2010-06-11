package com.bedrockframework.engine.view
{
	import com.bedrockframework.core.base.SpriteWidget;
	import com.bedrockframework.plugin.view.ViewStack;
	
	import flash.display.DisplayObject;

	public class ContainerView extends SpriteWidget
	{
		/*
		Variable Declarations
		*/
		private var _objViewStack:ViewStack;
		private var _objChild:DisplayObject;
		/*
		Constructor
		*/
		public function ContainerView($silenceConstruction:Boolean=false)
		{
			
		}
		
		public function hold($child:DisplayObject):void
		{
			this.release();
			if (this.numChildren != 0) {
				throw new Error("Cannot add more than one child!");
			} else {
				this._objChild = $child;
				super.addChild(this._objChild);
			}
		}
		public function release():void
		{
			if (this._objChild != null) {
				super.removeChild( this._objChild );
			}
			this._objChild = null;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			throw new Error("Please use the hold method in place of addChild.");
			return null;
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			throw new Error("Please use the release method in place of removeChild.");
			return null;
		}
		/*
		Property Definitions
	 	*/
		public function get child():*
		{
			return this._objChild;
		}
	}
}