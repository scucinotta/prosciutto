package com.bedrockframework.plugin.storage
{
	public class SuperArray
	{
		import com.bedrockframework.plugin.util.MathUtil;
		import com.bedrockframework.plugin.util.ArrayUtil;
		/*
		Variable Declarations
		*/
		private var _arrData:Array;
		private var _numSelectedIndex:int;
		private var _bolWrapIndex:Boolean;
		private var _numLimit:int;
		private var _bolAllowDuplicates:Boolean;
		/*
		Constructor
		*/
		public function SuperArray( $data:Array = null )
		{
			this.data = $data || new Array;
			this._bolWrapIndex=false;
			this.reset();
		}
		/*
		Clear
		*/
		public function clear():void
		{
			var numLength:int=this._arrData.length;
			for (var i:int=0; i < numLength; i++) {
				this._arrData.pop();
			}
			this.reset();
		}
		/*
		Reset Selections
		*/
		public function reset():void
		{
			this._numSelectedIndex = 0;
		}
		/*
		Returns a copy of the array
		*/
		public function duplicate():Array
		{
			return ArrayUtil.duplicate(this._arrData);
		}
		/*
		Insert new data at index
		*/
		public function insert($location:int,$item:*):Array
		{
			return ArrayUtil.insert(this._arrData,$location,$item);
		}
		/*
		Move item to a different location
		*/
		public function move($index:int,$location:int):Array
		{
			return ArrayUtil.move(this._arrData, $index, $location);
		}
		
		public function swap( $index1:int, $index2:int ):void
		{
			var tmpData1:* = this._arrData[ $index1 ];
			var tmpData2:* = this._arrData[ $index2 ];
			
			this._arrData[ $index1 ] = tmpData2;
			this._arrData[ $index2 ] = tmpData1;
		}
		/*
		Remove item at index
		*/
		public function remove($index:int):*
		{
			return ArrayUtil.remove(this._arrData,$index);
		}
		/*
		Add to end
		*/
		public function automaticPush($array:Array):void
		{
			var numLength:int=$array.length;
			for (var i:int=0; i < numLength; i++) {
				this._arrData.push($array[i]);
			}
		}
		/*
		Loop through an array unshift each item in
		*/
		public function automaticUnshift($array:Array):void
		{
			var numLength:int=$array.length;
			for (var i:int=0; i < numLength; i++) {
				this._arrData.unshift($array[i]);
			}
		}
		/*
		Wrappers 
		*/
		public function push(...$arguments:Array):void
		{
			var numLength:int = $arguments.length;
			for (var a:int = 0 ; a < numLength; a++) {
				this._arrData.push($arguments[a]);
			}			
			if (this._numLimit != 0) {
				if (this._arrData.length > this._arrData._numLimit) {
					var numLoop:int=this._numLimit - this._arrData.length;
					for (var i:int=0; i < numLoop; i++) {
						this._arrData.shift();
					}
				}
			}
		}
		public function unshift(...$arguments:Array):void
		{
			var numLength:int = $arguments.length;
			for (var a:int = 0 ; a < numLength; a++) {
				this._arrData.unshift($arguments[a]);
			}
			if (this._numLimit != 0) {
				if (this._arrData.length > this._numLimit) {
					var numLoop:int=this._numLimit - this._arrData.length;
					for (var i:int=0; i < numLoop; i++) {
						this._arrData.pop();
					}
				}
			}
		}
		/*
		Return item at location
		*/
		public function getItemAt( $index:uint ):*
		{
			if (this._bolWrapIndex){
				return this._arrData[MathUtil.wrapIndex($index, this._arrData.length, true)];
			}else{
				try{
					return this._arrData[$index];
				} catch($error:Error){
					return null
				}					
			}		
		}
		/*
		Increment selected index
		*/
		public function selectNext():*
		{
			return this.setSelected(this._numSelectedIndex + 1);
		}
		/*
		Decrement selected index
		*/
		public function selectPrevious():*
		{
			return this.setSelected(this._numSelectedIndex - 1);
		}
		/*
		Select current index
		*/
		public function setSelected($index:int):*
		{
			//check for wrapping
			this._numSelectedIndex=MathUtil.wrapIndex($index, this._arrData.length, this._bolWrapIndex);
			return this.getSelected();
		}
		/*
		Return selected item from the array
		*/
		public function getSelected():*
		{
			return this.getItemAt(this._numSelectedIndex);
		}
		
		/*
		Select a random item in the array
		*/
		public function selectRandom():*
		{
			if (this._arrData.length > 0) {
				return this.setSelected(ArrayUtil.randomIndex(this._numSelectedIndex,this._arrData.length));
			}
		}
		/*
		* Has more items
		*/
		public function hasNext():Boolean
		{
			if (this._bolWrapIndex) {			
				return true;
			}
			return ( ( this._numSelectedIndex + 1 )  < this._arrData.length );
		}
		public function hasPrevious():Boolean
		{
			if (this._bolWrapIndex) {			
				return true;
			}
			return ( ( this._numSelectedIndex - 1 )  >= 0 );
		}
		/*
		Get random items based on a total
		*/
		public function getRandomItems($total:int):*
		{
			if (this._arrData.length > 0) {
				return ArrayUtil.getRandomItems(this._arrData,$total);
			}
		}
		/*
		Get object properties from array
		*/
		public function getProperties($property:String):Array
		{
			var numLength:int=this._arrData.length;
			var arrReturn:Array=new Array;
			for (var i:int=0; i < numLength; i++) {
				arrReturn.push(this._arrData[i][$property]);
			}
			return arrReturn;
		}
		/*
		Search: Returns array with results
		*/
		public function filter($value:*,$field:String=null):Array
		{
			return ArrayUtil.filter(this._arrData,$value,$field);
		}
		/*
		Search for and remove an item from an array
		*/
		public function filterAndRemove($value:*,$field:String=null):Array
		{
			return ArrayUtil.filterAndRemove(this._arrData,$value,$field);
		}
		/*
		Search: Returns Single Index
		*/
		public function findIndex($value:*,$field:String=null):int
		{
			return ArrayUtil.findIndex(this._arrData,$value,$field);
		}
		/*
		Search: Returns Single Item
		*/
		public function findItem($value:*, $field:String=null ):*
		{
			return ArrayUtil.findItem(this._arrData,$value,$field);
		}
		/*
		Search: Finds a string within a field
		*/
		public function findContaining($value:*,$field:String=null):*
		{
			return ArrayUtil.findContaining(this._arrData,$value,$field);
		}
		public function findAndRemove($value:*, $field:String=null):*
		{
			return ArrayUtil.findAndRemove( this._arrData, $value, $field );
		}
		/*
		Search: Returns true or false wether a value exists or not
		*/
		public function containsItem($value:*,$field:String=null):Boolean
		{
			return ArrayUtil.containsItem(this._arrData,$value,$field);
		}
		/*
		Search: Selects and Returns a Single Item
		*/
		public function findAndSelect($value:*,$field:String=null):*
		{
			return this.setSelected( ArrayUtil.findIndex( this._arrData, $value, $field ) );
		}
		/*
		*/
		public function iterate( $handler:Function ):void
		{
			ArrayUtil.iterate( this.data, $handler );
		}
		/*
		Set/ Get data
		*/
		public function set data($data:Array):void
		{
			this._arrData = $data;
			this.reset();
		}
		public function get data():Array
		{
			return this._arrData;
		}
		/*
		Set the limit for the number if items that should be in the array
		*/
		public function set itemLimit($limit:int):void
		{
			this._numLimit=$limit;
		}
		public function get itemLimit():int
		{
			return this._numLimit;
		}
		
		public function get length():int
		{
			return this.data.length;
		}
		/*
		Return the last index from the array
		*/
		public function get lastIndex():int
		{
			return (this._arrData.length - 1);
		}
		/*
		Allow for duplicate entries
		*/
		public function set allowDuplicates($status:Boolean):void
		{
			this._bolAllowDuplicates=$status;
		}
		public function get allowDuplicates():Boolean
		{
			return this._bolAllowDuplicates;
		}
		/*
		Set the wrapping properties of the array
		*/
		public function set wrapIndex($status:Boolean):void
		{
			this._bolWrapIndex=$status;
		}
		public function get wrapIndex():Boolean
		{
			return this._bolWrapIndex;
		}
		/*
		Return selected item from the array
		*/
		public function get selectedIndex():int
		{
			return this._numSelectedIndex;
		}
		public function get selectedItem():*
		{
			return this.getSelected();
		}
	}
}