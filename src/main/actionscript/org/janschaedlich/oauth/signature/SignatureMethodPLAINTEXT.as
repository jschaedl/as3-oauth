package org.janschaedlich.oauth.signature
{
	import org.janschaedlich.oauth.request.OAuthRequest;
	

	public class SignatureMethodPLAINTEXT implements ISignatureMethod
	{
		public function get methodName():String
		{
			return "PLAINTEXT";
		}
		
		public function createSignature(request:OAuthRequest):String
		{
			return concatSecrets(
				request.consumerSecret, 
				request.authTokenSecret, 
				request.isAuthTokenEmpty
			);
		}
		
		private function concatSecrets(consumerSecret:String, 
			tokenSecret:String, isTokenEmpty:Boolean):String
		{			
			var concatenatedSecrets:String = consumerSecret;
			if (!isTokenEmpty)
				concatenatedSecrets +=  "&" + tokenSecret;
			
			return concatenatedSecrets;
		}
	}
}