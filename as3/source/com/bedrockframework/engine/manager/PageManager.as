package com.bedrockframework.engine.manager
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.api.IPageManager;
	import com.bedrockframework.engine.data.BedrockData;

	public class PageManager extends StandardWidget implements IPageManager
	{
		/*
		Variable Declarations
		*/
		private var _objQueue:Object;
		private var _objCurrent:Object;
		private var _objPrevious:Object;
		/*
		Constructor
		*/
		public function PageManager()
		{
		}
		
		public function initialize($autoDefault:Boolean = true):void
		{
			if ($autoDefault) {
				var strAlias:String = this.getDefaultPage();
				var objPage:Object = BedrockEngine.config.getPage(strAlias);
				this.setupPageLoad(objPage);
				this.setQueue(objPage);
				this.loadQueue();
			}
		}
		/*
		*/
		
		public function setupPageLoad($page:Object):void
		{
			var objPage:Object = $page;
			if (objPage.files != null) {
				var numLength:Number=objPage.files.length;
				for (var i:Number=0; i < numLength; i++) {
					BedrockEngine.loadManager.addToQueue(objPage.files[i]);
				}
			} else {
				this.status("No additional files to load!");
			}
			var strPath:String;
			if (objPage.url != null) {
				strPath = objPage.url;
			} else {
				strPath = BedrockEngine.config.getEnvironmentValue(BedrockData.SWF_PATH) + objPage.alias + ".swf";
			}
			BedrockEngine.containerManager.createPageLoader();
			BedrockEngine.loadManager.addToQueue(strPath, BedrockEngine.containerManager.pageContainer.child, BedrockData.PAGE_PRIORITY);
		}
		
		
		public function getDefaultPage($details:Object = null):String
		{
			var strDefaultAlias:String;
			try {
				strDefaultAlias=$details.alias;
				this.status("Pulling from Event - " + strDefaultAlias);
			} catch ($e:Error) {
				if (BedrockEngine.config.getSettingValue( BedrockData.DEEP_LINKING_ENABLED ) ){
					strDefaultAlias = BedrockEngine.deeplinkManager.getPathHierarchy()[0];
					this.status("Pulling from URL - " + strDefaultAlias);
				}
			} finally {
				if (strDefaultAlias == null || strDefaultAlias == "" ) {
					if (BedrockEngine.config.getParamValue( BedrockData.DEFAULT_PAGE) != null ) {
						strDefaultAlias = BedrockEngine.config.getParamValue(BedrockData.DEFAULT_PAGE);
						this.status("Pulling from Params - " + strDefaultAlias);
					} else {
						strDefaultAlias = BedrockEngine.config.getEnvironmentValue(BedrockData.DEFAULT_PAGE) || BedrockEngine.config.getSettingValue(BedrockData.DEFAULT_PAGE);
						this.status("Pulling from Config - " + strDefaultAlias);
					}
				}
							
			}
			return strDefaultAlias;
		}
		
		/*
		Set Queue
		*/
		public function setQueue($page:Object):Boolean
		{
			var bolFirstRun:Boolean = (this._objCurrent == null);
			var objPage:Object = $page;
			if (objPage != null) {
				if (objPage != this._objCurrent) {
					this._objQueue = objPage;
					BedrockEngine.history.addHistoryItem(objPage);
				} else {
					this.warning("Page already in queue!");
				}
			}
			return bolFirstRun;
		}
		/*
		Load Queue
		*/
		public function loadQueue():Object
		{
			var objData:Object = this._objQueue;
			this._objPrevious = this._objCurrent;
			this._objCurrent = this._objQueue;
			this._objQueue = null;
			return objData;
		}
		/*
		Clear Queue
		*/
		public function clearQueue():void
		{
			this._objCurrent=null;
			this._objPrevious=null;
		}
		/*
		Get Queued Page
		*/
		public function get queue():Object
		{
			return this._objQueue;
		}
		/*
		Get Current Page
		*/
		public function get current():Object
		{
			return this._objCurrent;
		}
		/*
		Get Previous Page
		*/
		public function get previous():Object
		{
			return this._objPrevious;
		}
		
	}
}