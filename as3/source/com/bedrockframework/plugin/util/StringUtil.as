package com.bedrockframework.plugin.util
{
	import com.bedrockframework.core.base.StaticWidget;

	public class StringUtil extends StaticWidget
	{

		/*
		Splits a string into an array according to a specified length.
		*/
		public static function segment($text:String, $linelength:Number):Array
		{
			var strFullText:String = $text;
			var numLineLength:Number = $linelength;
			var arrLines:Array = new Array();
			var arrText:Array = strFullText.split(" ");
			var numLine:Number = 0;
			var strTemp:String = arrText[0];
			var numLength:Number = strTemp.length + 1;
			arrLines[numLine] = arrText[0];
			for (var t:Number = 1; t < arrText.length; t++) {
				if ((numLength + arrText[t].length) > numLineLength) {
					arrLines.push(strTemp);
					numLine++;
					strTemp = arrText[t];
					numLength = strTemp.length + 1;
					arrLines[numLine] = arrText[t];
				} else {
					strTemp = strTemp + " " + arrText[t];
					numLength = strTemp.length + 1;
					arrLines[numLine] = arrLines[numLine] + " " + arrText[t];
				}
			}
			return arrLines;
		}
		/*
		Convert number to string
		*/
		public static function generateString($number:Number, $places:Number):String
		{
			var strNumber:String = $number.toString();
			var numLength:Number = $places - strNumber.length;
			//
			for (var i:int = 0; i < numLength; i++) {
				strNumber = "0" + strNumber;
			}
			return strNumber;
		}
		/*
		
		*/
		public static function elipse($string:String, $index:Number):String
		{
			if($string.length > $index){
				return $string.substr(0,$index) + "...";
			} else {
				return $string;
			}
		}
		/*
		
		*/
		public static function generatePossessiveNoun($noun:String):String
		{
			if ($noun.charAt($noun.length - 1).toLowerCase() != "s") {
				return $noun + "'s";
			} else {
				return $noun + "'";
			}
		}
		public static function generateUniqueKey($length:Number):String
		{
			var strKey:String = "";
			for (var i:int = 0; i < $length; i++) {
				strKey += String(MathUtil.random(10));
			}
			return strKey;
		}
		/**
		*Returns everything after the first occurrence of the provided character in the string.
		*
		*@param $string The string.
		*
		*@param $begin The character or sub-string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function afterFirst($string:String, $char:String):String
		{
			if ($string == null) {
				return '';
			}
			var idx:int = $string.indexOf($char);
			if (idx == -1) {
				return '';
			}
			idx += $char.length;
			return $string.substr(idx);
		}

		/**
		*Returns everything after the last occurence of the provided character in $string.
		*
		*@param $string The string.
		*
		*@param $char The character or sub-string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function afterLast($string:String, $char:String):String
		{
			if ($string == null) {
				return '';
			}
			var idx:int = $string.lastIndexOf($char);
			if (idx == -1) {
				return '';
			}
			idx += $char.length;
			return $string.substr(idx);
		}

		/**
		*Determines whether the specified string begins with the specified prefix.
		*
		*@param $string The string that the prefix will be checked against.
		*
		*@param $begin The prefix that will be tested against the string.
		*
		*@returns Boolean
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function beginsWith($string:String, $begin:String):Boolean
		{
			if ($string == null) {
				return false;
			}
			return $string.indexOf($begin) == 0;
		}

		/**
		*Returns everything before the first occurrence of the provided character in the string.
		*
		*@param $string The string.
		*
		*@param $begin The character or sub-string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function beforeFirst($string:String, $char:String):String
		{
			if ($string == null) {
				return '';
			}
			var idx:int = $string.indexOf($char);
			if (idx == -1) {
				return '';
			}
			return $string.substr(0,idx);
		}

		/**
		*Returns everything before the last occurrence of the provided character in the string.
		*
		*@param $string The string.
		*
		*@param $begin The character or sub-string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function beforeLast($string:String, $char:String):String
		{
			if ($string == null) {
				return '';
			}
			var idx:int = $string.lastIndexOf($char);
			if (idx == -1) {
				return '';
			}
			return $string.substr(0,idx);
		}

		/**
		*Returns everything after the first occurance of $start and before
		*the first occurrence of $end in $string.
		*
		*@param $string The string.
		*
		*@param $start The character or sub-string to use as the start index.
		*
		*@param $end The character or sub-string to use as the end index.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function between($string:String, $start:String, $end:String):String
		{
			var str:String = '';
			if ($string == null) {
				return str;
			}
			var startIdx:int = $string.indexOf($start);
			if (startIdx != -1) {
				startIdx += $start.length;// RM: should we support multiple chars? (or ++startIdx);
				var endIdx:int = $string.indexOf($end, startIdx);
				if (endIdx != -1) {
					str = $string.substr(startIdx, endIdx-startIdx);
				}
			}
			return str;
		}

		/**
		*Description, Utility method that intelligently breaks up your string,
		*allowing you to create blocks of readable text.
		*This method returns you the closest possible match to the $delim paramater,
		*while keeping the text length within the $len paramter.
		*If a match can't be found in your specified length an  '...' is added to that block,
		*and the blocking continues untill all the text is broken apart.
		*
		*@param $string The string to break up.
		*
		*@param $len Maximum length of each block of text.
		*
		*@param $delim delimter to end text blocks on, default = '.'
		*
		*@returns Array
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function block($string:String, $len:uint, $delim:String = "."):Array
		{
			var arr:Array = new Array();
			if ($string == null || !contains($string, $delim)) {
				return arr;
			}
			var chrIndex:uint = 0;
			var strLen:uint = $string.length;
			var replPatt:RegExp = new RegExp("[^"+escapePattern($delim)+"]+$");
			while (chrIndex <  strLen)
			{
				var subString:String = $string.substr(chrIndex, $len);
				if (!contains(subString, $delim)) {
					arr.push(truncate(subString, subString.length));
					chrIndex += subString.length;
				}
				subString = subString.replace(replPatt, '');
				arr.push(subString);
				chrIndex += subString.length;
			}
			return arr;
		}

		/**
		*Capitallizes the first word in a string or all words..
		*
		*@param $string The string.
		*
		*@param $all (optional) Boolean value indicating if we should
		*capitalize all words or only the first.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/

		public static function capitalize2($string:String, ...args):String
		{
			var str:String = trimLeft($string);
			if (args[0] === true) {
				return str.replace(/^.|\b./g,_upperCase);
			} else {
				return str.replace(/(^\w)/,_upperCase);
			}
		}
		public static function capitalize($text:String):String
		{
			var strText:String = $text;
			var strFirst:String = strText.charAt(0).toUpperCase();
			var strRest:String = (strText.substring(1, strText.length));
			return strFirst + strRest;
		}
		/**
		*Determines whether the specified string contains any instances of $char.
		*
		*@param $string The string.
		*
		*@param $char The character or sub-string we are looking for.
		*
		*@returns Boolean
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function contains($string:String, $char:String):Boolean
		{
			if ($string == null) {
				return false;
			}
			return $string.indexOf($char) != -1;
		}

		/**
		*Determines the number of times a charactor or sub-string appears within the string.
		*
		*@param $string The string.
		*
		*@param $char The character or sub-string to count.
		*
		*@param $caseSensitive (optional, default is true) A boolean flag to indicate if the
		*search is case sensitive.
		*
		*@returns uint
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function countOf($string:String, $char:String, $caseSensitive:Boolean = true):uint
		{
			if ($string == null) {
				return 0;
			}
			var char:String = escapePattern($char);
			var flags:String = (!$caseSensitive) ? 'ig' : 'g';
			return $string.match(new RegExp(char,flags)).length;
		}

		/**
		*Levenshtein distance (editDistance) is a measure of the similarity between two strings,
		*The distance is the number of deletions, insertions, or substitutions required to
		*transform $source into $target.
		*
		*@param $source The source string.
		*
		*@param $target The target string.
		*
		*@returns uint
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function editDistance($source:String, $target:String):uint
		{
			var i:uint;

			if ($source == null) {
				$source = '';
			}
			if ($target == null) {
				$target = '';
			}

			if ($source == $target) {
				return 0;
			}

			var d:Array = new Array();
			var cost:uint;
			var n:uint = $source.length;
			var m:uint = $target.length;
			var j:uint;

			if (n == 0) {
				return m;
			}
			if (m == 0) {
				return n;
			}

			for (i=0; i<=n; i++) {
				d[i] = new Array();
			}
			for (i=0; i<=n; i++) {
				d[i][0] = i;
			}
			for (j=0; j<=m; j++) {
				d[0][j] = j;
			}

			for (i=1; i<=n; i++) {

				var s_i:String = $source.charAt(i-1);
				for (j=1; j<=m; j++) {

					var t_j:String = $target.charAt(j-1);

					if (s_i == t_j) {
						cost = 0;
					} else {
						cost = 1;
					}

					d[i][j] = _minimum(d[i-1][j]+1, d[i][j-1]+1, d[i-1][j-1]+cost);
				}
			}
			return d[n][m];
		}

		/**
		*Determines whether the specified string ends with the specified suffix.
		*
		*@param $string The string that the suffic will be checked against.
		*
		*@param $end The suffix that will be tested against the string.
		*
		*@returns Boolean
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function endsWith($string:String, $end:String):Boolean
		{
			return $string.lastIndexOf($end) == $string.length - $end.length;
		}

		/**
		*Determines whether the specified string contains text.
		*
		*@param $string The string to check.
		*
		*@returns Boolean
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function hasText($string:String):Boolean
		{
			var str:String = removeExtraWhitespace($string);
			return ! ! str.length;
		}

		/**
		*Determines whether the specified string contains any characters.
		*
		*@param $string The string to check
		*
		*@returns Boolean
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function isEmpty($string:String):Boolean
		{
			if ($string == null) {
				return true;
			}
			return ! $string.length;
		}

		/**
		*Determines whether the specified string is numeric.
		*
		*@param $string The string.
		*
		*@returns Boolean
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function isNumeric($string:String):Boolean
		{
			if ($string == null) {
				return false;
			}
			var regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return regx.test($string);
		}

		/**
		* Pads $string with specified character to a specified length from the left.
		*
		*@param $string String to pad
		*
		*@param $padChar Character for pad.
		*
		*@param $length Length to pad to.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function padLeft($string:String, $padChar:String, $length:uint):String
		{
			var s:String = $string;
			while (s.length < $length)
			{
				s = $padChar + s;
			}
			return s;
		}

		/**
		* Pads $string with specified character to a specified length from the right.
		*
		*@param $string String to pad
		*
		*@param $padChar Character for pad.
		*
		*@param $length Length to pad to.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function padRight($string:String, $padChar:String, $length:uint):String
		{
			var s:String = $string;
			while (s.length < $length)
			{
				s += $padChar;
			}
			return s;
		}

		/**
		*Properly cases' the string in "sentence format".
		*
		*@param $string The string to check
		*
		*@returns String.
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function properCase($string:String):String
		{
			if ($string == null) {
				return '';
			}
			var str:String = $string.toLowerCase().replace(/\b([^.?;!]+)/, capitalize);
			return str.replace(/\b[i]\b/,"I");
		}

		/**
		*Escapes all of the characters in a string to create a friendly "quotable" sting
		*
		*@param $string The string that will be checked for instances of remove
		*string
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function quote($string:String):String
		{
			var regx:RegExp = /[\\"\r\n]/g;
			return '"' + $string.replace(regx,_quote) + '"';//"
		}

		/**
		*Removes all instances of the remove string in the input string.
		*
		*@param $string The string that will be checked for instances of remove
		*string
		*
		*@param $remove The string that will be removed from the input string.
		*
		*@param $caseSensitive An optional boolean indicating if the replace is case sensitive. Default is true.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function remove($string:String, $remove:String, $caseSensitive:Boolean = true):String
		{
			if ($string == null) {
				return '';
			}
			var rem:String = escapePattern($remove);
			var flags:String = (!$caseSensitive) ? 'ig' : 'g';
			return $string.replace(new RegExp(rem,flags),'');
		}

		/**
		*Removes extraneous whitespace (extra spaces, tabs, line breaks, etc) from the
		*specified string.
		*
		*@param $string The String whose extraneous whitespace will be removed.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function removeExtraWhitespace($string:String):String
		{
			if ($string == null) {
				return '';
			}
			var str:String = trim($string);
			return str.replace(/\s+/g,' ');
		}

		/**
		*Returns the specified string in reverse character order.
		*
		*@param $string The String that will be reversed.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function reverse($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.split('').reverse().join('');
		}

		/**
		*Returns the specified string in reverse word order.
		*
		*@param $string The String that will be reversed.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function reverseWords($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.split(/\s+/).reverse().join('');
		}

		/**
		*Determines the percentage of similiarity, based on editDistance
		*
		*@param $source The source string.
		*
		*@param $target The target string.
		*
		*@returns Number
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function similarity($source:String, $target:String):Number
		{
			var ed:uint = editDistance($source, $target);
			var maxLen:uint = Math.max($source.length, $target.length);
			if (maxLen == 0) {
				return 100;
			} else {
				return 1 - ed / maxLen * 100;
			}
		}

		/**
		*Remove's all < and > based tags from a string
		*
		*@param $string The source string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function stripTags($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.replace(/<\/?[^>]+>/igm,'');
		}

		/**
		*Swaps the casing of a string.
		*
		*@param $string The source string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function swapCase($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.replace(/(\w)/,_swapCase);
		}

		/**
		*Removes whitespace from the front and the end of the specified
		*string.
		*
		*@param $string The String whose beginning and ending whitespace will
		*will be removed.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function trim($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.replace(/^\s+|\s+$/g,'');
		}

		/**
		*Removes whitespace from the front (left-side) of the specified string.
		*
		*@param $string The String whose beginning whitespace will be removed.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function trimLeft($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.replace(/^\s+/,'');
		}

		/**
		*Removes whitespace from the end (right-side) of the specified string.
		*
		*@param $string The String whose ending whitespace will be removed.
		*
		*@returns String.
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function trimRight($string:String):String
		{
			if ($string == null) {
				return '';
			}
			return $string.replace(/\s+$/,'');
		}

		/**
		*Determins the number of words in a string.
		*
		*@param $string The string.
		*
		*@returns uint
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function wordCount($string:String):uint
		{
			if ($string == null) {
				return 0;
			}
			return $string.match(/\b\w+\b/g).length;
		}

		/**
		*Returns a string truncated to a specified length with optional suffix
		*
		*@param $string The string.
		*
		*@param $len The length the string should be shortend to
		*
		*@param $suffix (optional, default=...) The string to append to the end of the truncated string.
		*
		*@returns String
		*
		* @langversion ActionScript 3.0
		*@playerversion Flash 9.0
		*@tiptext
		*/
		public static function truncate($string:String, $len:uint, $suffix:String = "..."):String
		{
			if ($string == null) {
				return '';
			}
			$len -= $suffix.length;
			var trunc:String = $string;
			if (trunc.length > $len) {
				trunc = trunc.substr(0, $len);
				if (/[^\s]/.test($string.charAt($len))) {
					trunc = trimRight(trunc.replace(/\w+$|\s+$/, ''));
				}
				trunc += $suffix;
			}

			return trunc;
		}

		/* **************************************************************** */
		/*These are helper methods used by some of the above methods.*/
		/* **************************************************************** */
		private static function escapePattern($pattern:String):String
		{
			// RM: might expose this one, I've used it a few times already.
			return $pattern.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g,'\\$1');
		}

		private static function _minimum(a:uint, b:uint, c:uint):uint
		{
			return Math.min(a,Math.min(b,Math.min(c,a)));
		}

		private static function _quote($string:String, ...args):String
		{
			switch ($string) {
				case "\\" :
					return "\\\\";
				case "\r" :
					return "\\r";
				case "\n" :
					return "\\n";
				case '"' :
					return '\\"';
				default :
					return '';
			}
		}

		private static function _upperCase($char:String, ...args):String
		{
			return $char.toUpperCase();
		}

		private static function _swapCase($char:String, ...args):String
		{
			var lowChar:String = $char.toLowerCase();
			var upChar:String = $char.toUpperCase();
			switch ($char) {
				case lowChar :
					return upChar;
				case upChar :
					return lowChar;
				default :
					return $char;
			}
		}
		
		
		public static function replace($raw:String,$tag:String,$content:String):String
		{
			var strRaw:String = $raw;
			var objRegExp:RegExp = new RegExp($tag,"g");
			//
			strRaw = strRaw.replace(objRegExp, $content)
			//
			return strRaw;
		}
		
		public static function multiReplace($raw:String,$changes:Array):String
		{
			var strRaw:String = $raw;
			var numLength:Number = $changes.length
			//
			for(var i:Number = 0; i < numLength; i++){
				strRaw = StringUtil.replace(strRaw,$changes[i].tag, $changes[i].content);	
			}
			//
			return strRaw;
		}
	}
}