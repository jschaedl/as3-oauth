package org.janschaedlich.oauth.request
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.janschaedlich.oauth.OAuthToken;

	/**
	 * This class is a convenient helper class to build a URLRequest for 
	 * requesting Resource Owner Authorization from the server. 
	 * 
	 * According to section 2.2 Resource Owner Authorization in RFC 5849 this 
	 * request is a HTTP redirection request using HTTP "GET" to a 
	 * Resource Owner Authorization endpoint of the server.
	 * 
	 * Example usage:
	 * 
	 * var request = new ResourceOwnerAuthorizationRequest(
	 * 		'https://localhost/authorize_access', // requestUrl
	 * 		token,	// temporary credentials identifier obtained in the previeous
	 * 				// Temporary Credential Request
	 * );
	 * request.buildRequest();
	 * 
	 */
	public class ResourceOwnerAuthorizationRequest extends OAuthRequest
	{
		public function ResourceOwnerAuthorizationRequest(requestUrl:String, token:OAuthToken)
		{			
			super(URLRequestMethod.GET, requestUrl);

			addToken(token);
		}
		
		override public function buildRequest():URLRequest
		{
			var variables:URLVariables = new URLVariables();
			variables.oauth_token = authToken;
			
			var request:URLRequest = new URLRequest();
			request.method = requestMethod;
			request.url = requestUrl;
			request.data = variables;
			
			return request;
		}
	}
}