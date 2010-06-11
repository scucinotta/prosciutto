package com.bedrockframework.plugin.display
{
	import com.bedrockframework.core.base.SpriteWidget;
	import com.bedrockframework.plugin.event.BlockerEvent;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.ButtonUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	/*
	Class Declarations
	*/
	public class Blocker extends SpriteWidget
	{
		private static var __objReplacements:HashMap;
		/*
		Variable Declarations
		*/
		private var _bolActive:Boolean;
		/*
		Constructor
		*/
		Blocker.setupReplacements();
		
		public function Blocker($alpha:Number=0)
		{
			this.alpha=$alpha;
			this._bolActive=false;
		}
		private static function setupReplacements():void
		{
			var arrEvents:Array=new Array("MOUSE_DOWN","MOUSE_UP","MOUSE_OVER","MOUSE_OUT");
			__objReplacements=new HashMap;
			//
			var numLength:Number=arrEvents.length;
			for (var i:Number=0; i < numLength; i++) {
				__objReplacements.saveValue(MouseEvent[arrEvents[i]],BlockerEvent[arrEvents[i]]);
			}
		}
		public function show():void
		{
			if (! this.active) {
				this.status("Show");
				this._bolActive=true;
				this.stage.focus = this;
				this.stage.addEventListener(Event.RESIZE, this.onStageResize);
				this.draw();
				this.dispatchEvent(new BlockerEvent(BlockerEvent.SHOW,this));
			}
		}
		public function hide():void
		{
			this.status("Hide");
			this._bolActive=false;
			this.clear();
			this.stage.focus = null;
			this.stage.removeEventListener(Event.RESIZE, this.onStageResize);
			this.dispatchEvent(new BlockerEvent(BlockerEvent.HIDE,this));
		}
		public function clear():void
		{
			this.graphics.clear();
			ButtonUtil.removeListeners(this,{down:this.onMouseInteraction,up:this.onMouseInteraction,over:this.onMouseInteraction,out:this.onMouseInteraction},false);
		}
		/*
		Draw the blocker
		*/
		public function draw():void
		{
			if (this.stage) {
				this.graphics.clear();
				this.graphics.moveTo(0,0);
				this.graphics.beginFill(0xFF00FF);
				this.graphics.lineTo(this.stage.stageWidth,0);
				this.graphics.lineTo(this.stage.stageWidth,this.stage.stageHeight);
				this.graphics.lineTo(0,this.stage.stageHeight);
				this.graphics.endFill();
				//
				ButtonUtil.addListeners(this,{down:this.onMouseInteraction,up:this.onMouseInteraction,over:this.onMouseInteraction,out:this.onMouseInteraction},false);
				//
			} else {
				this.error("Blocker must be added to stage before it can be shown!");
			}
		}
		/*
		Mouse Handlers
		*/
		private function onMouseInteraction($event:MouseEvent):void
		{
			if ( $event.type == MouseEvent.MOUSE_DOWN ) {
				this.warning( "Blocker is active!" );
			}
			this.dispatchEvent(new BlockerEvent(Blocker.__objReplacements.getValue($event.type),this));
		}
		private function onStageResize($event:Event):void
		{
			this.draw();
		}
		/*
		Property Definitions
		*/
		
		public function get active():Boolean
		{
			return this._bolActive;
		}
	}
}