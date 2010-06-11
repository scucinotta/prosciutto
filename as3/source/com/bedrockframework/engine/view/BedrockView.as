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
package com.bedrockframework.engine.view
{
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.manager.PageManager;
	import com.bedrockframework.plugin.view.MovieClipView;
	
	import com.bedrockframework.engine.bedrock;

	public class BedrockView extends MovieClipView
	{
		/*
		Variable Declarations
		*/
		
		/*
		Constructor
		*/
		public function BedrockView()
		{
			super();
		}
		/*
		Property Definitions
		*/
		/**
		 * This will return the config details for the currently queued page.
		 * This information can also be accessed from the PageManager class.
		*/
		final protected  function get queue():Object
		{
			return BedrockEngine.bedrock::pageManager.queue;
		}
		/**
		 * This will return the config details for the currently shown page.
		 * This information can also be accessed from the PageManager class.
		*/
		final protected  function get current():Object
		{
			return BedrockEngine.bedrock::pageManager.current;
		}
		/**
		 * This will return the config details for the previously shown page.
		 * This information can also be accessed from the PageManager class.
		*/
		final protected  function get previous():Object
		{
			return BedrockEngine.bedrock::pageManager.previous;
		}
		
	}
	
}