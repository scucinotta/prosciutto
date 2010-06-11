package com.bedrockframework.plugin.util
{
	import com.bedrockframework.core.base.StaticWidget;
	import com.bedrockframework.plugin.storage.HashMap;
	
	import flash.utils.*;
	import flash.xml.*;

	public class XMLUtil extends StaticWidget
	{
		public static function getArray($node:*):Array
		{
			var arrReturn:Array = new Array();
			var xmlTemp:XMLList = new XMLList($node);			
			
			var numLength:Number = xmlTemp.children().length();
			if (xmlTemp.hasComplexContent()) {
				for (var i:int = 0; i < numLength; i ++) {
					arrReturn.push(XMLUtil.convertValue(xmlTemp.child(i)));
				}
			}
			return arrReturn;
		}
		public static function convertToObject($node:*, $buildArrays:Boolean = false):Object
		{
			var objConversion:Object = new Object;
			var xmlTemp:XMLList = new XMLList($node);
			var numLength:Number = xmlTemp.children().length();
			var strName:String;
			var xmlValue:XMLList;
			var arrNodes:Array;
			for (var i:int = 0; i  < numLength; i++) {
				xmlValue = xmlTemp.child(i);
				strName = xmlTemp.child(i).name();
				if (objConversion[strName] == null) {
					if ( xmlValue.hasComplexContent() ) {
						if ( !$buildArrays ) {
							objConversion[strName] = XMLUtil.convertToObject(xmlValue, $buildArrays);
						} else {
							objConversion[strName] = XMLUtil.convertToArray(xmlValue, $buildArrays);
						}
					} else {
						objConversion[strName] = XMLUtil.convertValue(xmlValue);
					}					
				} else {
					if (objConversion[strName] is Array) {
						objConversion[strName].push(XMLUtil.convertToObject(xmlValue, $buildArrays));
					} else {
						arrNodes = new Array(objConversion[strName]);
						objConversion[strName] = arrNodes
						objConversion[strName].push(XMLUtil.convertToObject(xmlValue, $buildArrays));
					}
				}
			}
			return objConversion;
		}
		public static function convertToArray($node:*, $buildArrays:Boolean = false):Array
		{
			var arrReturn:Array = new Array();
			var xmlTemp:XMLList = new XMLList($node);
			var numLength:Number = xmlTemp.children().length();
			for (var i:int = 0; i < numLength; i ++) {
				if (xmlTemp.child(i).hasComplexContent()) {
					arrReturn.push(XMLUtil.convertToObject(xmlTemp.child(i), $buildArrays));
				} else {
					arrReturn.push(XMLUtil.convertValue(xmlTemp.child(i)));
				}
			}
			return arrReturn;
		}
		public static function convertToHashMap($node:*, $buildArrays:Boolean = false):HashMap
		{
			var objResultMap:HashMap = new HashMap;
			var objConverted:Object = XMLUtil.convertToObject($node, $buildArrays);
			for (var c:String in objConverted) {
				objResultMap.saveValue(c, objConverted[c]);
			}
			return objResultMap;
		}
		
		public static function convertValue($node:*):*
		{
			return VariableUtil.sanitize($node.toString());
		}
		
		public static function getAttributeObject($node:*):Object
		{
			var objResult:Object = new Object();
			
			var xmlTemp:XMLList = new XMLList($node);
			var xmlAttributes:XMLList = xmlTemp.attributes();
			
			var numLength:int = xmlAttributes.length();		
			for (var i:int = 0; i < numLength; i ++) {
				objResult[xmlAttributes[i].name().toString()] = XMLUtil.convertValue(xmlAttributes[i]);
			}	
				
			return objResult;
		}
		
		
		public static function filterByAttribute($node:*, $attribute:String, $value:String):XML
		{
			var xmlData:XML = new XML($node);
			var xmlList:XMLList = xmlData.children().(attribute($attribute) == $value);
			return new XML(xmlList);
		}
		public static function filterByNode($node:*, $name:String, $value:String):XML
		{
			var xmlData:XML = new XML($node);
			var xmlList:XMLList = xmlData.children().(child($name) == $value);
			return new XML("<root>" + xmlList.toString() + "</root>");
		}
		
		
	}
}