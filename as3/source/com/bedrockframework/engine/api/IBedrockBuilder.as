package com.bedrockframework.engine.api
{
	public interface IBedrockBuilder
	{
		/**
		 * This function is called after params and config have loaded. Use it to make any neccesary modifications to the standard behavior of the framework.
		 * Make sure the next ( this.next() ) function is called in the last line of the function otherwise the following function in the sequence will not be called.
		 */
		function loadModifications():void;
		/**
		 * Use this function to load any Models you'll need throughout your project.
		 * Make sure the next ( this.next() ) function is called in the last line of the function otherwise the following function in the sequence will not be called.
		 */
		function loadModels():void;
		/**
		 * Use this function to add any event command relationships you'll need throughout your project.
		 * Use the addCommand function to add additional commands to the BedrockController. This is the only place you can add commands to the BedrockController throughout the framework.
		 * Optionally you also have the option of creating your own FrontControllers by extending the FrontController located in the core package.
		 * Make sure the <code>next()</code> function is called in the last line of the function otherwise the following function in the sequence will not be called.
		 */
		function loadCommands():void;
		function loadViews():void;
		/**
		 * Use this function to add new services to the TrackingManager. Use the addTracking function to add additional tracking services.
		 * Make sure the <code>next()</code> function is called in the last line of the function otherwise the following function in the sequence will not be called.
		 */
		function loadTracking():void;
		/**
		 * Use this function to apply any additional customization you may need for your project. For example, stage setting up alignment or a class you'll need throughout your project but doesnt fall into any specific category.
		 * Make sure the <code>next()</code> function is called in the last line of the function otherwise the following function in the sequence will not be called.
		 */
		function loadCustomization():void;
	}
}