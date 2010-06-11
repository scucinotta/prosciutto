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
package com.bedrockframework.core.dispatcher
{
	import flash.events.Event;
	/**
	 * The IDispatcher interface defines methods for adding or removing event listeners, checks whether specific types of event listeners are registered, and dispatches events.
	*/
	public interface IDispatcher
	{
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher object upon which the dispatchEvent() method is called.
		*/
		function dispatchEvent($event:Event):Boolean;
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		 * 
		 * If you no longer need an event listener, remove it by calling removeEventListener(), or memory problems could result. Objects with registered event listeners are not automatically removed from memory because the garbage collector does not remove objects that still have references.
		*/
		function addEventListener($type:String, $listener:Function, $capture:Boolean = false, $priority:int = 0, $weak:Boolean = true):void;
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
		*/
		function removeEventListener($type:String, $listener:Function, $capture:Boolean = false):void;
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event. This allows you to determine where an EventDispatcher object has altered handling of an event type in the event flow hierarchy. To determine whether a specific event type actually triggers an event listener, use willTrigger().
		 * 
		 * This method only examines the object to which it belongs.
		*/
		function hasEventListener($type:String):void;
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type. This method returns true if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 * 
		 * This method examines the entire event flow based on the type parameter.
		*/
		function willTrigger($type:String):void;
	}
}