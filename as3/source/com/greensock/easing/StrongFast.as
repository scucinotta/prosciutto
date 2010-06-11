package com.greensock.easing {
	
	public class StrongFast extends FastEase {
		public static var activated:Boolean;
		public static var power:uint = 4;
		
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			if (!activated) {
				FastEase.activate([StrongFast]);
			}
			return (t=t/d)*t*t*t*t;
		}
		
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			if (!activated) {
				FastEase.activate([StrongFast]);
			}
			return 1 - (t = 1 - (t / d)) * t * t * t * t;
		}
		
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if (!activated) {
				FastEase.activate([StrongFast]);
			}
			if ((t = t / d) < 0.5) return 0.5 * (t = t * 2) * t * t * t * t;
			return 1 - (0.5 * ((t = (1 - t) * 2) * t * t * t * t));
		}
		
		/* not worth the added kb
		public static function easeOutIn(t:Number, b:Number, c:Number, d:Number):Number {
			if (!activated) {
				FastEase.activate([StrongFast]);
			}
			if ((t = t / d) < 0.5) return 0.5 - (0.5 * (t = 1 - (2 * t)) * t * t * t * t);
			return 0.5 + (0.5 * (t = (2 * t) - 1) * t * t * t * t);
		}
		*/
		
	}
}