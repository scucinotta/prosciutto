package com.bedrockframework.plugin.view
{
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.event.ViewEvent;
	import com.bedrockframework.plugin.loader.VisualLoader;

	public class VisualLoaderView extends VisualLoader implements IView
	{
		/*
		Variable Delcarations
		*/
		private var _bolHasInitialized:Boolean;
		/*
		Constructor
		*/
		public function VisualLoaderView($url:String=null)
		{
			super($url);
			this._bolHasInitialized = false;
			
			this.addEventListener( LoaderEvent.INIT, this.onLoadInit );
		}
		/*
		Creation Functions
		*/
		public function initialize($data:Object=null):void
		{
			IView( this.content ).initialize( $data );
		}
		/**
		 * The initializeComplete() function will dispatch ViewEvent.INITIALIZE_COMPLETE notifying any listeners of this class that the initialization of the view is complete.
		 * This function should be called after the view has finished it's initialization.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function initializeComplete():void
		{
			this._bolHasInitialized = true;
			this.dispatchEvent( new ViewEvent( ViewEvent.INITIALIZE_COMPLETE, this ) );
		}
		
		
		public function intro($data:Object=null):void
		{
			IView( this.content ).intro( $data );
		}
		/**
		 * The introComplete() function will dispatch ViewEvent.INTRO_COMPLETE notifying any listeners of this class that the intro of the view is complete.
		 * This function should be called after the view has finished it's intro sequence.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function introComplete():void
		{
			this.dispatchEvent( new ViewEvent(ViewEvent.INTRO_COMPLETE, this ) );
		}
		
		public function outro($data:Object=null):void
		{
			IView( this.content ).outro( $data );
		}
		/**
		 * The introComplete() function will dispatch ViewEvent.OUTRO_COMPLETE notifying any listeners of this class that the outro of the view is complete.
		 * This function should be called after the view has finished it's outro sequence.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function outroComplete():void
		{
			this.dispatchEvent( new ViewEvent( ViewEvent.OUTRO_COMPLETE,this));
		}
		
		public function clear():void
		{
			IView( this.content ).clear();
		}
		/*
		Event Handlers
		*/
		private function onLoadInit( $event:LoaderEvent ):void
		{
			this.content.addEventListener( ViewEvent.INITIALIZE_COMPLETE, this.onInitializeComplete );
			this.content.addEventListener( ViewEvent.INTRO_COMPLETE, this.onIntroComplete );
			this.content.addEventListener( ViewEvent.OUTRO_COMPLETE, this.onOutroComplete );
		}
		private function onInitializeComplete( $event:ViewEvent ):void
		{
			this.initializeComplete();
		}
		private function onIntroComplete( $event:ViewEvent ):void
		{
			this.introComplete();
		}
		private function onOutroComplete( $event:ViewEvent ):void
		{
			this.outroComplete();
		}
		/*
		Property Definitions
		*/
		public function hasInitialized():Boolean
		{
			return this._bolHasInitialized;
		}
		
	}
}