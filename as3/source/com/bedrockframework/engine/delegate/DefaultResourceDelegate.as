package com.bedrockframework.engine.delegate
{
	import com.bedrockframework.engine.BedrockEngine;
	import com.bedrockframework.plugin.delegate.Delegate;
	import com.bedrockframework.plugin.delegate.IDelegate;
	import com.bedrockframework.plugin.delegate.IResponder;
	import com.bedrockframework.plugin.storage.HashMap;
	import com.bedrockframework.plugin.util.XMLUtil;
	
	public class DefaultResourceDelegate extends Delegate implements IDelegate
	{
		public function DefaultResourceDelegate($responder:IResponder)
		{
			super($responder);
		}
		
		public function parse( $data:* ) :void
		{
			var xmlData:XML = new XML($data);
			this.responder.result( XMLUtil.convertToHashMap(xmlData) );
		}
	}
}