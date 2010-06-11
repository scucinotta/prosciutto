package 
{
	import com.bedrockframework.plugin.loader.VisualLoader;
	
	import flash.display.MovieClip;

	public class CopyClip extends MovieClip
	{
		private var objLoader:VisualLoader
		
		public function CopyClip()
		{
			trace(this, "Constructed");
			this.objLoader = new VisualLoader();
			this.addChild(this.objLoader);
		}
		public function initialize():void
		{
			this.objLoader.loadURL("pic1.jpg");
		}
		
	}
}