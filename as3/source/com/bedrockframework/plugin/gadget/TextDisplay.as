/**
 * Bedrock Framework for Adobe Flash ©2007-2008
 * 
 * Written by: Alex Toledo
 * email: alex@builtonbedrock.com
 * website: http://www.builtonbedrock.com/
 * blog: http://blog.builtonbedrock.com/
 * 
 * By using the Bedrock Framework, you agree to keep the above contact information in the source code.
 *
 **/
package com.bedrockframework.plugin.gadget
{
	import com.bedrockframework.core.base.MovieClipWidget;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.data.TextDisplayData;
	import com.bedrockframework.plugin.util.VariableUtil;
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	import flash.text.engine.TextLine;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.TextFlowTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
/**
 * <b>TextDisplay</b> is an integrated Bedrock version of the TLF. It utilizes the basic elemets of the TLF to create multi-lingual copy for LTR & RTL languages.  
 *  The <b>TextDisplay</b> works in conjunction with the <b>TextDisplayData</b> class in order to assure 
 *  
 * 
 * @example Example AS3 code:<listing version="3.0">
 *
 package
 {
 import com.bedrockframework.plugin.data.TextDisplayData;
 import com.bedrockframework.plugin.gadget.TextDisplay;
 
 import flash.display.MovieClip;
 import flash.events.Event;
 
 public class TestDocument extends MovieClip
 {
		
	//Variable Declarations
	
	public var multilineText:TextDisplay;
	public var singlelineText:TextDisplay;
	public var multisinglelineText:TextDisplay;
	
	//Constructor
	
	public function TestDocument()
	{
		this.loaderInfo.addEventListener(Event.INIT, this.onBootUp);
	}

	
	//Basic view functions
 	
	public function initialize():void
	{
		this.initializeMultiline();
		this.initializeSingleline();
		this.initializeMultiSingleline();
	}
	
	private function initializeMultiline():void
	{
		var objData:TextDisplayData = new TextDisplayData;
		objData.mode = TextDisplayData.MULTI_LINE;
		objData.autoLocale = false;
		// autoLocale only works when running along with the Bedrock engine
		
		this.multilineText = new TextDisplay;
		this.multilineText.x = 50;
		this.multilineText.y = 50;
		this.multilineText.initialize( objData );
		this.multilineText.populate( "Little Ms. Muffet sat on her tuffet, eating her turds in waves." );
		this.addChild( this.multilineText );
	}
	private function initializeSingleline():void
	{
		var objData:TextDisplayData = new TextDisplayData;
		objData.mode = TextDisplayData.SINGLE_LINE;
		objData.autoLocale = false;
		objData.width = 400;
		
		this.singlelineText = new TextDisplay;
		this.singlelineText.x = 50;
		this.singlelineText.y = 150;
		this.singlelineText.initialize( objData );
		this.singlelineText.populate( "Little Ms. Muffet sat on her tuffet, eating her turds in waves." );
		this.addChild( this.singlelineText );
	}
	private function initializeMultiSingleline():void
	{
		var objData:TextDisplayData = new TextDisplayData;
		objData.mode = TextDisplayData.MULTI_SINGLE_LINE;
		objData.autoLocale = false;
		objData.width = 150;
		
		this.multisinglelineText = new TextDisplay;
		this.multisinglelineText.x = 50;
		this.multisinglelineText.y = 250;
		this.multisinglelineText.initialize( objData );
		this.multisinglelineText.populate( "Little Ms. Muffet sat on her tuffet, eating her turds in waves." );
		this.addChild( this.multisinglelineText );
	}
	
	//Event Handlers
	
	final private function onBootUp($event:Event):void
	{
		this.initialize();
	}
		
 }
 }
 </listing>
 * 
 * <b>Copyright 2010, builtonbedrock. All rights reserved.</b> By using the Bedrock Framework, you agree to keep the contact information in the source code.
 * 
 * @author Alex Toledo, alex@builtonbedrock.com
 *
 * Commented by Steve Cucinotta
 */	
	public class TextDisplay extends MovieClipWidget
	{
		/**
		 * Variable Declarations
		 */
		public var data:TextDisplayData;
		//Objects
		private var _objSpanElement:SpanElement;
		private var _objParagraphElement:ParagraphElement;
		private var _objTextFlow:TextFlow;
		private var _objTextLine:TextLine;
		//Arrays
		private var _arrTextLines:Array;
		//Booleans
		private var _bolCreated:Boolean;
		//Movieclips - public
		public var background:MovieClip;
		/**
		 * Constructor
		 * 
		 * <ul>
		 * 	<li>Does not accept any params.</li>
		 * 	<li>Sets the mouseChildren false by default.</li>
		 * 	<li>Declares an empty Array of textlines.</li>
		 * </ul>
		 */
		public function TextDisplay()
		{
			super( false );
			this.mouseChildren = false;
			this._arrTextLines = new Array;
		}
		/**
		 * Initialize
		 * 
		 * @param $data An object that is typed as <b>TextDisplayData</b>.<br /><br />
		 * For example :<br /><br />
		 * <code>var objData:TextDisplayData = new TextDisplayData( )<br />
		 * objData.mode = TextDisplayData.SINGLE_LINE;<br />
		 * objData.autoLocale = false;<br />
		 * objData.width = 400;</code>.<br />
		 */
		public function initialize( $data:TextDisplayData ):void
		{
			this.data =$data;
			if ( this.background != null ) {
				this.data.width = this.background.width;
				this.data.height = this.background.height;
			}
			this.createBaseElements();
			
			this.populate( this.data.text );
		}
		
		/**
		 * Populate
		 * 
		 * @param $text The string that will populate the TLF textfield
		 */
		public function populate( $text:String ):void
		{
			this._objSpanElement.text = $text;
			
			switch ( this.data.mode ) {
				case TextDisplayData.SINGLE_LINE :
					this.createSingleLine();
					break;
				case TextDisplayData.MULTI_LINE :
					this.createMultiline();
					break;
				case TextDisplayData.MULTI_SINGLE_LINE :
					this.createMultiline();
					break;
			}
		}
		/**
		 * Create Single Line
		 * 
		 * Creates a single line of text using the TLF.
		 */
		private function createSingleLine():void
		{
			this.removeSingleLines();
			
			var objFactory:TextFlowTextLineFactory  = new TextFlowTextLineFactory();
			objFactory.compositionBounds = new Rectangle( 0, 0, this.data.width, this.data.height );
			objFactory.createTextLines( this.addSingleLines, this._objTextFlow );
		}
		/**
		 * Add Single Lines
		 * 
		 * Adds a single line of text using the TLF.
		 * Based on the <code>mode</code> this function will either add a line to the exsiting <code>SINGLE_LINE</code> or add lines to a <code>MULTI_SINGLE_LINE</code>, which acts like a list.
		 */
		private function addSingleLines( $textLine:TextLine ):void
		{
			switch ( this.data.mode ) 
			{
				case TextDisplayData.SINGLE_LINE :
					if ( this._arrTextLines.length == 0 ) {
						this._arrTextLines.push( $textLine );
						this.addChild( $textLine );
					}
					break;
				case TextDisplayData.MULTI_SINGLE_LINE :
					this._arrTextLines.push( $textLine );
					this.addChild( $textLine );
					break;
			}
		}
		/**
		 * Remove Single Lines
		 * 
		 * Reomves all single lines from the <code>_arrTextLines</code>.
		 * 
		*/
		private function removeSingleLines():void
		{
			var numLength:int = this._arrTextLines.length;
			for( var i:int = 0; i < numLength; i ++ ) {
				this.removeChild( this._arrTextLines.pop() );
			}
		}
		/**
		 * Create Base Elementa
		 * 
		 * Creates a basic <code>TextLayoutFormat</code> object based on the <code>
		 */
		private function createBaseElements():void
		{
			var objFormat:TextLayoutFormat = this.createCustomFormat();
			
			this._objSpanElement = new SpanElement();
			this._objSpanElement.format = objFormat;
			
			this._objParagraphElement = new ParagraphElement;
			this._objParagraphElement.format = objFormat;
			this._objParagraphElement.addChild( this._objSpanElement );
			
			this._objTextFlow = new TextFlow();
			this._objTextFlow.format = objFormat;
			this._objTextFlow.addChildAt(0, this._objParagraphElement );
		}
		/*
		Paragraph
		*/
		private function createMultiline():void
		{
			if ( this._objTextFlow.flowComposer.numControllers == 0 ) {
				this._objTextFlow.flowComposer.addController( new ContainerController( this, this.data.width, this.data.height ) );
			}
			this._objTextFlow.flowComposer.updateAllControllers();
		}
		/*
		TextLayoutFormat
		*/
		private function createCustomFormat():TextLayoutFormat
		{
			if ( this.data.styleName != null ) {
				
				if ( this.data.autoStyle ) {
					var objStyle:Object = this.data.styleObject || BedrockEngine.cssManager.getStyleAsObject( this.data.styleName );
					var objFormat:TextLayoutFormat = new TextLayoutFormat();
					for (var s:String in objStyle) {
						objFormat[ s ] = VariableUtil.sanitize( objStyle[ s ] );
					}
				}
				
				if ( this.data.autoLocale ) objFormat.locale = BedrockEngine.config.getAvailableValue( BedrockData.CURRENT_LOCALE );
				objFormat.fontLookup = FontLookup.EMBEDDED_CFF;
				objFormat.renderingMode = RenderingMode.CFF;
				
				return objFormat;
			} else {
				return this.createDefaultFormat();
			}
		}
		private function createDefaultFormat():TextLayoutFormat
		{
			var objFormat:TextLayoutFormat = new TextLayoutFormat();
			
			objFormat.direction = Direction.LTR;
			objFormat.color = 0x333333;
			objFormat.fontSize = 12;
			objFormat.fontLookup = FontLookup.EMBEDDED_CFF;
			objFormat.renderingMode = RenderingMode.CFF;
			if ( this.data.autoLocale ) objFormat.locale = BedrockEngine.config.getAvailableValue( BedrockData.CURRENT_LOCALE );
			
			return objFormat;
		}
		/*
		Event Handlers
	 	*/
		/*
		Property Definitions
	 	*/
	}
}