package org.janschaedlich.test.request
{
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    
    import org.flexunit.Assert;
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;
    import org.janschaedlich.oauth.OAuthToken;
    import org.janschaedlich.oauth.request.OAuthRequest;
    import org.janschaedlich.oauth.request.ResourceOwnerAuthorizationRequest;
    
    public class ResourceOwnerAuthorizationRequestTest
    {
		private var requestUrl:String = 'https://server.example.com/authorize_access';
		private var requestToken:String = 'j49ddk933skd9dks';
		private var requestTokenSecret:String = 'll399dj47dskfjdk';
		private var request:ResourceOwnerAuthorizationRequest;
		
		public function ResourceOwnerAuthorizationRequestTest() 
		{
			
		}
		
		[Before]
		public function setUp():void 
		{
			request = new ResourceOwnerAuthorizationRequest(requestUrl,	
				new OAuthToken(requestToken, requestTokenSecret)
			);
		}
		
        [Test]
        public function testConstruction():void
        {
			assertEquals(URLRequestMethod.GET, request.requestMethod);
			assertEquals(requestUrl, request.requestUrl);
			assertFalse(request.isAuthTokenEmpty);
        }
		
		[Test]
		public function testBuildRequest():void
		{			
			var urlRequest:URLRequest = request.buildRequest();
			
			assertEquals(URLRequestMethod.GET, urlRequest.method);
			assertEquals(requestUrl, urlRequest.url);
			assertTrue(urlRequest.data.hasOwnProperty('oauth_token'));
			assertEquals(requestToken, urlRequest.data.oauth_token);
		}
    }
}
