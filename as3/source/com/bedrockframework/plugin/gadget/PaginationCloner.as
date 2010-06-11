package com.bedrockframework.plugin.gadget
{
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.event.PaginationEvent;
	import com.bedrockframework.plugin.storage.SuperArray;
	import com.bedrockframework.plugin.tools.IPageable;
	import com.bedrockframework.plugin.tools.Pagination;
	import com.bedrockframework.plugin.util.ArrayUtil;

	public class PaginationCloner extends Cloner implements IPageable
	{
		/*
		Variable Declarations
		*/
		private var _objCloner:Cloner;
		private var _objClonerData:ClonerData
		private var _objPagination:Pagination;
		private var _arrOriginalData:Array;
		private var _arrSegmentedData:Array;
		private var _objArrayBrowser:SuperArray;
		/*
		Constructor
		*/
		public function PaginationCloner()
		{
			this._objArrayBrowser = new SuperArray()
			
			this._objPagination = new Pagination();
			this._objPagination.addEventListener(PaginationEvent.SELECT_PAGE, this.onDispatchPaginationEvent);
			this._objPagination.addEventListener(PaginationEvent.SELECT_PAGE, this.onPageChange);
		}
		/*
		Initialize
		*/
		override public function initialize( $data:ClonerData ):Array
		{
			this.data = $data;
			return null;
		}
		public function populate( $data:Array, $pagesize:int = 0 ):void
		{
			this._arrSegmentedData = new Array();
			this._arrOriginalData = $data;
			if (this._arrOriginalData.length > $pagesize) {
				this._arrSegmentedData = ArrayUtil.segment(this._arrOriginalData, $pagesize);
			}else{
				this._arrSegmentedData.push(this._arrOriginalData);
			}
			this._objArrayBrowser.data = this._arrSegmentedData;
			this._objPagination.update( this._arrOriginalData.length, $pagesize );
			this.createPage(this._objPagination.selectedPage);
		}
		private function createPage( $index:int ):void
		{
			this.data.total = this.getSegment($index).length;
			super.initialize( this.data );
		}
		/*
		Get Segment Data
		*/
		private function getSegment($index:int):Array
		{
			return this._objArrayBrowser.getItemAt($index);
		}
		private function getCurrentSegment():Array
		{
			return this.getSegment(this._objPagination.selectedPage);
		}
		/*
		Next/ Previous Functionality
		*/
		public function nextPage():uint
		{
			return this._objPagination.nextPage();
		}
		public function previousPage():uint
		{
			return this._objPagination.previousPage();
		}
		public function selectPage($index:uint):uint
		{
			return this._objPagination.selectPage($index);
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
		Event Handlers
		*/
		private function onPageChange($event:PaginationEvent):void
		{
			this.createPage( this._objPagination.selectedPage );
		}
		/*
		Rebroadcast Functions
		*/
		private function onDispatchClonerEvent($event:ClonerEvent):void
		{
			this.dispatchEvent( new ClonerEvent($event.type, $event.origin, $event.details) );
		}
		private function onDispatchPaginationEvent($event:PaginationEvent):void
		{
			this.dispatchEvent( new PaginationEvent($event.type, $event.origin, $event.details) );
		}	
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
		public function get currentData():Array
        {
			return this.getCurrentSegment();
        }
	}
}