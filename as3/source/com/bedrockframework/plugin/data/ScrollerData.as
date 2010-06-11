package com.bedrockframework.plugin.data
{
	import com.bedrockframework.core.base.BasicWidget;
	import com.bedrockframework.plugin.controller.DefaultScrollerController;
	import com.bedrockframework.plugin.controller.IScrollerController;
	
	import flash.display.Sprite;

	public class ScrollerData extends BasicWidget
	{
		public static  var HORIZONTAL:String = "horizontal";
		public static  var VERTICAL:String = "vertical";
		public static  var CENTER:String = "center";
		public static  var TOP:String = "top";
		public static  var BOTTOM:String = "bottom";
		public static  var LEFT:String = "top";
		public static  var RIGHT:String = "bottom";
		
		public var content:Sprite;
		public var mask:Sprite;
		public var scrubber:Sprite;
		public var scrubberContainer:Sprite;
		public var scrubberBackground:Sprite;
		public var incrementButton:Sprite;
		public var decrementButton:Sprite;

		public var resize:Boolean;
		public var autoHide:Boolean;
		public var autoMask:Boolean;
		public var enableJumpActions:Boolean;
		
		public var increment:Number;
		public var originalPosition:Number;
		public var maxContentPosition:Number;
		public var maxDragPosition:Number;
		public var maxSize:Number;
		public var ratio:Number;
		
		public var controller:IScrollerController;
		
		public var alignment:String;
		public var sizeOrientation:String;
		public var directionOrientation:String;
		private var _strDirection:String;
		

		public function ScrollerData():void
		{
			this.enableJumpActions = true;
			this.resize = true;
			this.autoHide = true;
			this.autoMask = true;
			this.direction = ScrollerData.VERTICAL;
			this.alignment = ScrollerData.TOP;
			this.increment = 1;
			
			this.controller = new DefaultScrollerController;
		}
		
		public function set direction( $direction:String ):void
		{
			this._strDirection = $direction;
			switch ( this._strDirection )
			{
				case ScrollerData.VERTICAL :
					this.sizeOrientation="height";
					this.directionOrientation="y";
					break;
				case ScrollerData.HORIZONTAL :
					this.sizeOrientation="width";
					this.directionOrientation="x";
					break;
				default :
					this.error("Invalid direction value!");
					break;
			}
		}
		public function get direction():String
		{
			return this._strDirection;
		}
		/*
		Content
		*/
		public function set contentPosition( $value:Number ):void
		{
			this.content[ this.directionOrientation ] = $value;
		}
		public function get contentPosition():Number
		{
			return this.content[ this.directionOrientation ];
		}
		public function set contentSize( $value:Number ):void
		{
			this.content[ this.sizeOrientation ] = $value;
		}
		public function get contentSize():Number
		{
			return this.content[ this.sizeOrientation ];
		}
		/*
		Mask
		*/
		public function set maskPosition( $value:Number ):void
		{
			this.mask[ this.directionOrientation ] = $value;
		}
		public function get maskPosition():Number
		{
			return this.mask[ this.directionOrientation ];
		}
		public function set maskSize( $value:Number ):void
		{
			this.mask[ this.sizeOrientation ] = $value;
		}
		public function get maskSize():Number
		{
			return this.mask[ this.sizeOrientation ];
		}
		/*
		Drag
		*/
		public function set scrubberPosition( $value:Number ):void
		{
			this.scrubber[ this.directionOrientation ] = $value;
		}
		public function get scrubberPosition():Number
		{
			return this.scrubber[ this.directionOrientation ];
		}
		public function set scrubberSize( $value:Number ):void
		{
			this.scrubber[ this.sizeOrientation ] = $value;
		}
		public function get scrubberSize():Number
		{
			return this.scrubber[ this.sizeOrientation ];
		}
		/*
		Drag
		*/
		public function set scrubberBackgroundPosition( $value:Number ):void
		{
			this.scrubberBackground[ this.directionOrientation ] = $value;
		}
		public function get scrubberBackgroundPosition():Number
		{
			return this.scrubberBackground[ this.directionOrientation ];
		}
		public function set scrubberBackgroundSize( $value:Number ):void
		{
			this.scrubberBackground[ this.sizeOrientation ] = $value;
		}
		public function get scrubberBackgroundSize():Number
		{
			return this.scrubberBackground[ this.sizeOrientation ];
		}
		/*
		Drag
		*/
		public function set scrubberContainerPosition( $value:Number ):void
		{
			this.scrubberContainer[ this.directionOrientation ] = $value;
		}
		public function get scrubberContainerPosition():Number
		{
			return this.scrubberContainer[ this.directionOrientation ];
		}
		public function set scrubberContainerSize( $value:Number ):void
		{
			this.scrubberContainer[ this.sizeOrientation ] = $value;
		}
		public function get scrubberContainerSize():Number
		{
			return this.scrubberContainer[ this.sizeOrientation ];
		}
	}

}