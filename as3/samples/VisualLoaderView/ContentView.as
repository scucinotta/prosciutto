
package
{
	import com.bedrockframework.plugin.view.IView;
	import com.bedrockframework.plugin.view.MovieClipView;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;

	public class ContentView extends MovieClipView implements IView
	{
		/*
		Variable Delcarations
		*/
		public var content:MovieClip;
		/*
		Constructor
		*/
		public function ContentView()
		{
			this.content.alpha = 0;
		}
		
		public function initialize( $data:Object=null ):void
		{
			this.initializeComplete();
		}
		
		public function intro( $data:Object=null ):void
		{
			TweenLite.to( this.content, 1, { alpha:1, onComplete:this.introComplete } );
		}
		
		public function outro( $data:Object=null ):void
		{
			TweenLite.to( this.content, 1, { alpha:0, onComplete:this.outroComplete } );
		}
		
		public function clear():void
		{
		}
		/*
		Creation Functions
		*/
		
		/*
		Event Handlers
		*/
		
		/*
		Property Definitions
		*/
		
	}
}