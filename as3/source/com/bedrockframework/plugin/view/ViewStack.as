package com.bedrockframework.plugin.view
{
	import com.bedrockframework.core.base.SpriteWidget;
	import com.bedrockframework.plugin.data.ViewStackData;
	import com.bedrockframework.plugin.event.TriggerEvent;
	import com.bedrockframework.plugin.event.ViewEvent;
	import com.bedrockframework.plugin.event.ViewStackEvent;
	import com.bedrockframework.plugin.storage.SuperArray;
	import com.bedrockframework.plugin.timer.TimeoutTrigger;
	import com.bedrockframework.plugin.util.ArrayUtil;
	
	import flash.display.Sprite;

	public class ViewStack extends SpriteWidget
	{
		/*
		Variable Declarations
		*/
		public static const INITIALIZE:String = "initialize";
		public static const INTRO:String = "intro";
		public static const OUTRO:String = "outro";
		
		public var data:ViewStackData;
		private var _arrViews:SuperArray;
		private var _objContainer:Sprite;
		private var _objQueueItem:Object;
		private var _objCurrentItem:Object;
		private var _objPreviousItem:Object;
		
		private var _strDirection:String;
		
		private var _objTrigger:TimeoutTrigger;
		
		private var _bolRunning:Boolean;
		/*
		Constructor
		*/
		public function ViewStack()
		{
			this._arrViews = new SuperArray;
		}
		public function initialize($data:ViewStackData):void
		{
			this.clear();
			
			this.data = $data;
			this._arrViews = new SuperArray( this.data.stack );
			if ( this.data.startingAlias != null ) {
				var numIndex:int = ArrayUtil.findIndex( this.data.stack, this.data.startingAlias, "alias" );
				if ( numIndex != -1 ) {
					this._objQueueItem = this._arrViews.setSelected( numIndex );
				} else {
					this.error( "Alias '" + this.data.startingAlias +  "' not found!" );
				}
			} else {
				this._objQueueItem = this._arrViews.setSelected( this.data.startingIndex );
			}
			this._arrViews.wrapIndex = this.data.wrap;
			this.setContainer(this.data.container);
			
			if ( this.data.autoStart ) this.queue();
			this.createTrigger(); 
		}
		public function clear():void
		{
			if ( this._objCurrentItem != null && this._objContainer != null ) {
				this.removeListeners(this._objCurrentItem.view);
				if ( this.data.addAsChildren ) {
					this._objContainer.removeChild(this._objCurrentItem.view);
				}
				this._objCurrentItem = null;
				this._objPreviousItem = null;
				this._objQueueItem = null;
			}
		}
		
		/*
		Creation Functions
		*/
		private function createTrigger():void
		{
			this._objTrigger = new TimeoutTrigger;
			this._objTrigger.addEventListener( TriggerEvent.TRIGGER, this.onTrigger );
			this._objTrigger.silenceLogging = true;
		}
		
		/*
		Timer Functions
		*/
		public function startTimer($time:Number = 0):void
		{
			if ( this.data.mode == ViewStackData.SELECT ) this.data.mode = ViewStackData.FORWARD;
			this.data.timerEnabled = true;
			this.advance();
		}
		public function stopTimer():void
		{
			this.data.timerEnabled = false;
			this._objTrigger.stop();
		}
		/*
		Set the container where the views will be showing up
		*/
		private function setContainer( $container:Sprite = null ):void
		{
			this._objContainer=$container || this;
		}
		/*
		Queue/ Dequeue
		*/
		private function queue():void
		{
			this._objCurrentItem = this._objQueueItem;
			this._objQueueItem = null;
			
			if (this.data.addAsChildren) {
				this._objContainer.addChild(this._objCurrentItem.view);
			}
			var objView:* = this._objCurrentItem.view;
			this.addListeners(this._objCurrentItem.view);
			if (this.data.autoInitialize ) {
				if ( objView != null && !objView.hasInitialized ) {
					this.call( ViewStack.INITIALIZE );
				} else {
					this.call( ViewStack.INTRO );
				}
			} else {
				this.call( ViewStack.INTRO );
			}
		}
		private function dequeue():void
		{
			this._objPreviousItem = this._objCurrentItem;
			this._objCurrentItem = null;
			
			this.removeListeners(this._objPreviousItem.view);
			if (this.data.addAsChildren) {
				this._objContainer.removeChild(this._objPreviousItem.view);
			}
			if ( this._objQueueItem != null ) this.queue();
		}
		/*
		Show View
		*/
		public function selectByIndex($index:uint):void
		{
			this.stopTimer();
			this._objQueueItem = this._arrViews.setSelected( $index );
			if ( this._objCurrentItem != null ) {
				this.call( ViewStack.OUTRO );
			} else {
				this.queue();
			}
			this.dispatchEvent( new ViewStackEvent( ViewStackEvent.CHANGE, this ) );
		}
		public function selectByAlias( $alias:String ):void
		{
			var numIndex:int = ArrayUtil.findIndex( this.data.stack, $alias, "alias" );
			if ( numIndex != -1 ) {
				this.selectByIndex( numIndex );
			} else {
				this.error( "Alias '" + $alias + "' not found!" );
			}
		}
		/*
		Get View
		*/
		public function getByIndex( $index:uint ):Object
		{
			return this._arrViews.getItemAt( $index );
		}
		public function getByAlias( $alias:String ):Object
		{
			return this._arrViews.findItem( $alias, "alias" );
		}
		/*
		External Next/ Previous
		*/
		public function selectNext():void
		{
			if ( this._arrViews.hasNext() || ( !this._arrViews.hasNext() && this.data.wrap ) ) {
				this._objQueueItem = this._arrViews.selectNext();
				this.data.mode = ViewStackData.FORWARD;
				if ( this._objCurrentItem != null ) {
					this.call( ViewStack.OUTRO );
				} else {
					this.queue();
				}
				this.dispatchEvent( new ViewStackEvent( ViewStackEvent.NEXT, this, this.getDetailObject() ) );
			} else if ( !this._arrViews.hasNext() && !this.data.wrap ) {
				this.status("Hit Ending");
				this.dispatchEvent( new ViewStackEvent( ViewStackEvent.ENDING, this, this.getDetailObject() ) );
			}
		}
		public function selectPrevious():void
		{
			if ( this._arrViews.hasPrevious() || ( !this._arrViews.hasPrevious() && this.data.wrap ) ){
				this._objQueueItem = this._arrViews.selectPrevious();
				this.data.mode = ViewStackData.REVERSE;
				if ( this._objCurrentItem != null ) {
					this.call( ViewStack.OUTRO );
				} else {
					this.queue();
				}
				this.dispatchEvent( new ViewStackEvent( ViewStackEvent.PREVIOUS, this, this.getDetailObject() ) );
			} else if ( !this._arrViews.hasPrevious() && !this.data.wrap ) {
				this.status( "Hit Beginning" );
				this.dispatchEvent( new ViewStackEvent( ViewStackEvent.BEGINNING, this, this.getDetailObject() ) );
			}
		}
		/*
		Call Functions
	 	*/
	 	private function call($type:String):void
		{
			var objView:IView = IView( this._objCurrentItem.view );
			switch ($type) {
				case ViewStack.INITIALIZE :
					objView.initialize( this._objCurrentItem.initialize );
					break;
				case ViewStack.INTRO :
					objView.intro( this._objCurrentItem.intro );
					break;
				case ViewStack.OUTRO :
					objView.outro( this._objCurrentItem.outro );
					break;
			}
		}
		/*
		Manager Event Listening
		*/
		private function addListeners($target:* = null):void
		{
			if ($target != null) {
				$target.addEventListener(ViewEvent.INITIALIZE_COMPLETE,this.onInitializeComplete);
				$target.addEventListener(ViewEvent.INTRO_COMPLETE,this.onIntroComplete);
				$target.addEventListener(ViewEvent.OUTRO_COMPLETE,this.onOutroComplete);
			}
		}
		private function removeListeners($target:* = null):void
		{
			if ($target != null) {
				$target.removeEventListener(ViewEvent.INITIALIZE_COMPLETE,this.onInitializeComplete);
				$target.removeEventListener(ViewEvent.INTRO_COMPLETE,this.onIntroComplete);
				$target.removeEventListener(ViewEvent.OUTRO_COMPLETE,this.onOutroComplete);
			}
		}
		
		public function toggleMode():void
		{
			this.data.mode = (  this.data.mode != ViewStackData.FORWARD ) ? ViewStackData.FORWARD : ViewStackData.REVERSE;
		}
		/*
		*/
		private function getDetailObject():Object
		{
			var objData:Object = this._arrViews.getSelected();
			objData.index = this._arrViews.selectedIndex;
			return objData;
		}
		/*
		Individual Preloader Handlers
		*/
		private function advance():void
		{
			switch( this.data.mode ) 
			{
				case ViewStackData.FORWARD :
					this.selectNext();
					break;
				case ViewStackData.REVERSE :
					this.selectPrevious();
					break;
			}
		}
		private  function onInitializeComplete($event:ViewEvent):void
		{
			this.call( ViewStack.INTRO );
			this.dispatchEvent( new ViewStackEvent( ViewStackEvent.INITIALIZE_COMPLETE, this, this.getDetailObject() ) );
		}
		private  function onIntroComplete($event:ViewEvent):void
		{
			if (this.data.timerEnabled) this.startTimer();	
			this.dispatchEvent( new ViewStackEvent( ViewStackEvent.INTRO_COMPLETE, this, this.getDetailObject() ) );
		}
		private function onOutroComplete($event:ViewEvent):void
		{
			this.dequeue();
			this.dispatchEvent( new ViewStackEvent( ViewStackEvent.OUTRO_COMPLETE, this, this.getDetailObject() ) );
		}
		private function onTrigger($event:TriggerEvent):void
		{
			this.advance();
		}
		/*
		Property Definitions
		*/
		public function get selectedIndex():uint
		{
			return this._arrViews.selectedIndex;
		}
		public function get selectedItem():*
		{
			return this._arrViews.selectedItem;
		}
		public function get running():Boolean
		{
			return this._objTrigger.running;
		}
	}

}
