package com.bedrockframework.engine.controller
{
	import com.bedrockframework.core.base.StandardWidget;
	import com.bedrockframework.core.controller.FrontController;
	import com.bedrockframework.core.controller.IFrontController;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.bedrock;
	import com.bedrockframework.engine.command.HideBlockerCommand;
	import com.bedrockframework.engine.command.ShowBlockerCommand;
	import com.bedrockframework.engine.data.BedrockData;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.engine.model.State;
	
	public class EngineController extends FrontController
	{
		/*
		Variable Declarations
		*/
		/*
		Constructor
		*/
		public function EngineController()
		{
		}
		
		override public function initialize():void
		{
			super.initialize();
			this.createListeners();
			this.createCommands();
		}
		/*
		Creation Functions
		*/
		private function createListeners():void
		{
			BedrockDispatcher.addEventListener(BedrockEvent.SET_QUEUE, this.onSetQueue);
			BedrockDispatcher.addEventListener(BedrockEvent.LOAD_QUEUE, this.onLoadQueue);
			BedrockDispatcher.addEventListener(BedrockEvent.DO_DEFAULT, this.onDoDefault);
			BedrockDispatcher.addEventListener(BedrockEvent.DO_CHANGE, this.onDoChange);
			
			BedrockDispatcher.addEventListener(BedrockEvent.RENDER_PRELOADER, this.onRenderPreloader);
			BedrockDispatcher.addEventListener(BedrockEvent.RENDER_SITE, this.onRenderSite);
			
			BedrockDispatcher.addEventListener(BedrockEvent.SET_QUEUE, this.onStateChange);
			BedrockDispatcher.addEventListener(BedrockEvent.PAGE_INITIALIZE_COMPLETE, this.onStateChange);
			BedrockDispatcher.addEventListener(BedrockEvent.SITE_INTRO_COMPLETE, this.onUpdateDeeplinkPath );
			BedrockDispatcher.addEventListener(BedrockEvent.PAGE_OUTRO_COMPLETE, this.onUpdateDeeplinkPath );
			
			BedrockDispatcher.addEventListener(BedrockEvent.URL_CHANGE, this.onURLChange );
			
			BedrockDispatcher.addEventListener(BedrockEvent.LOCALE_CHANGE, this.onLocaleChange );
			
			if (BedrockEngine.config.getSettingValue( BedrockData.AUTO_INTRO_ENABLED ) ){
				BedrockDispatcher.addEventListener( BedrockEvent.BEDROCK_COMPLETE, this.onRenderSite );
			}
		}
		private function createCommands():void
		{
			this.addCommand(BedrockEvent.SHOW_BLOCKER, ShowBlockerCommand);
			this.addCommand(BedrockEvent.HIDE_BLOCKER, HideBlockerCommand);
			
			if ( BedrockEngine.config.getSettingValue(BedrockData.AUTO_BLOCKER_ENABLED) ) {
				this.addCommand(BedrockEvent.SET_QUEUE, ShowBlockerCommand);
				this.addCommand(BedrockEvent.SITE_INTRO_COMPLETE, HideBlockerCommand);
				this.addCommand(BedrockEvent.PAGE_INTRO_COMPLETE, HideBlockerCommand);
			}
		}
		/*
		Queue Event Handlers
	 	*/
		private function onSetQueue($event:BedrockEvent):void
		{
			BedrockEngine.bedrock::pageManager.setQueue(BedrockEngine.config.getPage($event.details.alias));
		}
		private function onLoadQueue($event:BedrockEvent):void
		{
			var objPage:Object=BedrockEngine.bedrock::pageManager.loadQueue();
			if (objPage) {
				BedrockEngine.bedrock::pageManager.setupPageLoad(objPage);
			}
			BedrockEngine.loadManager.loadQueue();
		}
		/*
		Change Event Handlers
	 	*/
		private function onDoDefault($event:BedrockEvent):void
		{
			if ( !BedrockEngine.config.getSettingValue( BedrockData.AUTO_DEFAULT_ENABLED ) ) {
				if ( !BedrockEngine.bedrock::state.doneDefault ) {
					var strDefaultAlias:String = BedrockEngine.bedrock::pageManager.getDefaultPage($event.details);
					this.status("Transitioning to - " + strDefaultAlias);
					BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.SET_QUEUE, this, { alias:strDefaultAlias } ) );
					BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.RENDER_PRELOADER, this ) );
					BedrockEngine.bedrock::state.doneDefault = true;
					BedrockEngine.deeplinkManager.setPath( strDefaultAlias );
				}
			} else {
				BedrockEngine.bedrock::state.doneDefault = true;
			}
		}
		private function onDoChange($event:BedrockEvent):void
		{
			if ( BedrockEngine.bedrock::state.current == State.AVAILABLE ) {
				var strAlias:String = $event.details.alias;
				if (BedrockEngine.config.getPage(strAlias)){
					if (BedrockEngine.history.current == null || BedrockEngine.history.current.alias != strAlias) {
						this.status("Transitioning to - " + strAlias);
						BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.SET_QUEUE,this,{alias:strAlias}));
						BedrockEngine.bedrock::transitionManager.pageView.outro();
					} else {
						this.warning("Page '" + strAlias + "' is currently loaded!");
					}
				}
			}
		}
		/*
		Render Event Handlers
	 	*/
	 	private function onRenderPreloader($event:BedrockEvent):void
		{
			var objPreloader:*;
			if ( BedrockEngine.config.getSettingValue( BedrockData.SHARED_ENABLED ) ) {
				if (BedrockEngine.assetManager.hasPreloader( BedrockEngine.bedrock::pageManager.queue.alias )) {
					objPreloader = BedrockEngine.assetManager.getPreloader( BedrockEngine.bedrock::pageManager.queue.alias );
				} else {
					objPreloader = BedrockEngine.assetManager.getPreloader( BedrockData.DEFAULT_PRELOADER );
				}
			} else {
				objPreloader = BedrockEngine.assetManager.getPreloader( BedrockData.SHELL_PRELOADER );
			}
			BedrockEngine.containerManager.preloaderContainer.hold( objPreloader );
			BedrockEngine.bedrock::transitionManager.preloaderView = objPreloader;
		}
		private function onRenderSite($event:BedrockEvent):void
		{
			if ( !BedrockEngine.bedrock::state.siteRendered ) {
				var objPreloader:*  = new ShellPreloader;
				BedrockEngine.containerManager.preloaderContainer.hold( objPreloader );
				BedrockEngine.bedrock::transitionManager.preloaderView = objPreloader;
				BedrockEngine.bedrock::state.siteRendered = true;
			}
		}
		/*
		State Event Handlers
		*/
		private function onStateChange($event:BedrockEvent):void
		{
			switch ($event.type) {
				case BedrockEvent.SET_QUEUE :
					BedrockEngine.bedrock::state.change( State.UNAVAILABLE );
					break;
				case BedrockEvent.PAGE_INITIALIZE_COMPLETE :
					BedrockEngine.bedrock::state.change( State.AVAILABLE );
					break;
			}
		}
		/*
		URL Event Handler
		*/
		private function onURLChange($event:BedrockEvent):void
		{
			var strPath:String = $event.details.paths[0];
			if ( strPath != null && strPath != "" ) {
				BedrockDispatcher.dispatchEvent(new BedrockEvent(BedrockEvent.DO_CHANGE, this, { alias:strPath } ));
			}
		}
		/*
		URL Event Handler
		*/
		private function onLocaleChange($event:BedrockEvent):void
		{
			if ( BedrockEngine.config.getSettingValue( BedrockData.LOCALE_ENABLED ) ) {
				BedrockEngine.localeManager.load( $event.details.locale );
			}
		}
		
		private function onUpdateDeeplinkPath( $event:BedrockEvent ):void
		{
			if ( BedrockEngine.config.getSettingValue( BedrockData.DEEP_LINKING_ENABLED ) ) {
				BedrockEngine.deeplinkManager.setPath( BedrockEngine.history.current.alias );
			}
		}
	}
}