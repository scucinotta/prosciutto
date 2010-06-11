package com.bedrockframework.plugin.tools
{
	import com.bedrockframework.core.base.DispatcherWidget;
	import com.bedrockframework.plugin.event.PaginationEvent;

	public class Pagination extends DispatcherWidget implements IPageable
	{
		/*
		Variable Decarations
		*/
		private var _numTotalItems:uint;
		private var _numTotalPages:uint;
		private var _numItemsPerPage:uint;
		private var _numSelectedPage:uint;
		public var wrap:Boolean;
		/*
		Constructor
		*/
		public function Pagination()
		{
			this.reset();
		}
		/*
		Public Functions
		*/
		public function update($total:uint = 0, $itemsPerPage:uint = 0):void
		{
			this._numSelectedPage = 0;
			this._numTotalItems =  $total;
			this._numItemsPerPage = $itemsPerPage;
			this._numTotalPages = Math.ceil(this._numTotalItems / this._numItemsPerPage) || 0;
			this.status("Total Records - " + this._numTotalItems);
			this.status("Total Pages - " + this._numTotalPages);
			this.checkBounds();
			this.dispatchEvent(new PaginationEvent(PaginationEvent.UPDATE, this, {total:this._numTotalPages, selected:this._numSelectedPage}));
			this.selectPage( 0 );
		}
		public function reset():void
		{
			this._numTotalItems = 0;
			this._numItemsPerPage = 0;
			this._numTotalPages = 0;
			this._numSelectedPage = 0;
			this.dispatchEvent( new PaginationEvent(PaginationEvent.RESET, this ) );
		}
		/*
		Page Selection Functions
		*/
		public function selectPage($index:uint):uint
		{
			if ( $index >= this._numTotalPages ) {
				this._numSelectedPage = ( this._numTotalPages - 1 );
			} else if ( $index < 0  ) {
				this._numSelectedPage = 0;
			} else {
				this._numSelectedPage = $index;
				this.status("Selected Page - " + this._numSelectedPage);
				this.dispatchEvent(new PaginationEvent(PaginationEvent.SELECT_PAGE, this, {selected:this._numSelectedPage, total:this._numTotalPages}));
			}
			return this._numSelectedPage;
		}
		 /* 
		Check Bounds 
		*/ 
		private function checkBounds():void 
		{ 
			if ( this._numSelectedPage >= this._numTotalPages ) {
				this._numSelectedPage = ( this._numTotalPages - 1 );
			}
		}
		/*
		Navigate Pages
		*/
		public function nextPage():uint
		{
			if ( this.hasNextPage() ) {
				return this.selectPage( this._numSelectedPage + 1);
			} else {
				return this._numSelectedPage;
			}
		}
		public function previousPage():uint
		{
			if ( this.hasPreviousPage() ) {
				return this.selectPage(this._numSelectedPage - 1);
			} else {
				return this._numSelectedPage;
			}
		}
		/*
		Has Pages
		*/
		public function hasNextPage():Boolean
		{
			return this.hasPage( this._numSelectedPage + 1 );
		}
		public function hasPreviousPage():Boolean
		{
			return this.hasPage( this._numSelectedPage - 1 );
		}
		public function hasPage( $page:uint ):Boolean
		{
			return ( ( $page  >= 0 ) && ( $page < this._numTotalPages ) );
		}
		/*
		Property Definitions
		*/
		public function get totalItems():uint
		{
			return this._numTotalItems;
		}
		public function get selectedPage():uint
		{
			return this._numSelectedPage;
		}
		public function get itemsPerPage():uint
		{
			return this._numItemsPerPage;
		}
		public function get totalPages():uint
		{
			return this._numTotalPages;
		}
	}
}