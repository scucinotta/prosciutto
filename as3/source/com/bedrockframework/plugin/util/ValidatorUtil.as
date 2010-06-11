package com.bedrockframework.plugin.util
{
	import com.bedrockframework.core.base.StaticWidget;
	
    public class ValidatorUtil extends StaticWidget
    {
    	public static const CCTYPE_VISA:String = "Visa";
		public static const CCTYPE_MASTERCARD:String = "Mastercard";
		public static const CCTYPE_DISCOVER:String = "Discover";
		public static const CCTYPE_AMERICANEXPRESS:String = "American Express";
		public static const CCTYPE_DINERS:String = "Diners";
		/*
		Validate E-mail
		*/
		
	
		
		public static function isEmpty( $string:String ):Boolean
		{
			if( StringUtil.trim($string) == "" ){
				return true;
			}
			return false;
		}
		
		// is integer
		public static function isInt( $int:String ):Boolean
		{
			var strReg:RegExp = /(^-?\d\d*$)/;
			
			if( strReg.test($int) == false ){
				return false;
			}
			return true;
		}
		
		// is Zip
		public static function isZip( $zip:String ):Boolean
		{
			if( !isInt($zip) || $zip.length != 5 ){
				return false;
			}
			return true;
		}
		
		// isCreditCard
		public static function isValidCreditCard( $ccnum:String, $type:String ):Boolean
		{
			var strReg:RegExp;
			
			switch ( $type )
			{
				// Visa: length 16, prefix 4, dashes optional.
				case CCTYPE_VISA:
					strReg = /^4\d{3}-?\d{4}-?\d{4}-?\d{4}$/;
					break;
				// Mastercard: length 16, prefix 51-55, dashes optional.
				case CCTYPE_MASTERCARD:
					strReg = /^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/;
					break;
				// Discover: length 16, prefix 6011, dashes optional.
				case CCTYPE_DISCOVER:
					strReg = /^6011-?\d{4}-?\d{4}-?\d{4}$/;
					break;
				// American Express: length 15, prefix 34 or 37.
				case CCTYPE_AMERICANEXPRESS:
					strReg = /^3[4,7]\d{13}$/;
					break;
				// Diners: length 14, prefix 30, 36, or 38.
				case CCTYPE_DINERS:
					strReg = /^3[0,6,8]\d{12}$/;
					break;
			}
			
			// type or number not valid
			if( strReg == null || !strReg.test($ccnum) ){ return false; }
			// Remove all dashes for the checksum checks to eliminate negative numbers
			$ccnum = $ccnum.split("-").join("");
			// Checksum ("Mod 10")
			// Add even digits in even length strings or odd digits in odd length strings.
			var checksum:int = 0;
			for( var i = (2-($ccnum.length % 2)); i <= $ccnum.length; i+=2 ){
				checksum += parseInt( $ccnum.charAt(i-1) );
			}
			// Analyze odd digits in even length strings or even digits in odd length strings.
			for (i=($ccnum.length % 2) + 1; i<$ccnum.length; i+=2) {
				var digit:int = parseInt($ccnum.charAt(i-1)) * 2;
				if (digit < 10) { checksum += digit; } else { checksum += (digit-9); }
			}
			if ((checksum % 10) == 0) return true; else return false;
		}
		
		//
		public static function isValidCVV2( $cvv2:String, $type:String ):Boolean
		{
			if( !isInt($cvv2) ){ return false; }
			
			if( $type == CCTYPE_VISA || $type == CCTYPE_MASTERCARD || $type == CCTYPE_DISCOVER || $type == CCTYPE_DINERS ){
				if( $cvv2.length != 3 ){ return false; }
			}
			else if( $type == CCTYPE_AMERICANEXPRESS ){
				if( $cvv2.length != 4 ){ return false; }
			}
			return false;
		}
		// is email
		public static function isEmailExpression( $email:String ):Boolean
		{
			var strReg:RegExp = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
			
			if( strReg.test($email) == false ){
				return false;
			}
			return true;
		}
		
		public static function isEmail($email:String):Boolean
		{
			if (typeof($email) == "string") {
				if ($email.length < 6 || $email.indexOf(".") <= 0 || $email.indexOf(",") >= 0 || $email.indexOf(";") >= 0 || $email.indexOf(":") >= 0 || $email.indexOf("/") >= 0 || $email.indexOf(" ") >= 0 || $email.indexOf("@") <= 0 || $email.indexOf("@") != $email.lastIndexOf("@") || $email.lastIndexOf(".") < $email.indexOf("@") || $email.lastIndexOf(".") + 3 > $email.length) {
					return false;
				} else {
					return true;
				}
			} else {
				return false;
			}
		}
		/*
		Validate Number
		*/
		public static function isNumber($number:Number):Boolean
		{
			if (!isInt($number)) {
				return false;
			} else {
				return true;
			}
		}
		/*
		Validate String
		*/
		public static function isString($string:String):Boolean
		{
			if (typeof $string != "string") {
				return false;
			} else {
				return true;
			}
		}
		/*
		Validate if a field is blank
		*/
		public static function isBlank($var:*):Boolean
		{
			var strCheck:String = String($var);
			if (strCheck.length >= 1) {
				return false;
			} else {
				return true;
			}
		}
		/*
		Validate Number Range
		*/
		public static function isInRange($number:Number, $min:Number, $max:Number):Boolean
		{
			if ($number >= $min && $number <= $max) {
				return true;
			} else {
				return false;
			}
		}
		/*
		Validate String
		*/
		public static function isLength($var:*, $length:Number):Boolean
		{
			var strCheck:String = String($var);
			if (strCheck.length == $length) {
				return true;
			} else {
				return false;
	
			}
		}
	}

}