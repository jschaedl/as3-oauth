package org.janschaedlich.oauth.signature
{
	import org.janschaedlich.oauth.request.OAuthRequest;

	public interface ISignatureMethod
	{
		function get methodName():String;
		
		function createSignature(request:org.janschaedlich.oauth.request.OAuthRequest):String;
	}
}