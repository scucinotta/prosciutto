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
package com.bedrockframework.core.util
{
	import com.bedrockframework.core.base.StaticWidget;
	
	import flash.net.LocalConnection;
	import flash.utils.*;
	
	public class ClassUtil extends StaticWidget
	{
		public static function getDisplayClassName($instance:Object):String
		{
			return "[" + ClassUtil.getClassName($instance) +"]";
		}
		public static function getClassName($instance:Object):String
		{
			var strName:String = getQualifiedClassName($instance);
			strName=strName.slice(strName.lastIndexOf(":") + 1,strName.length);
			return strName;
		}
		public static function getClass($name:String):Class
		{
			var clsReference:Class;
			try {
				clsReference = getDefinitionByName($name) as Class;
			} catch ($error:Error) {
				throw new TypeError($name);
			}
			return clsReference;
		}
		public static function getDescription($object:*):Object
		{
			var objResult:Object = new Object();
			var xmlDescription:XML = describeType($object);
			
			return objResult;
		}
		public static function forceGarbageCollection():void
		{
			try {
				new LocalConnection().connect("poop");
				new LocalConnection().connect("poop");
			} catch ($error:Error) {}
		}
	}
}