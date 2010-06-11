package
{
	
	import com.bedrockframework.plugin.event.LoaderEvent;
	import com.bedrockframework.plugin.event.ViewEvent;
	import com.bedrockframework.plugin.view.VisualLoaderView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TestDocument extends MovieClip
	{
		/*
		Variable Declarations
		*/
		private var _objVisualLoaderView:VisualLoaderView;
		
		/*
		Constructor
		*/
		public function TestDocument()
		{
			this.loaderInfo.addEventListener( Event.INIT, this.onBootUp );
		}
		/*
		Basic view functions
	 	*/
		public function initialize():void
		{
			this._objVisualLoaderView = new VisualLoaderView();
			this.addChild(this._objVisualLoaderView);
			
			this._objVisualLoaderView.addEventListener( LoaderEvent.INIT, this.onLoadInit );
			this._objVisualLoaderView.addEventListener( ViewEvent.INITIALIZE_COMPLETE, this.onInitializeComplete );
			
			this._objVisualLoaderView.loadURL( "view.swf" );
		}
		
		/*
		Event Handlers
		*/
		final private function onBootUp($event:Event):void
		{
			this.initialize();
		}
		
		private function onLoadInit( $event:LoaderEvent ):void
		{
			this._objVisualLoaderView.initialize();
		}
		private function onInitializeComplete( $event:ViewEvent ):void
		{
			this._objVisualLoaderView.intro();
		}
	}
}