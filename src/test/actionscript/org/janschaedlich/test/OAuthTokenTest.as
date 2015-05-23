package org.janschaedlich.test
{   
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.janschaedlich.oauth.OAuthToken;

    public class OAuthTokenTest
    {
        [Test]
        public function testConstruction():void
        {
			var oauthToken:OAuthToken = new OAuthToken("j49ddk933skd9dks", "ll399dj47dskfjdk");
			assertEquals("j49ddk933skd9dks", oauthToken.token);
			assertEquals("ll399dj47dskfjdk", oauthToken.secret);
        }
		
		[Test]
		public function testTokenIsEmpty():void
		{
			assertTrue(new OAuthToken("j49ddk933skd9dks", "").isEmpty);
			assertTrue(new OAuthToken("", "ll399dj47dskfjdk").isEmpty);
			assertTrue(new OAuthToken("", "").isEmpty);
		}
    }
}
