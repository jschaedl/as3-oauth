package org.janschaedlich.oauth.request
{
	import flash.net.URLRequestMethod;
	
	import org.janschaedlich.oauth.OAuthConsumer;
	import org.janschaedlich.oauth.OAuthToken;
	import org.janschaedlich.oauth.signature.ISignatureMethod;

	/**
	 * This class is a convenient helper class to build a URLRequest for 
	 * requesting Token Credentials from the server. 
	 * 
	 * According to section 2.3 Token Credentials in RFC 5849 this request 
	 * is a authenticated HTTP "POST" request to a Token Credential Request 
	 * endpoint of the server. Moreover this custom request adds the 
	 * REQUIRED "oauth_verifier" parameter to the other protocol parameters 
	 * of the OAuthRequest.
	 * 
	 * Example usage:
	 * 
	 * var request = new TokenCredentialsRequest();
	 * 		'https://localhost/request_token',
	 * 		new OAuthConsumer(key, secret), 
	 * 		token,		// temporary credentials identifier obtained in the previeous
	 * 					// Temporary Credential Request
	 * 		new SignatureMethodHMACSHA1()), 
	 * 		verifier	// oauth_verifier recieved within the 
	 * 					// Resource Owner Authorization Request
	 * );
	 * request.buildRequest();
	 * 
	 */
	public class TokenCredentialsRequest extends OAuthRequest
	{
		public function TokenCredentialsRequest(requestUrl:String, consumer:OAuthConsumer, 
			token:OAuthToken, signatureMethod:ISignatureMethod, verifier:String)
		{
			super(URLRequestMethod.POST, requestUrl);

			addConsumer(consumer);
			addToken(token);
			addSignatureMethod(signatureMethod);
			addVerifier(verifier);
		}
		
		protected function addVerifier(verifier:String):void
		{
			requestParams['oauth_verifier'] = verifier;
		}
	}
}