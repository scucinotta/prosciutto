/**

Cloner

*/
package com.bedrockframework.plugin.gadget
{
	import com.bedrockframework.core.base.SpriteWidget;
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.MathUtil;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Cloner extends SpriteWidget
	{

		/*
		Variable Decarations
		*/
		private var _objCurrentClone:DisplayObjectContainer;

		private var _numPositionX:int;
		private var _numPositionY:int;
		
		private var _numMaxSpacingX:int;
		private var _numMaxSpacingY:int;

		private var _numIndex:int;
		private var _numColumn:int;
		private var _numRow:int;
		private var _numWrapIndex:int;

		private var _mapClones:HashMap;
		private var _arrClones:Array;
		
		public var data:ClonerData;
		/*
		Constructor
		*/
		public function Cloner()
		{
			this._mapClones = new HashMap;
			this._arrClones = new Array;
		}
		public function initialize($data:ClonerData):Array
		{
			this.data = $data;
			this.clear();
			//
			this.status("Initialize");
			this.dispatchEvent( new ClonerEvent( ClonerEvent.INITIALIZE, this, { total:this.data.total } ) );
			
			if ( this.data.autoPositioning && this.data.positionClonesAt == ClonerData.CREATION ) {
				this.applyOffset();
			}
			
			for (var i:int = 0; i < this.data.total; i++) {
				this.createClone();
			}
			this.dispatchEvent( new ClonerEvent( ClonerEvent.COMPLETE, this, { total:this.data.total, children:this._arrClones } ) );
			
			if ( this.data.autoPositioning && this.data.positionClonesAt == ClonerData.COMPLETION ) {
				this.positionClones();
			}
			
			return this._arrClones;
		}
		public function clear($resetPosition:Boolean=true,$resetIndex:Boolean=true,$resetWrapping:Boolean=true):void
		{
			this._numColumn = 0;
			this._numRow = 0;
			//
			if ($resetPosition) {
				this._numPositionX = 0;
				this._numPositionY = 0;
			}
			if ($resetIndex) {
				this._numIndex= 0;
			}
			if ($resetWrapping) {
				this._numWrapIndex = 0;
			}
			//
			this.destroyClones();
			this._mapClones.clear();
			this._arrClones = new Array;

			this.dispatchEvent(new ClonerEvent(ClonerEvent.CLEAR,this));
			this.status("Cleared");
		}
		
		
		/*
		Destroy Clones
		*/
		private function destroyClones():void
		{
			try {
				var numLength:int = this._arrClones.length;
				for (var i:int =0; i <numLength; i++) {
					this.removeClone( i );
				}
			} catch ($e:Error) {
			}
		}
		public function positionClones():void
		{
			this.calculateMaxSpacing();
			this.applyOffset();
			var numLength:int = this._arrClones.length;
			for (var i:int =0; i <numLength; i++) {
				this.applyProperties( this._arrClones[ i ], this.getPositionProperties( i ) );
			}
		}
		/*
		Clone Functions
		*/
		public function createClone():DisplayObjectContainer
		{
			this._objCurrentClone=new this.data.clone;
			this._mapClones.saveValue( this._numIndex.toString(), this._objCurrentClone );
			this._arrClones.push( this._objCurrentClone );

			this.addChild( this._objCurrentClone );
			if ( this.data.autoPositioning && this.data.positionClonesAt == ClonerData.CREATION ) {
				this.applyProperties( this._objCurrentClone, this.getPositionProperties( this._numIndex ) );
			}

			this.dispatchEvent( new ClonerEvent( ClonerEvent.CREATE, this, { child:this._objCurrentClone, index:this._numIndex } ) );
			this._numIndex++;
			return this._objCurrentClone;
		}
		public function removeClone($identifier:*):void
		{
			var numID:Number;
			var objChild:DisplayObject;
			if ( $identifier is Number ) {
				numID=$identifier;
				objChild = this.removeChild(this.getClone($identifier));
			} else {
				numID=$identifier;
				objChild = this.removeChild($identifier);
			}
			objChild = null;
			this.dispatchEvent(new ClonerEvent(ClonerEvent.REMOVE,this,{id:numID}));
		}
		/*
		
		
		Positioning Property
		
		
		*/
		private function getPositionProperties( $index:int ):Object
		{
			if ( $index != 0) {
				this._numWrapIndex++;
				switch (this.data.pattern) {
					case ClonerData.GRID :
						this.calculateGridProperties( $index );
						break;
					case ClonerData.LINEAR :
						this.calculateLinearProperties( $index );
						break;
					case ClonerData.RANDOM :
						return this.calculateRandomProperties( $index );
						break;
				}
			} else if (this.data.pattern == ClonerData.RANDOM) {
				return this.calculateRandomProperties( $index );
			}
			return { x:this._numPositionX, y:this._numPositionY, column:this._numColumn, row:this._numRow, index:$index};
		}
		private function calculateLinearProperties( $index:int ):void
		{
			switch (this.data.direction) {
				case ClonerData.HORIZONTAL :
					this._numPositionX += this.getSpacingX( $index );
					break;
				case ClonerData.VERTICAL :
					this._numPositionY += this.getSpacingY( $index );
					break;
			}
		}
		private function calculateGridProperties( $index:int ):void
		{
			switch (this.data.direction) {
				case ClonerData.HORIZONTAL :
					this._numPositionX += this.getSpacingX( $index );
					if ( this._numWrapIndex >= this.data.wrap ) {
						this._numPositionX = 0;
						this._numPositionY += this.getSpacingY( $index );
						this._numWrapIndex = 0;
						this._numRow += 1;
					}
					this._numColumn = this._numWrapIndex;
					break;
				case ClonerData.VERTICAL :
					this._numPositionY += this.getSpacingY( $index );
					if ( this._numWrapIndex >= this.data.wrap ) {
						this._numPositionY = 0;
						this._numPositionX += this.getSpacingX( $index );
						this._numWrapIndex = 0;
						this._numColumn += 1;
					}
					this._numRow = this._numWrapIndex;
					break;
			}
		}
		private function calculateRandomProperties(  $index :int ):Object
		{
			return { x:MathUtil.random( this.data.rangeX ), y:MathUtil.random( this.data.rangeY ), index:$index };
		}
		
		private function getSpacingX( $index:int ):Number
		{
			if ( !this.data.autoSpacing ) {
				return this.data.spaceX + this.data.paddingX;
			} else {
				switch ( this.data.pattern ) {
					case ClonerData.LINEAR :
						return this.getClone( $index - 1 ).width + this.data.paddingX;
					case ClonerData.GRID :
						if ( this.data.positionClonesAt == ClonerData.COMPLETION ) {
							return this._numMaxSpacingX + this.data.paddingX;
						} else {
							return this.data.spaceX + this.data.paddingX;
						}
				}
			}
			return this.data.spaceX;
		}
		private function getSpacingY( $index:int ):Number
		{
			if ( !this.data.autoSpacing ) {
				return this.data.spaceY + this.data.paddingY;;
			} else {
				switch ( this.data.pattern ) {
					case ClonerData.LINEAR :
						return this.getClone( $index - 1 ).height + this.data.paddingY;
					case ClonerData.GRID :
						if ( this.data.positionClonesAt == ClonerData.COMPLETION ) {
							return this._numMaxSpacingY + this.data.paddingY;
						} else {
							return this.data.spaceY + this.data.paddingY;
						}
				}
			}
			return this.data.spaceY;
		}
		private function calculateMaxSpacing():void
		{
			var objClone:DisplayObjectContainer;
			var numLength:int = this._arrClones.length;
			for (var i:int =0; i <numLength; i++) {
				objClone = this._arrClones[ i ];
				if ( objClone.width > this._numMaxSpacingX ) this._numMaxSpacingX = objClone.width;
				if ( objClone.height > this._numMaxSpacingY ) this._numMaxSpacingY = objClone.height;
			}
		}
		
		private function applyProperties($target:DisplayObjectContainer,$data:Object):void
		{
			var objData:Object = $data;
			try {
				var objClone:IClonable=$target as IClonable;
			} catch ($e:Error) {
				// Is not type of IClonable, cannot apply certain properties.
				delete objData.index;
				delete objData.column;
				delete objData.row;
			} 
			if ( objClone == null ) {
				delete objData.index;
				delete objData.column;
				delete objData.row;
			}
			for (var d:String in objData) {
				$target[ d ]=objData[ d ];
			}
		}
		/*
		
		
		Getters
		
		
		*/
		public function getClone( $index:int ):*
		{
			return this._mapClones.getValue( $index.toString() );
		}

		/*
		
		
		Property Definitions
		
		
		*/
		private function applyOffset():void
		{
			if ( this.data.offsetX != 0 ) this._numPositionX += this.data.offsetX;
			if ( this.data.offsetY != 0 ) this._numPositionY += this.data.offsetY;
		}
		/*
		Returns the current index of the movieclip being cloned.
		*/
		public function get index():int
		{
			return this._numIndex;
		}
		public function get row():int
		{
			return this._numRow;
		}
		public function get column():int
		{
			return this._numColumn;
		}
		/*
		Returns the instance of the display object being cloned.
		*/
		public function get current():*
		{
			return this._objCurrentClone;
		}
	
		public function get clones():Array
		{
			return this._arrClones;
		}
		
	}
}