package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.IContextMenuManager;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.ArrayUtil;
	
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class ContextMenuManager extends StandardWidget implements IContextMenuManager
	{
		private var _objMenu:ContextMenu;
		private var _mapItems:HashMap;
		
		public function ContextMenuManager()
		{
		}
		public function initialize():void
		{
			this.status( "Initialize" );
			this._mapItems = new HashMap;
			this.createMenu();
			if ( BedrockEngine.config.getSettingValue( BedrockData.SHOW_PAGES_IN_CONTEXT_MENU ) ) {
				this.createPageItems();
			}
		}
		private function createMenu():void
		{
			this._objMenu = new ContextMenu();
			this._objMenu.hideBuiltInItems();
            this._objMenu.builtInItems.print = true;
		}
		private function createPageItems():void
		{
			var arrPages:Array = BedrockEngine.config.getPages();
			for ( var p:int = 0; p < arrPages.length; p ++ ) {
				this.createItem( arrPages[ p ].alias, arrPages[ p ].label, this.onPageSelected, ( p == 0 ) );
			}
		}
		
		public function createItem( $alias:String, $label:String, $handler:Function, $separatorBefore:Boolean = false, $enabled:Boolean = true, $visible:Boolean = true ):void
		{
			var objItem:ContextMenuItem = new ContextMenuItem( $label, $separatorBefore, $enabled, $visible );
			objItem.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, $handler );
			this._objMenu.customItems.push( objItem );
			this._mapItems.saveValue( $label, $alias );
		}
		public function removeItem( $alias:String ):void
		{
			ArrayUtil.remove( this._objMenu.customItems, ArrayUtil.findIndex( this._objMenu.customItems, this._mapItems.getValue( $alias ), "caption" ) );
		}
		/*
		Event Handlers
		*/
		private function onPageSelected( $event:ContextMenuEvent ):void
		{
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.DO_CHANGE, this, { alias:this._mapItems.getValue( $event.target.caption ) } ) );
		}
		/*
		Property Definitions
		*/
		public function get menu():ContextMenu
		{
			return this._objMenu;
		}
	}
}