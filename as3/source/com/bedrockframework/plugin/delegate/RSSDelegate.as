package com.bedrockframework.plugin.delegate
{
	import com.adobe.utils.XMLUtil;
	import com.adobe.xml.syndication.atom.Atom10;
	import com.adobe.xml.syndication.rss.RSS10;
	import com.adobe.xml.syndication.rss.RSS20;
	

	public class RSSDelegate extends Delegate implements IDelegate
	{
		public static const RSS1:String = "RSS1";
		public static const RSS2:String = "RSS2";
		public static const ATOM:String = "ATOM";
		
		public function RSSDelegate( $responder:IResponder )
		{
			super( $responder );
		}
		
		public function parse( $data:* ):void
		{
			var objData:Object = $data;
			if( XMLUtil.isValidXML( objData.data ) ) {
				objData.type = this.getFeedFormat( objData.data );
				switch( objData.type ) {
					case RSSDelegate.RSS1 :
						var rss10:RSS10 = new RSS10;
						rss10.parse( objData.data );
						objData.items = rss10.items;
						break;
					case RSSDelegate.RSS2 :
						var rss20:RSS20 = new RSS20;
						rss20.parse( objData.data );
						objData.items = rss20.items;
						break;
					case RSSDelegate.ATOM :
						var rssAtom:Atom10 = new Atom10;
						rssAtom.parse( objData.data );
						objData.items = rssAtom.entries;
						break;
				}
			} else {
				this.warning( "Feed does not contain valid XML." );
			}
			this.responder.result( objData );
		}
		
		
		private function getFeedFormat( $data:String ):String
		{
			var xmlData:XML = new XML( $data );
			if( xmlData.name() == "http://www.w3.org/1999/02/22-rdf-syntax-ns#::RDF" ) {
				return RSSDelegate.RSS1;
			} else if( xmlData.attributes() == "0.92" ) {
				return RSSDelegate.RSS1;
			} else if( xmlData.attributes() == "1" || xmlData.attributes() == "1.0" ) {
				return RSSDelegate.RSS1;
			} else if( xmlData.name() == "rss" && ( xmlData.attributes() == "2" || xmlData.attributes() == "2.0" ) ){
				return RSSDelegate.RSS2;
			}else if( xmlData.name() == "http://www.w3.org/2005/Atom::feed" ) {
				return RSSDelegate.ATOM;
			}else{
				return String( xmlData.attributes() ) + String( xmlData.name() );
			}
		}
		
	}
}