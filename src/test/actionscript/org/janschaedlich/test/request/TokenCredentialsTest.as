package org.janschaedlich.test.request
{    
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.janschaedlich.oauth.OAuthConsumer;
	import org.janschaedlich.oauth.OAuthToken;
	import org.janschaedlich.oauth.request.TokenCredentialsRequest;
	import org.janschaedlich.oauth.signature.ISignatureMethod;
	import org.janschaedlich.oauth.signature.SignatureMethodPLAINTEXT;
	import org.janschaedlich.oauth.util.URLRequestUtil;

    public class TokenCredentialsTest
    {
		private var requestUrl:String = 'https://server.example.com/request_token';
		private var consumerKey:String = 'jd83jd92dhsh93js';
		private var consumerSecret:String = 'll399dj47dskfjdk';
		private var requestToken:String = 'j49ddk933skd9dks';
		private var requestTokenSecret:String = 'll399dj47dskfjdk';
		private var signatureMethod:ISignatureMethod = new SignatureMethodPLAINTEXT();
		private var verifier:String = '473f82d3';
		private var callback:String = 'oob';
		private var authorizationRealm:String = 'Example';
		private var request:TokenCredentialsRequest;
		
		public function TokenCredentialsTest() 
		{
			
		}
		
		[Before]
		public function setUp():void 
		{
			request = new TokenCredentialsRequest(requestUrl,
				new OAuthConsumer(consumerKey, consumerSecret),
				new OAuthToken(requestToken, requestTokenSecret),
				signatureMethod, verifier
			);
			
			request.addAuthorizationRealm(authorizationRealm);
		}
		
        [Test]
        public function testConstruction():void
        {
			assertEquals(URLRequestMethod.POST, request.requestMethod);
			assertEquals(requestUrl, request.requestUrl);
			assertEquals(authorizationRealm, request.authorizationRealm);
			assertEquals(consumerKey, request.consumerKey);
			assertEquals(consumerSecret, request.consumerSecret);
			assertFalse(request.isAuthTokenEmpty);
			assertEquals(requestToken, request.authToken);
			assertEquals(requestTokenSecret, request.authTokenSecret);
			assertEquals(signatureMethod.methodName, request.signatureMethodName);
			assertTrue(request.requestParams.hasOwnProperty('oauth_verifier'));
			assertEquals(verifier, request.requestParams['oauth_verifier']);
        }
		
		[Test]
		public function testBuildRequest():void
		{			
			var urlRequest:URLRequest = request.buildRequest();
			var authorizationRequestHeader:URLRequestHeader = URLRequestUtil.getAuthorizationRequestHeader(urlRequest);
			
			assertEquals(URLRequestMethod.POST, urlRequest.method);
			assertEquals(requestUrl, urlRequest.url);
			assertNotNull(authorizationRequestHeader);
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('realm', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_consumer_key', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_token', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_signature_method', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_verifier', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_signature', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_timestamp', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_nonce', authorizationRequestHeader));
			assertTrue(URLRequestUtil.authorizationRequestHeaderContainsParam('oauth_version', authorizationRequestHeader));
			
			// TODO test param contents
		}
    }
}
