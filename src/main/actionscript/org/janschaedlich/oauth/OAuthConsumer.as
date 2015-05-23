package org.janschaedlich.oauth
{
	/**
	 * This class represents the client credentials and consists of 
	 * Consumer Key and Consumer Secret which are usually provded 
	 * by a Service Provider.
	 */
	public class OAuthConsumer
	{
		private var _key:String;
		private var _secret:String;
		
		public function OAuthConsumer(key:String, secret:String)
		{
			_key = key;
			_secret = secret;
		}

		public function get key():String
		{
			return _key;
		}

		public function get secret():String
		{
			return _secret;
		}

		public function get isEmpty():Boolean 
		{
			return (key.length == 0 || secret.length == 0);
		}
	}
}