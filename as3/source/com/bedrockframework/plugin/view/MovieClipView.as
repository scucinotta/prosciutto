/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
*/
package com.bedrockframework.plugin.view
{
	import com.bedrockframework.core.base.MovieClipWidget;
	import com.bedrockframework.plugin.event.ViewEvent;
	
	public class MovieClipView extends MovieClipWidget
	{
		/*
		Variable Declarations
		*/
		private var _bolHasInitialized:Boolean;
		/*
		Constructor
		*/
		/**
		 * The initializeComplete() function will dispatch ViewEvent.INITIALIZE_COMPLETE notifying any listeners of this class that the initialization of the view is complete.
		 * This function should be called after the view has finished it's initialization.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function initializeComplete():void
		{
			this._bolHasInitialized = true;
			this.dispatchEvent(new ViewEvent(ViewEvent.INITIALIZE_COMPLETE,this));
		}
		/**
		 * The introComplete() function will dispatch ViewEvent.INTRO_COMPLETE notifying any listeners of this class that the intro of the view is complete.
		 * This function should be called after the view has finished it's intro sequence.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function introComplete():void
		{
			this.dispatchEvent(new ViewEvent(ViewEvent.INTRO_COMPLETE,this));
		}
		/**
		 * The introComplete() function will dispatch ViewEvent.OUTRO_COMPLETE notifying any listeners of this class that the outro of the view is complete.
		 * This function should be called after the view has finished it's outro sequence.
		 * 
		 * This function is only available to the View class and it's descendants.
		*/
		final protected  function outroComplete():void
		{
			this.dispatchEvent(new ViewEvent(ViewEvent.OUTRO_COMPLETE,this));
		}
		/**
		 * Remove this instance from it's parent's display list.
		*/
		public function remove():void
		{
			this.parent.removeChild(this);
		}
		
		
		public function get hasInitialized():Boolean
		{
			return this._bolHasInitialized;
		}
	}

}