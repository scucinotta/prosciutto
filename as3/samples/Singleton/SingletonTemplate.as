package 
{
	import com.bedrockframework.core.base.StandardWidget;

	public class SingletonTemplate extends StandardWidget
	{
		/*
		Variable Declarations
		*/
		private static var __objInstance:SingletonTemplate;
		/*
		Constructor
		*/
		public function SingletonTemplate($enforcer:SingletonEnforcer)
		{
		
		}
		public static function getInstance():SingletonTemplate
		{
			if (SingletonTemplate.__objInstance == null) {
				SingletonTemplate.__objInstance = new SingletonTemplate(new SingletonEnforcer());
			}
			return SingletonTemplate.__objInstance;
		}
	}
}
/*
This private class is only accessible by the public class.
The public class will use this as a 'key' to control instantiation.   
*/
class SingletonEnforcer {}