package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.IContainerManager;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.engine.view.ContainerView;
	import com.bedrockframework.plugin.loader.VisualLoader;
	import com.bedrockframework.plugin.storage.HashMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import com.bedrockframework.engine.bedrock;

	public class ContainerManager extends StandardWidget implements IContainerManager
	{
		/*
		Variable Declarations
		*/
		private var _objRoot:DisplayObjectContainer;
		private var _mapContainers:HashMap;
		
		private var _objPageContainer:ContainerView;
		private var _objPreloaderContainer:ContainerView;
		/*
		Constructor
		*/
		public function ContainerManager()
		{
		}

		public function initialize($root:DisplayObjectContainer):void
		{
			this._mapContainers = new HashMap;
			this._objRoot=$root;
		}
		
		private function createPageContainer():void
		{
			this._objPageContainer = new ContainerView;
			this.replaceContainer(BedrockData.PAGE_CONTAINER, this._objPageContainer);
		}
		public function createPageLoader():void
		{
			this._objPageContainer.hold(new VisualLoader);
			BedrockEngine.bedrock::transitionManager.pageLoader = this._objPageContainer.child;
		}
		private function createPreloaderContainer():void
		{
			this._objPreloaderContainer = new ContainerView;
			this.replaceContainer(BedrockData.PRELOADER_CONTAINER, this._objPreloaderContainer);
		}
		
		public function createContainer($name:String,$child:DisplayObjectContainer=null,$properties:Object=null,$parent:DisplayObjectContainer=null,$depth:int=-1):*
		{
			if (!this.hasContainer($name)) {
				return this.tempContainer($name, $child, $properties, $parent, $depth);
			}
		}
		public function replaceContainer($name:String,$child:DisplayObjectContainer,$properties:Object=null,$parent:DisplayObjectContainer=null,$depth:int=-1):*
		{
			if (this.hasContainer($name)) {
				return this.tempContainer($name, $child, $properties, this.getContainerParent($name), $depth);
			}
		}
		private function tempContainer($name:String,$child:DisplayObjectContainer,$properties:Object=null,$parent:DisplayObjectContainer=null,$depth:int=-1):*
		{
			var numDepth:int=-1;
			if (this.hasContainer($name)) {
				numDepth=this.getDepth($name);
				this.removeContainer($name);
			}
			numDepth=($depth > -1) ? $depth : numDepth;
			
			var objChild:DisplayObjectContainer = $child || new VisualLoader;
		
			var numActualDepth:int=this.addContainer($parent || this._objRoot,objChild,numDepth);
			this.applyProperties(objChild,$properties);

			this.saveData($name,objChild,numActualDepth);
			return objChild;
		}
		/*
		Layout Related
		*/
		public function buildLayout($layout:Array):void
		{
			for (var i:int = 0; i < $layout.length; i++) {
				this.buildLayoutContainer($layout[i]);
			}
			this.createPageContainer();
			this.createPreloaderContainer();
		}
		private function buildLayoutContainer($data:Object):void
		{
			var objData:Object = $data;
			var strName:String =$data.name;
			var objView:DisplayObjectContainer;
			var arrSubContainers:Array = $data.containers || new Array;
			
			if (arrSubContainers.length == 0) {
				this.createContainer(objData.name, new VisualLoader, $data);
			} else {
				var objParent:Sprite = new Sprite
				this.createContainer(objData.name, objParent, $data);
				
				var objSubData:Object;
				var strSubName:String;
				var numLength:int = arrSubContainers.length;
				for (var i:int = 0 ; i < numLength; i++) {
					objSubData = $data.containers[i];
					this.createContainer(objSubData.name, new VisualLoader, objSubData, objParent);
				}
			}
			
		}
		/*
		Item Specific Stuff
		*/
		private function saveData($name:String, $parent:DisplayObjectContainer, $depth:uint):void
		{
			this._mapContainers.saveValue($name, new ContainerData($parent, $depth));
		}
		private function getData($name:String):ContainerData
		{
			return this._mapContainers.getValue($name);
		}
		private function removeData($name:String):void
		{
			this._mapContainers.removeValue($name);
		}
		/*
		Apply Property Object to container
		*/
		private function applyProperties($target:DisplayObjectContainer,$properties:Object=null):void
		{
			for (var i:String in $properties) {
				switch (i) {
					case "name" :
					case "containers" :
						break;
					default :
						$target[i]=$properties[i];
						break;
				}
			}
		}
		/*
		Depth Functions
		*/
		public function getDepth($name:String):int
		{
			var objData:ContainerData=this.getData($name);
			return objData.depth;
		}
		private function getActualDepth($name:String):int
		{
			var objChild:* =this.getContainer($name);
			var objParent:* =this.getContainerParent($name);
			return objParent.getChildIndex(objChild);
		}
		/*
		Container Functions
		*/
		private function addContainer($container:DisplayObjectContainer,$child:DisplayObjectContainer,$depth:int=-1):int
		{
			try {
				$container.addChildAt($child,$depth);
			} catch ($error:Error) {
				$container.addChild($child);
			}
			return $container.getChildIndex($child);
		}
		public function getContainer($name:String):*
		{
			var objData:ContainerData=this.getData($name);
			return objData ? objData.container : null;
		}
		public function getContainerParent($name:String):*
		{
			var objContainer:* = this.getContainer($name);
			return objContainer ? objContainer.parent : null;
		}
		public function removeContainer($name:String):void
		{
			var objChild:* =this.getContainer($name);
			var objParent:* =this.getContainerParent($name);
			if (objChild && objParent) {
				objParent.removeChild(objChild);
			}
		}
		public function hasContainer($name:String):Boolean
		{
			return this._mapContainers.containsKey($name);
		}
		/*
		Swapping Functions
		*/
		public function swapChildren($name1:String,$name2:String):void
		{
			var objChild1:* =this.getContainer($name1);
			var objChild2:* =this.getContainer($name2);
			if ( objChild1.parent === objChild2.parent ) {
				objChild1.parent.swapChildren(objChild1,objChild2);
			} else {
				this.error("Parent containers do not match!");
			}
		}
		public function swapTo($name:String,$depth:Number):void
		{
			var objChild:* =this.getContainer($name);
			var objParent:* =this.getContainerParent($name);
			try {
				objParent.setChildIndex(objChild,$depth);
			} catch ($e:RangeError) {
				this.error($e.message + " Swap failed!");
			}
		}
		public function swapToTop($name:String,$offset:Number=0):void
		{
			var objParent:* =this.getContainerParent($name);
			this.swapTo($name, (objParent.numChildren - 1) + $offset);
		}
		public function swapToBottom($name:String,$offset:Number=0):void
		{
			this.swapTo($name, 0 + $offset);
		}
		
		public function get root():DisplayObjectContainer
		{
			return this._objRoot;
		}
		
		public function get pageContainer():ContainerView
		{
			return this._objPageContainer;
		}
		public function get preloaderContainer():ContainerView
		{
			return this._objPreloaderContainer;
		}
	}
}

import flash.display.DisplayObjectContainer;	
class ContainerData 
{
	public var container:DisplayObjectContainer;
	public var depth:uint;
	
	public function ContainerData($parent:DisplayObjectContainer, $depth:uint)
	{
		this.container = $parent;
		this.depth = $depth;
	}
}