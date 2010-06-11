package 
{
	import flash.display.MovieClip;
	import com.bedrockframework.plugin.gadget.IClonable;
	import com.bedrockframework.plugin.util.MathUtil;
	
	public class ClonedClip extends MovieClip implements IClonable
	{
		private var _numID:int;
		private var _numRow:int;
		private var _numColumn:int;
		
		public function ClonedClip()
		{
			if ( MathUtil.random( 3 ) == 0 ) {
				this.gotoAndStop( 2 );
			}
		}
		/*
		Property Definitions
		*/
		public function set index( $value:int ):void
		{
			this._numID = $value;
		}
		public function get index():int
		{
			return this._numID;
		}
		public function set row( $value:int ):void
		{
			this._numRow = $value;
		}
		public function get row():int
		{
			return this._numRow;
		}
		public function set column( $value:int ):void
		{
			this._numColumn = $value;
		}
		public function get column():int
		{
			return this._numColumn;
		}


	}
}