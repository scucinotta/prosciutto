package com.bedrockframework.plugin.tools
{
	public interface IPageable
	{
		function hasNextPage():Boolean;
		function hasPreviousPage():Boolean;
		function hasPage( $page:uint ):Boolean;
		
		function selectPage($index:uint):uint;
		function nextPage():uint;
		function previousPage():uint;
		
		function get totalItems():uint;
		function get selectedPage():uint;
		function get totalPages():uint;
		
	}
}