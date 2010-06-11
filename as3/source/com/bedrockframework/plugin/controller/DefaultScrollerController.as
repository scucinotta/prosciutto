package com.bedrockframework.plugin.controller
{
	import com.bedrockframework.core.base.BasicWidget;
	import com.bedrockframework.plugin.data.ScrollerData;
	import com.bedrockframework.plugin.event.ScrollerEvent;
	import com.bedrockframework.plugin.gadget.Scroller;
	
	public class DefaultScrollerController extends BasicWidget implements IScrollerController
	{
		public var data:ScrollerData;
		public var scroller:Scroller;
		
		public function DefaultScrollerController()
		{
			super();
		}
		
		public function initialize( $scroller:Scroller, $data:ScrollerData ):void
		{
			this.scroller = $scroller;
			this.data = $data;
			
			this.refresh();
			this.reset();
		}
		
		public function refresh():void
		{
			if ( ( this.data.contentSize < this.data.maskSize ) && this.data.autoHide ) {
				this.moveContent( 0 );
				this.scroller.hideInterface();
			} else {
				this.scroller.showInterface();
				
				this.calculateMaxValues();

				if (this.data.resize) {
					this.calculateResizeValues();
				} else {
					this.calculateFixedValues();
				}
				
				this.moveScrubber( this.data.scrubberPosition );
				this.moveContent( this.data.scrubberPosition );
			}
			this.scroller.dispatchEvent( new ScrollerEvent( ScrollerEvent.UPDATE, this, { content:this.data.content } ) );
		}
		/*
		Reset the positioning of the scroll bar
		*/
		public function reset():void
		{
			this.calculateAlignmentValues();
		}
		/*
		Calculate 
		*/
		private function calculateMaxValues():void
		{
			this.data.maxContentPosition=Math.round( this.data.contentSize - this.data.maskSize );
		}
		/*
		Calculate fixed size scrubber values.
		*/
		private function calculateFixedValues():void
		{
			this.data.maxDragPosition = Math.round( this.data.scrubberBackgroundSize - this.data.scrubberSize );
			this.data.ratio = this.data.maxContentPosition / this.data.maxDragPosition;
		}
		/*
		Calculate resizable scrubber values.
		*/
		private function calculateResizeValues():void
		{
			var numTCRatio:Number = ( this.data.contentSize / this.data.scrubberBackgroundSize );

			var numDragSize:int = Math.floor( this.data.scrubberBackgroundSize / numTCRatio);
			if ( numDragSize > this.data.scrubberBackgroundSize ) numDragSize = this.data.scrubberBackgroundSize;
			
			this.data.scrubberSize = numDragSize;
			this.data.maxDragPosition=Math.round( this.data.scrubberBackgroundSize - this.data.scrubberSize );
			this.data.ratio=this.data.maxContentPosition / this.data.maxDragPosition;
		}
		/*
		Calculate scroll alignment values.
		*/
		private function calculateAlignmentValues():void
		{
			switch ( this.data.alignment ) {
				case ScrollerData.TOP :
					this.data.scrubberPosition = 0;
					break;
				case ScrollerData.BOTTOM :
					this.data.scrubberPosition = this.data.maxDragPosition;
					break;
				case ScrollerData.CENTER :
					var numLocation:Number = ( this.data.scrubberBackgroundSize /2 ) - ( this.data.scrubberSize /2 );
					this.data.scrubberPosition = numLocation;
					break;
			}
			this.moveContent( this.data.scrubberPosition );
		}
		/*
		Move the content into position.
		*/
		public function moveContent( $position:Number ):void
		{
			var numPosition:Number = ( -Math.round($position * this.data.ratio) + this.data.originalPosition );
			if ( isNaN( numPosition ) ) numPosition = this.data.originalPosition;
			this.data.contentPosition = numPosition;
			this.scroller.dispatchEvent(new ScrollerEvent(ScrollerEvent.CHANGE, this));
		}
		/*
		Move the drag button into position.
		*/
		public function moveScrubber( $position:Number ):void
		{
			var numPosition:Number;
			if ($position > 0 && $position < this.data.maxDragPosition) {
				numPosition = $position;
			} else if ($position < 0) {
				numPosition = 0;
			} else if ($position > this.data.maxDragPosition) {
				numPosition = this.data.maxDragPosition;
			} else {
				numPosition = this.data.scrubberPosition;
			}
			if ( isNaN( numPosition )  ) numPosition = this.data.scrubberPosition;
			this.data.scrubberPosition = numPosition;
			
			this.scroller.dispatchEvent( new ScrollerEvent(ScrollerEvent.CHANGE, this ) ); 
		}
		/*
		Move scrubber and content with an increment. Increment can be either positive or nagative.
		*/
		public function moveWithIncrement( $increment:Number = 0 ):void
		{
			var numMovement:int = ($increment != 0) ? $increment : this.data.increment;
			this.moveScrubber( this.data.scrubberPosition - numMovement );
			this.moveContent( this.data.scrubberPosition );
		}
	}
}