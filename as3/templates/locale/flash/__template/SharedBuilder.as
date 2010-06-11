package __template
{
	import com.bedrockframework.engine.AssetBuilder;
	import com.bedrockframework.engine.api.IAssetBuilder;
	import com.bedrockframework.engine.data.BedrockData;

	public class SharedBuilder extends AssetBuilder implements IAssetBuilder
	{
		public function SharedBuilder()
		{
			super();
		}
		public function initialize():void
		{
			this.addPreloader( BedrockData.DEFAULT_PRELOADER, "DefaultPreloader" );
			//this.addPreloader("sub_page", SubPagePreloader);
		}
	}
}