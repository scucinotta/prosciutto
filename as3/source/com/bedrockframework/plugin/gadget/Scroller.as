/**

Scroller

*/
package com.bedrockframework.plugin.gadget
{
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.data.ScrollerData;
	import com.bedrockframework.plugin.event.ScrollerEvent;
	import com.bedrockframework.plugin.event.TriggerEvent;
	import com.bedrockframework.plugin.timer.IntervalTrigger;
	import com.bedrockframework.plugin.util.ButtonUtil;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Scroller extends DispatcherWidget
	{
		/*
		Variable Decarations
		*/
		public var data:ScrollerData;
		private var _objScrollerTrigger:IntervalTrigger;
		private var _objIncrementTrigger:IntervalTrigger;
		private var _numIncrement:Number;
		/*
		Constructor
		*/
		public function Scroller()
		{
			this.createTrigger();
		}
		private function createTrigger():void
		{
			this._objScrollerTrigger=new IntervalTrigger;
			this._objScrollerTrigger.silenceLogging=true;
		}
		/*
		Initialize the scroller
		*/
		public function initialize($data:ScrollerData):void
		{
			this.data = $data;
			
			this.data.content.addEventListener( MouseEvent.MOUSE_WHEEL, this.onMouseWheel );
			this.data.content.graphics.drawRect( 0, 0, 1, 1 );
			this.data.content.graphics.endFill();
			this.data.originalPosition= this.data.contentPosition;
			if ( this.data.autoMask ) this.data.content.mask = this.data.mask;
			
			this.data.controller.initialize( this, this.data );
			
			this.applyDragActions();
			this.applyButtonActions();
		}
		/*
		Start manual movement
		*/
		public function startIncrementalMovement( $increment:Number ):void
		{
			this._numIncrement = $increment;
			
			this._objScrollerTrigger.addEventListener(TriggerEvent.TRIGGER, this.onIncrementTrigger);
			this._objScrollerTrigger.start( 0.01 );
		}
		/*
		Stop manual movement
		*/
		public function stopIncrementalMovement():void
		{
			this._objScrollerTrigger.removeEventListener( TriggerEvent.TRIGGER, this.onIncrementTrigger );
			this._objScrollerTrigger.stop();
		}
		public function moveWithIncrement( $increment:Number = 0 ):void
		{
			this.data.controller.moveWithIncrement( $increment );
		}
		/*
		Scrubber Movement
		*/
		private function startScrubberMovement():void
		{
			this.data.content.mouseEnabled = false;
			this.data.scrubber.stage.addEventListener( MouseEvent.MOUSE_UP, this.onStopDragMovement );
			
			this._objScrollerTrigger.addEventListener(TriggerEvent.TRIGGER,this.onScrollerTrigger);
			this._objScrollerTrigger.start(0.001);
			
			var objRectangle:Rectangle;
			switch (this.data.direction) {
				case ScrollerData.HORIZONTAL :
					objRectangle=new Rectangle(0,0,this.data.maxDragPosition,0);
					break;
				case ScrollerData.VERTICAL :
					objRectangle=new Rectangle(0,0,0,this.data.maxDragPosition);
					break;
			}
			this.data.scrubber.startDrag( false, objRectangle );
			this.dispatchEvent( new ScrollerEvent( ScrollerEvent.START_DRAG, this ) );
		}
		private function stopScrubberMovement():void
		{
			this._objScrollerTrigger.removeEventListener( TriggerEvent.TRIGGER,this.onScrollerTrigger );
			this._objScrollerTrigger.stop();
			
			this.data.content.mouseEnabled = true;
			this.data.scrubber.stage.removeEventListener( MouseEvent.MOUSE_UP, this.onStopDragMovement );
			this.data.scrubber.stopDrag();
			
			this.dispatchEvent( new ScrollerEvent(ScrollerEvent.STOP_DRAG, this ) );
		}
		/*
		Update the positioning of the scroll bar
		*/
		public function refresh():void
		{
			this.data.controller.refresh();
		}
		/*
		Update the positioning of the scroll bar
		*/
		public function reset():void
		{
			this.data.controller.reset();
		}
		/* 
		Check to see if the mouse is making contact with the mask clip.
		*/
		private function get mouseInFocus():Boolean
		{
			return this.data.mask.hitTestPoint( this.data.scrubberContainer.stage.mouseX, this.data.scrubberContainer.stage.mouseY );
		}
		/*
		Apply button events the the drag button
		*/
		private function applyDragActions():void
		{
			ButtonUtil.addListeners( this.data.scrubber, { down:this.onStartDragMovement, up:this.onStopDragMovement } );
			if ( this.data.enableJumpActions ) {
				ButtonUtil.addListeners( this.data.scrubberBackground,{ up:this.onJump }, false );
			}
		}
		private function applyButtonActions():void
		{
			if ( this.data.incrementButton != null && this.data.decrementButton != null ) {
				ButtonUtil.addListeners( this.data.incrementButton, { down: this.onIncrementButtonDown, up:this.onIncremenalButtonUp } );
				ButtonUtil.addListeners( this.data.decrementButton, { down: this.onDecrementButtonDown, up:this.onIncremenalButtonUp } );
			}
		}
		/*
		Show/Hide Scroller Functions
		*/
		public function showInterface():void
		{
			this.data.scrubberContainer.visible = true;
			if ( this.data.incrementButton != null && this.data.decrementButton != null ) {
				this.data.incrementButton.visible = true;
				this.data.decrementButton.visible = true;
			}
			this.dispatchEvent(new ScrollerEvent(ScrollerEvent.SHOW_SCROLLER, this));
		}
		public function hideInterface():void
		{
			this.data.scrubberContainer.visible = false;
			if ( this.data.incrementButton != null && this.data.decrementButton != null ) {
				this.data.incrementButton.visible = false;
				this.data.decrementButton.visible = false;
			}
			this.dispatchEvent(new ScrollerEvent(ScrollerEvent.HIDE_SCROLLER, this));
		}
		/*
		Event Handlers
		*/
		private function onScrollerTrigger($event:TriggerEvent):void
		{
			this.data.controller.moveContent( this.data.scrubberPosition );
		}
		private function onIncrementTrigger($event:TriggerEvent):void
		{
			this.data.controller.moveWithIncrement( this._numIncrement );
		}
		private function onMouseWheel($delta:Number):void
		{
			if ( this.mouseInFocus ) {
				this.data.controller.moveWithIncrement( $delta );
			}
		}
		private function onJump($event:MouseEvent):void
		{
			this.data.controller.moveScrubber( $event.localY );
			this.data.controller.moveContent( this.data.scrubberPosition );
		}
		/*
		Start the movement interval
		*/
		private function onStartDragMovement($event:MouseEvent):void
		{
			this.startScrubberMovement();
		}
		/*
		Stop the movement interval
		*/
		private function onStopDragMovement($event:MouseEvent):void
		{
			this.stopScrubberMovement();
		}
		/*
		Increment/ Decrement Handlers
		*/
		private function onIncrementButtonDown( $event:MouseEvent ):void
		{
			this.data.content.stage.addEventListener( MouseEvent.MOUSE_UP, this.onIncremenalButtonUp );
			this.startIncrementalMovement( this.data.increment );
		}
		private function onDecrementButtonDown( $event:MouseEvent ):void
		{
			this.data.content.stage.addEventListener( MouseEvent.MOUSE_UP, this.onIncremenalButtonUp );
			this.startIncrementalMovement( -this.data.increment );
		}
		private function onIncremenalButtonUp( $event:MouseEvent ):void
		{
			this.data.content.stage.removeEventListener( MouseEvent.MOUSE_UP, this.onIncremenalButtonUp );
			this.stopIncrementalMovement();
		}
	}
}