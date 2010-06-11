package __template.command
{
	import __template.event.SiteEvent;
	import com.bedrockframework.core.command.*;
	import com.bedrockframework.core.dispatcher.BedrockDispatcher;
	import com.bedrockframework.core.event.GenericEvent;

	public class DataRequestCommand extends Command implements ICommand
	{
		public function DataRequestCommand()
		{
		}
		public function execute($event:GenericEvent):void
		{
			this.status("Pull data from model...");
			trace($event.type);
			trace($event.origin);
			trace($event.details.form);
			var strData:String="Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...";
			BedrockDispatcher.dispatchEvent(new SiteEvent(SiteEvent.DATA_RESPONSE,this,{data:strData}));
		}
	}

}