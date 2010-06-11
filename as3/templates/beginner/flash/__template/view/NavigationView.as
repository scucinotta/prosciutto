package __template.view
{
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.engine.event.BedrockEvent;
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.gadget.Cloner;
	import com.bedrockframework.plugin.util.ButtonUtil;
	import com.bedrockframework.plugin.view.IView;
	import com.bedrockframework.plugin.view.MovieClipView;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class NavigationView extends MovieClipView implements IView
	{
		/*
		Variable Declarations
		*/
		public var cloner:Cloner;
		private var _arrPages:Array;
		/*
		Constructor
		*/
		
		public function NavigationView()
		{
			this.alpha = 0;
		}
		
		public function initialize($properties:Object=null):void
		{
			this._arrPages = BedrockEngine.config.getPages();
			this.createCloner();
			this.createClones( this._arrPages.length );
			this.initializeComplete();
		}
		public function intro($properties:Object=null):void
		{
			TweenLite.to(this, 1, { alpha:1, onComplete:this.introComplete } );
		}
		public function outro($properties:Object=null):void
		{
			
		}
		public function clear():void
		{
			
		}
		/*
		Creation Functions
		*/
		private function createCloner():void
		{
			this.cloner = new Cloner;
			this.cloner.addEventListener( ClonerEvent.CREATE, this.onCreateClone );
			this.cloner.x = 10;
			this.cloner.y = 10;
			this.addChild( this.cloner );
		}
		private function createClones( $total:uint ):void
		{
			var objData:ClonerData = new ClonerData;
			objData.clone = NavigationButton;
			objData.total = $total;
			objData.direction = ClonerData.HORIZONTAL;
			objData.pattern = ClonerData.LINEAR;
			objData.autoSpacing = true;
			objData.paddingX = 10;
			
			this.cloner.initialize( objData );
		}
		/*
		Event Handlers
	 	*/
		private function onCreateClone( $event:ClonerEvent ):void
		{
			var objData:Object = this._arrPages[ $event.details.index ];
			var objChild:MovieClip = $event.details.child;
			objChild.alias = objData.alias;
			objChild.label.text = objData.label;
			ButtonUtil.addListeners( objChild, { down:this.onNavigationItemDown } );
		}
		private function onNavigationItemDown($event:MouseEvent):void
		{
			BedrockDispatcher.dispatchEvent( new BedrockEvent( BedrockEvent.DO_CHANGE, this, { alias:$event.target.alias } ) );
		}
		/*
		Property Definitions
	 	*/
	}
}