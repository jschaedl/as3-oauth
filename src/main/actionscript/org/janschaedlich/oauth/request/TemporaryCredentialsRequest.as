package org.janschaedlich.oauth.request
{
	import flash.net.URLRequestMethod;
	
	import org.janschaedlich.oauth.OAuthConsumer;
	import org.janschaedlich.oauth.signature.ISignatureMethod;

	/**
	 * This class is a convenient helper class to build a URLRequest for 
	 * requesting Temporary Credentials from the server. 
	 * 
	 * According to section 2.1 Temporary Credentials in RFC 5849 this request 
	 * is a authenticated HTTP "POST" request to a Temporary Credential Request 
	 * endpoint of the server. Moreover this custom request adds the 
	 * REQUIRED "oauth_callback" parameter to the other protocol parameters 
	 * of the OAuthRequest.
	 * 
	 * Example usage:
	 * 
	 * var request = new TemporaryCredentialsRequest(
	 * 		'https://localhost/request_credientials', 	// requestUrl
	 * 		new OAuthConsumer(key, secret), 			// consumer
	 * 		new SignatureMethodHMACSHA1(),				// signatureMethod
	 * 		'oob'										// callback | optional
	 * );
	 * request.buildRequest();
	 * 
	 */
	public class TemporaryCredentialsRequest extends OAuthRequest
	{
		public function TemporaryCredentialsRequest(requestUrl:String, consumer:OAuthConsumer, 
			signatureMethod:ISignatureMethod, callback:String = 'oob')
		{
			super(URLRequestMethod.POST, requestUrl);
			
			addConsumer(consumer);
			addSignatureMethod(signatureMethod);
			addCallback(callback);
		}
		
		protected function addCallback(callbackMethod:String):void
		{
			requestParams['oauth_callback'] = callbackMethod;
		}
	}
}