package com.bedrockframework.plugin.navigation
{
	import com.bedrockframework.core.base.MovieClipWidget;
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.data.SliderNavigationData;
	import com.bedrockframework.plugin.data.SuperShapeData;
	import com.bedrockframework.plugin.display.SuperShape;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.event.PaginationEvent;
	import com.bedrockframework.plugin.gadget.Cloner;
	import com.bedrockframework.plugin.tools.IPageable;
	import com.bedrockframework.plugin.tools.Pagination;
	import com.greensock.TweenMax;

	public class SliderNavigation extends MovieClipWidget implements IPageable
	{
		/*
		Variable Delcarations
		*/
		public var data:SliderNavigationData;
		public var cloner:Cloner;
		public var clonerMask:SuperShape;
		private var _objPagination:Pagination;
		private var _numSpace:Number;
		private var _numPadding:Number;
		/*
		Constructor
		*/
		public function SliderNavigation()
		{
		}
		public function initialize( $data:SliderNavigationData ):void
		{
			this.data = $data;
			this._numPadding = ( this.data.direction == ClonerData.HORIZONTAL ) ? this.data.paddingX : this.data.paddingY;
			this._numSpace = ( this.data.direction == ClonerData.HORIZONTAL ) ? this.data.spaceX : this.data.spaceY;
			this.createPagination();
			this.createCloner();
			this.createClones();
			this.createMask();
		}
		/*
		Creation Functions
		*/
		/*
		Creation Functions
		*/
		private function createPagination():void
		{
			this._objPagination = new Pagination;
			this._objPagination.addEventListener( PaginationEvent.SELECT_PAGE, this.dispatchEvent );
			this._objPagination.addEventListener( PaginationEvent.UPDATE, this.dispatchEvent );
			this._objPagination.addEventListener( PaginationEvent.RESET, this.dispatchEvent );
			this._objPagination.update(  this.data.total, this.data.visibleItems );
		}
		private function createCloner():void
		{
			this.cloner = new Cloner;
			this.cloner.addEventListener( ClonerEvent.CREATE, this.dispatchEvent );
			this.cloner.addEventListener( ClonerEvent.COMPLETE, this.dispatchEvent );
			this.cloner.addEventListener( ClonerEvent.CLEAR, this.dispatchEvent );
			this.addChild( this.cloner );
		}

		private function createClones():void
		{
			this.cloner.initialize( this.data );
		}
		private function createMask():void
		{
			var objData:SuperShapeData = new SuperShapeData;
			
			if ( this.data.visibleItems > 0 ) {
				switch ( this.data.direction ) {
					case ClonerData.HORIZONTAL :
						objData.width = ( this._numSpace * this.data.visibleItems ) + ( this._numPadding * ( this.data.visibleItems - 1 ) );
						objData.height = this.data.height;
						break;
					case ClonerData.VERTICAL :
						objData.width = this.data.width;
						objData.height = ( this._numSpace * this.data.visibleItems ) + ( this._numPadding * ( this.data.visibleItems - 1 ) );
						break;
				}
			} else {
				objData.width = this.data.width;
				objData.height = this.data.height;
			}
			
			this.clonerMask = new SuperShape;
			this.addChild( this.clonerMask );
			this.clonerMask.initialize( objData );
			
			this.cloner.mask = this.clonerMask;
		}
		/*
		Pagination
		*/
		public function nextPage():uint
		{
			if ( this._objPagination.hasNextPage() ) {
				this._objPagination.nextPage();
				this.updatePosition();
			}
			return this._objPagination.selectedPage;
		}
		public function previousPage():uint
		{
			if ( this._objPagination.hasPreviousPage() ) {
				this._objPagination.previousPage();
				this.updatePosition();
			}
			return this._objPagination.selectedPage;
		}
		public function selectPage( $page:uint ):uint
		{
			if ( this._objPagination.hasPage( $page ) ) {
				this._objPagination.selectPage( $page );
				this.updatePosition();
			}
			return this._objPagination.selectedPage;
		}
		/*
		Page Checks
		*/
		public function hasNextPage():Boolean
		{
			return this._objPagination.hasNextPage();
		}	
		public function hasPreviousPage():Boolean
		{
			return this._objPagination.hasPreviousPage();
		}
		public function hasPage( $page:uint ):Boolean
		{
			return this._objPagination.hasPage( $page );
		}
		/*
		Animate
		*/
		public function updatePosition():void
		{
			var numRemainder:Number = ( this._objPagination.totalItems % this._objPagination.itemsPerPage );
			var numSpacing:Number = ( this._numSpace * this.data.visibleItems ) + ( this._numPadding * this.data.visibleItems );
			var numPosition:Number = -( numSpacing * this._objPagination.selectedPage );
			
			if ( !this._objPagination.hasNextPage() && numRemainder > 0 && this.data.alwaysShowMaxItems ) {
				var numOffset:Number = ( this._objPagination.itemsPerPage - numRemainder );
				var numPositionOffset:Number = ( this._numSpace * numOffset ) + ( this._numPadding * numOffset );
				numPosition += numPositionOffset;
			}
			switch ( this.data.direction ) {
				case ClonerData.HORIZONTAL :
					TweenMax.to( this.cloner, this.data.time, { x:numPosition, ease:this.data.ease } );
					break;
				case ClonerData.VERTICAL :
					TweenMax.to( this.cloner, this.data.time, { y:numPosition, ease:this.data.ease } );
					break;
			}
		}
		/*
		Event Handlers
		*/
		
		/*
		Property Definitions
		*/
		public function get totalItems():uint
		{
			return this._objPagination.totalItems;
		}
		public function get selectedPage():uint
		{
			return this._objPagination.selectedPage;
		}
		public function get totalPages():uint
		{
			return this._objPagination.totalPages;
		}
	}
}