package org.janschaedlich.test
{   
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.janschaedlich.oauth.OAuthConsumer;

    public class OAuthConsumerTest
    {
		[Test]
		public function testConstruction():void
		{
			var oauthConsumer:OAuthConsumer = new OAuthConsumer("jd83jd92dhsh93js", "ll399dj47dskfjdk");
			assertEquals("jd83jd92dhsh93js", oauthConsumer.key);
			assertEquals("ll399dj47dskfjdk", oauthConsumer.secret);
		}
		
		[Test]
		public function testTokenIsEmpty():void
		{
			assertTrue(new OAuthConsumer("jd83jd92dhsh93js", "").isEmpty);
			assertTrue(new OAuthConsumer("", "ll399dj47dskfjdk").isEmpty);
			assertTrue(new OAuthConsumer("", "").isEmpty);
		}
    }
}
