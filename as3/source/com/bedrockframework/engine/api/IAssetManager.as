package com.bedrockframework.engine.api
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	
	public interface IAssetManager
	{
		function initialize( $applicationDomain:ApplicationDomain ):void;
		/*
		Add/ Return new preloader instance
		*/
		function addPreloader( $alias:String, $linkage:String ):void;
		function getPreloader( $alias:String ):MovieClip;
		function hasPreloader( $alias:String ):Boolean;
		/*
		Add/ Return new view instance
		*/
		function addView( $alias:String, $linkage:String ):void;
		function getView( $alias:String ):*;
		function hasView( $alias:String ):Boolean;
		function getViews( $includeAliases:Boolean = false ):Array;
		/*
		Add/ Return new bitmap instance
		*/
		function addBitmap( $alias:String, $linkage:String ):void;
		function getBitmap( $alias:String ):BitmapData;
		function hasBitmap( $alias:String ):Boolean;
		function getBitmaps( $includeAliases:Boolean = false ):Array;
		/*
		Add/ Return new sound instance
		*/
		function addSound( $alias:String, $linkage:String ):void;
		function getSound( $alias:String ):Sound;
		function hasSound( $alias:String ):Boolean;
		function getSounds( $includeAliases:Boolean = false ):Array;
	}
}