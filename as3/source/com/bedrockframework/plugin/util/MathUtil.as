package com.bedrockframework.plugin.util
{
	import com.bedrockframework.core.base.StaticWidget;
	
	import flash.utils.*;
	
	public class MathUtil extends StaticWidget
	{
		public static  function wrapIndex($index:Number,$total:Number,$wrap:Boolean=false):Number
		{
			var numIndex:Number;
			var numDifference:Number;
			var numRemainder:Number;
			var numTotal:Number=$total;
			var bolWrap:Boolean=$wrap;
			if (bolWrap) {
				if ($index >= $total) {
					numIndex=$index;
					numDifference=Math.floor(numIndex / numTotal);
					//
					if (numDifference > 1) {
						numRemainder=numIndex % numTotal;
						return numRemainder;
					}
					return numIndex - numTotal;
				} else if ($index < 0) {
					numIndex=Math.abs($index);
					numDifference=Math.ceil(numIndex / numTotal);
					if (numDifference > 1) {
						numRemainder=numIndex % numTotal;
						if (numRemainder == 0) {
							return numRemainder;
						} else {
							return (numTotal - numRemainder);
						}
					}
					return Math.abs(numTotal - numIndex);
				} else {
					return $index;
				}
			} else {
				if ($index >= numTotal) {
					return (numTotal - 1);
				} else if ($index < 0) {
					return 0;
				} else {
					return $index;
				}
			}
		}
		public static  function maintainRange($value:Number,$min:Number, $max:Number):Number
		{
			var numIndex:Number;
			var numDifference:Number;
			var numRemainder:Number;
			if ($value > $max) {
				numIndex=$value;
				numDifference=Math.floor(numIndex / $max);
				//
				if (numDifference > 1) {
					numRemainder=numIndex % $max;
					return numRemainder;
				}
				return numIndex - $max;
			} else if ($value < $min) {
				numIndex=Math.abs($value);
				numDifference=Math.ceil(numIndex / $max);
				if (numDifference > 1) {
					numRemainder=numIndex % $max;
					if (numRemainder == 0) {
						return numRemainder;
					} else {
						return ($max - numRemainder);
					}
				}
				return Math.abs($max - numIndex);
			} else {
				return $value;
			}
		}
		/*
		Get angle between 2 points
		*/
		public static  function getAngle($x1:Number,$y1:Number,$x2:Number,$y2:Number):Number
		{
			var numXdelta:Number=$x2 - $x1;
			var numYdelta:Number=$y2 - $y1;
			var numAngle:Number=-180 * Math.atan2(numYdelta,numXdelta) / Math.PI;
			return (Math.round(numAngle));
		}
		/*
		Get distance between 2 points
		*/
		public static  function getDistance($xPoint1:Number,$yPoint1:Number,$xPoint2:Number,$yPoint2:Number):Number
		{
			var distanceX:Number=$xPoint2 - $xPoint1;
			var distanceY:Number=$yPoint2 - $yPoint1;
			return Math.sqrt(distanceX * distanceX + distanceY * distanceY);
		}
		/*
		Convert Degrees to Radians
		*/
		public static  function degreesToRadians($angle:Number):Number
		{
			return $angle * Math.PI / 180;
		}
		/*
		Convert Radians to Degrees
		*/
		public static  function radiansToDegrees($angle:Number):Number
		{
			return $angle * 180 / Math.PI;
		}
		/*
		Is Odd
		*/
		public static  function isOdd($number:Number):Boolean
		{
			if ($number % 2 == 0) {
				return false;
			} else {
				return true;
			}
		}
		/*
		Is Even
		*/
		public static  function isEven($number:Number):Boolean
		{
			if ($number % 2 == 0) {
				return true;
			} else {
				return false;
			}
		}
		/*
		Get sign
		*/
		public static  function getSign($number:Number):Number
		{
			return ($number == 0) ? 1 : $number / Math.abs($number);
		}
		/*
		Generate a random number in range
		*/
		public static  function random($maximum:Number,$minimum:Number=0,$decimal:Boolean=false):Number
		{
			var numRandom:Number = ($decimal) ? (Math.random() * ($maximum - $minimum)) + $minimum : Math.floor(Math.random() * ($maximum - $minimum)) + $minimum;
			return numRandom;
		}
		public static  function randomRange($minimum:Number,$maximum:Number,$decimal:Boolean=false):Number
		{
			return MathUtil.random($maximum, $minimum, $decimal);
		}
		/*
		Random no repeat
		*/
		public static  function randomNoRepeat($current:Number,$maximum:Number,$minimum:Number=0,$decimal:Boolean=false):Number
		{
			var numTemp:Number=$current;
			if( $maximum <= 1 ) return $current;
			do {
				numTemp=MathUtil.random($maximum, $minimum, $decimal);
			} while (numTemp == $current);
			return numTemp;
		}

		public static  function calculatePercentage($smaller:Number,$larger:Number):Number
		{
			return Math.round(($smaller / $larger) * 100);
		}
		
		public static function getPercentage( $percentage:Number, $total:Number ):Number
		{
			return ( $total * ( $percentage / 100 ) );
		}
		
		public static function calculateValueFromPercentage( $percentage:Number, $value:Number ):Number
		{
			return ( $value * ( $percentage / 100) );
		}
		public static function calculateRatio($value1:Number,$value2:Number):Number
		{
			return ($value1 / $value2);
		}
		
		
	}
}