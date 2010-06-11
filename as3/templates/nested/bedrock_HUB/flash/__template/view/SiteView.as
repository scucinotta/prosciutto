package __template.view
{
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.engine.view.BedrockView;
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.gadget.Cloner;
	import com.bedrockframework.plugin.loader.ChainLoader;
	import com.bedrockframework.plugin.loader.MultiLoader;
	import com.bedrockframework.plugin.loader.VisualLoader;
	import com.bedrockframework.plugin.view.IView;
	import com.greensock.TweenLite;
	
	
	public class SiteView extends BedrockView implements IView
	{
		/*
		Variable Declarations
		*/
		private var _objCloner:Cloner;
		private var _arrPaths:Array;
		private var _objChainLoader:ChainLoader;
		/*
		Constructor
		*/
		public function HomepageView()
		{
			this.alpha=0;
		}
		public function initialize($properties:Object=null):void
		{
			this.createPaths();
			this.createChainLoader();
			this.createCloner();
			
			this.initializeComplete();
		}
		public function intro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:1, onComplete:this.introComplete});
			//this.introComplete();
		}
		public function outro($properties:Object=null):void
		{
			TweenLite.to(this, 1, {alpha:0, onComplete:this.outroComplete});
			//this.outroComplete();
		}
		public function clear():void
		{
		}
		/*
		Creation Functions
		*/
		private function createPaths():void
		{
			this._arrPaths = new Array;
			this._arrPaths.push( "../../../../bedrock_A/wwwroot/assets/swfs/shell.swf" );
			this._arrPaths.push( "../../../../bedrock_B/wwwroot/assets/swfs/shell.swf" );
			this._arrPaths.push( "../../../../bedrock_C/wwwroot/assets/swfs/shell.swf" );
			this.debug( this._arrPaths );
		}
		private function createCloner():void
		{
			var objData:ClonerData = new ClonerData;
			objData.direction = ClonerData.HORIZONTAL;
			objData.spaceX = 310;
			objData.total = this._arrPaths.length;
			objData.clone = VisualLoader;
			
			this._objCloner = new Cloner;
			this._objCloner.x = 10;
			this._objCloner.y = 10;
			this._objCloner.addEventListener( ClonerEvent.CREATE, this.onCloneCreate );
			this._objCloner.addEventListener( ClonerEvent.COMPLETE, this.onCloneComplete );
			this.addChild( this._objCloner );
			this._objCloner.initialize( objData );
		}
		private function createChainLoader():void
		{
			this._objChainLoader = new ChainLoader;
			this._objChainLoader.applicationDomainUsage = MultiLoader.NEW_DOMAIN;
		}
		/*
		Event Handlers
		*/
		private function onCloneCreate($event:ClonerEvent):void
		{
			var strPath:String = this._arrPaths[ $event.details.index ];
			var objLoader:VisualLoader = ( $event.details.child as VisualLoader );
			objLoader.addEventListener( LoaderEvent.INIT, this.onLoadComplete );
			this._objChainLoader.addToQueue( strPath,  objLoader);
		}
		private function onCloneComplete($event:ClonerEvent):void
		{
			this._objChainLoader.loadQueue();
		}
		
		
		private function onLoadComplete( $event:LoaderEvent ):void
		{
			trace(  $event.target.contentLoaderInfo );
			trace(  $event.target.contentLoaderInfo.applicationDomain );
			var clsBedrockDispatcher = $event.target.contentLoaderInfo.applicationDomain.getDefinition("com.bedrockframework.core.dispatcher.BedrockDispatcher") as Class;
			clsBedrockDispatcher.addEventListener( BedrockEvent.LOAD_COMPLETE, this.onBedrockLoadComplete );
			trace( clsBedrockDispatcher );
		}
		
		private function onBedrockLoadComplete( $event:* ):void
		{
			debug( $event.details );
		}
		
		
	}
}