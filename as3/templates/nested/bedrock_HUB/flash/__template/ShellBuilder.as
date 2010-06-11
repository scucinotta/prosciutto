package __template
{
	import com.bedrockframework.engine.BedrockBuilder;
	import com.bedrockframework.engine.api.IBedrockBuilder;
	
	
	public class ShellBuilder extends BedrockBuilder implements IBedrockBuilder
	{
		/*
		Variable Declarations
		*/
		/*
		Constructor
	 	*/
		public function ShellBuilder()
		{
			super();
		}
		public function loadModifications():void
		{
			this.status("Loading Modifications");
			this.next();
		}
		public function loadModels():void
		{
			this.status("Loading Models");
			this.next();
		}
		public function loadCommands():void
		{
			this.status("Loading Commands");
			this.next();
		}
		public function loadViews():void
		{
			this.status("Loading Views");
			this.next();
		}
		public function loadTracking():void
		{
			this.status("Loading Tracking");
			this.next();
		}
		public function loadCustomization():void
		{
			this.status("Loading Customization");
			this.next();
		}
	}
}