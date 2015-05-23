package org.janschaedlich.test.request
{
    import flash.net.URLRequestMethod;
    
    import org.flexunit.asserts.assertEquals;
    import org.janschaedlich.oauth.request.OAuthRequest;
    
    public class OAuthRequestTest
    {
		public function OAuthRequestTest() 
		{
			
		}
		
        [Test]
        public function testConstruction():void
        {
			var request:OAuthRequest = new OAuthRequest(URLRequestMethod.GET, 'https://localhost/resource');
			
			assertEquals(URLRequestMethod.GET, request.requestMethod);
			assertEquals('https://localhost/resource', request.requestUrl);
        }
    }
}
