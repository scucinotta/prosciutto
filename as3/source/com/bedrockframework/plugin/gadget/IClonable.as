package com.bedrockframework.plugin.gadget
{
	public interface IClonable
	{
		function set index( $value:int ):void;
		function get index():int;
		
		function set row( $value:int ):void;
		function get row():int;
		
		function set column( $value:int ):void;
		function get column():int;
	}
}