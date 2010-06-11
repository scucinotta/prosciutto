package
{
	import com.bedrockframework.core.base.MovieClipWidget;
	import com.bedrockframework.plugin.data.ClonerData;
	import com.bedrockframework.plugin.event.ClonerEvent;
	import com.bedrockframework.plugin.event.PaginationEvent;
	import com.bedrockframework.plugin.util.ButtonUtil;
	import com.greensock.easing.Back;
	import com.bedrockframework.plugin.data.SliderNavigationData;
	import com.bedrockframework.plugin.navigation.SliderNavigation;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class TestDocument extends MovieClipWidget
	{
		public var sliderNavigation:SliderNavigation;
		public var nextArrow:MovieClip;
		public var previousArrow:MovieClip;
		public var pageButton:MovieClip;
		
		public function TestDocument()
		{
			ButtonUtil.addListeners( this.nextArrow, { down:this.onNext } );
			ButtonUtil.addListeners( this.previousArrow, { down:this.onPrevious } );
			ButtonUtil.addListeners( this.pageButton, { down:this.onPageChange } );
			this.initializeSliderNavigation();
		}
		public function initializeSliderNavigation():void
		{
			var objData:SliderNavigationData = new SliderNavigationData;
			objData.total = 11;
			objData.spaceX = 150;
			objData.spaceY = 150;
			objData.paddingX = 10;
			objData.paddingY = 10;
			objData.direction = ClonerData.HORIZONTAL;
			objData.pattern = ClonerData.LINEAR;
			objData.clone = TestMovie;
			
			objData.time = 0.5;
			objData.ease = Back.easeOut;
			objData.alwaysShowMaxItems = true;
			//objData.width = ( objData.spaceX * 2 ) + ( objData.paddingX * 1 );
			objData.visibleItems = 3;
			objData.width = 150;
			objData.height = 150;
			
			this.sliderNavigation.addEventListener( PaginationEvent.SELECT_PAGE, this.onSelectPage );
			this.sliderNavigation.addEventListener( ClonerEvent.CREATE, this.onCloneCreate );
			this.sliderNavigation.initialize( objData );
		}
		private function onNext( $event:MouseEvent ):void
		{
			this.sliderNavigation.nextPage();
		}
		private function onPrevious( $event:MouseEvent ):void
		{
			this.sliderNavigation.previousPage();
		}
		private function onPageChange( $event:MouseEvent ):void
		{
			this.sliderNavigation.selectPage( 3 );
		}
		private function onSelectPage( $event:PaginationEvent ):void
		{
			this.nextArrow.visible = this.sliderNavigation.hasNextPage();
			this.previousArrow.visible = this.sliderNavigation.hasPreviousPage();
		}
		private function onCloneCreate( $event:ClonerEvent ):void
		{
			debug( $event.details );
		}
	}
}