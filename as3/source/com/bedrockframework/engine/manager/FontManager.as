package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.api.IFontManager;
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.loader.VisualLoader;
	import com.bedrockframework.plugin.util.VariableUtil;
	
	import flash.text.Font;
	
	public class FontManager extends StandardWidget implements IFontManager
	{
		/*
		Variable Declarations
		*/
		private var _objLoader:VisualLoader;
		/*
		Constructor
		*/
		public function FontManager()
		{
			this.createLoader();
		}
		
		public function load( $url:String ):void
		{
			this._objLoader.loadURL( $url );
		}
		
		private function createLoader():void
		{
			this._objLoader = new VisualLoader;
			this._objLoader.visible = false;
			this._objLoader.addEventListener(LoaderEvent.COMPLETE, this.onFontLoadComplete);
			this._objLoader.addEventListener(LoaderEvent.IO_ERROR, this.onFontLoadError);
			this._objLoader.addEventListener(LoaderEvent.SECURITY_ERROR, this.onFontLoadError);
		}
		
		private function parseFonts():void
		{
			var arrVariables:Array = VariableUtil.getVariables( this._objLoader.content );
			
			var numLength:int = arrVariables.length;
			for ( var i:int = 0; i < numLength; i++ ) {
				try {
					Font.registerFont( this._objLoader.content[ arrVariables[ i ] ] );
					this.debug("Font Loaded! - " + arrVariables[ i ] );
				} catch ( $error:Error ) {
				}
			}
			
			this.debug( Font.enumerateFonts( false ) );
		}
		/*
		Event Handlers
		*/
		private function onFontLoadComplete($event:LoaderEvent):void 
		{
			this.parseFonts();
			this.status("Fonts Loaded!");
		}
		private function onFontLoadError($event:LoaderEvent ):void
		{
			this.warning("Failed to load fonts!");
		}
		/*
		Accessor Definitions
		*/
		public function get loader():VisualLoader
		{
			return this._objLoader;
		}
	}
}