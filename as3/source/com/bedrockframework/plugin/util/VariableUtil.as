package com.bedrockframework.plugin.util
{
	import com.bedrockframework.core.base.StaticWidget;
	
	import flash.utils.ByteArray;
	import flash.utils.describeType;

	public class VariableUtil extends StaticWidget
	{
		public static function mimic( $target:*, $source:* ):void
		{
			var arrVariables:Array = VariableUtil.getVariables( $source );
			var arrAccessors:Array = VariableUtil.getAccessors( $source );
			
			var strProperty:String;
			for (var v:int = 0; v < arrVariables.length; v++) {
				strProperty =  arrVariables[ v ];
				$target[ strProperty ] = $source[ strProperty ];
			}
			for (var a:int = 0; a < arrAccessors.length; a++) {
				strProperty =  arrAccessors[ a ];
				$target[ strProperty ] = $source[ strProperty ];
			}
		}
		public static function getProperties( $target:* ):Array
		{
			return VariableUtil.getVariables( $target ).concat( VariableUtil.getAccessors( $target ) );
		}
		public static function getAccessors( $target:* ):Array
		{
			var arrResult:Array = new Array;
			var xmlResult:XML = new XML( "<temp>" +  describeType( $target )..accessor + "</temp>" );
			var xmlFilteredResult:XML = new XML( "<temp>" +  xmlResult.children().(attribute("access") == "readwrite") + "</temp>" );
			
			var numLength:int = xmlFilteredResult.children().length();
			for (var i:int = 0 ; i < numLength; i++) {
				arrResult.push( xmlFilteredResult.child( i ).@name.toString() );
			}
			return arrResult;
		}
		public static function getVariables( $target:* ):Array
		{
			var arrResult:Array = new Array;
			var xmlResult:XML = new XML( "<temp>" +  describeType( $target )..variable + "</temp>" );
			
			var numLength:int = xmlResult.children().length();
			for (var i:int = 0 ; i < numLength; i++) {
				arrResult.push( xmlResult.child( i ).@name.toString() );
			}
			return arrResult;
		}
		public static function sanitize($value:String):*
		{
			var strValue:String = $value;
			
			if (strValue == "") return "";
			if (strValue == "null") return null;

			var numValue:Number = Number(strValue);

			if ( !isNaN(numValue) ) return numValue;
			
			if ( VariableUtil.sanitizeBoolean(strValue) != null ) return VariableUtil.sanitizeBoolean(strValue);
			
			return strValue;
		}
		
		public static function combineObjects( ...$objects:Array):Object
		{
			var objResult:Object = new Object();
			
			var objData:Object;
			var numLength:int = $objects.length;
			for (var i:int = 0 ; i < numLength; i++) {
				objData = $objects[ i ];
				for (var d:String in objData) {
					objResult[d] = objData[d];
				}
			}
			
			return objResult;
		}
		
		public static function duplicateObject($data:Object):Object
		{
			var objResult:Object = new Object();
			for (var d:String in $data) {
				objResult[d] = $data[d];
			}
			return objResult;
		}
		
		public static function sanitizeBoolean($boolean:*):*
		{
			var strBoolean:String =  $boolean.toLowerCase();
			if (strBoolean != "true" && strBoolean != "false") {
				return null;
			} else {
				return (strBoolean == "true") ? true:false;
			}
		}
		public static function serialize( $data:Object, $variableSeparator:String ="&", $valueSeparator:String =  "=" ):String
		{
			var strValues:String = new String();
			for ( var d:String in $data ) {
				strValues += d + $valueSeparator + $data[ d ] + $variableSeparator;
			}
			return strValues.slice( 0, strValues.length - 1 );
		}
		public static function deserialize($values:String, $variableSeparator:String ="&", $valueSeparator:String =  "="):Object
		{
			var objData:Object = new Object;
			if ( $values != null && $values.length > 0 ) {
				var strValues:String = $values;
				var arrValues:Array = strValues.split( $variableSeparator );
				var numLength:int = arrValues.length;
				for (var v:int = 0; v < numLength; v++) {
					var arrVariable:Array = arrValues[v].split($valueSeparator);
					objData[ arrVariable[0] ] = VariableUtil.sanitize( arrVariable[1] ); 
				}
				return objData;
			}
			return objData;
		}
		 /**
         * 
         * Creates a deep copy (clone) of a reference object to a new 
         * memory address
         *
         * @param   reference object in which to clone
         * @return  a clone of the original reference object
         * 
         */
        public static function clone($reference:*):*
        {
            var arrBytes:ByteArray = new ByteArray();
            arrBytes.writeObject($reference);
            arrBytes.position = 0;

            return arrBytes.readObject();
        }
		
	}
}