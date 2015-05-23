package org.janschaedlich.oauth
{
	public class OAuthToken
	{
		private var _token:String;
		private var _secret:String;
		
		public function OAuthToken(token:String, secret:String)
		{
			_token = token;
			_secret = secret;
		}

		public function get token():String
		{
			return _token;
		}

		public function get secret():String
		{
			return _secret;
		}

		public function get isEmpty():Boolean 
		{
			return (token.length == 0 || secret.length == 0);
		}
	}
}