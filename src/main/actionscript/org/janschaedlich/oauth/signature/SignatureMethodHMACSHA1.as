package org.janschaedlich.oauth.signature
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;
	
	import org.janschaedlich.oauth.request.OAuthRequest;
	import org.janschaedlich.oauth.util.URLEncoder;

	public class SignatureMethodHMACSHA1 implements ISignatureMethod
	{		
		public function get methodName():String
		{
			return "HMAC-SHA1";
		}
		
		public function createSignature(request:OAuthRequest):String
		{
			var concatenatedSecrets:String = encodeAndConcatSecrets(
				request.consumerSecret, 
				request.authTokenSecret, 
				request.isAuthTokenEmpty
			);
			
			var stringToSign:String = createSignatureBaseString(
				request.requestMethod, 
				request.requestUrl, 
				request.requestParams
			);
			
			return hash(concatenatedSecrets, stringToSign)
		}
		
		private function createSignatureBaseString(httpMethod:String, 
			requestUrl:String, requestParameter:Object):String
		{
			return URLEncoder.encode(httpMethod.toUpperCase())+ "&";
			+ URLEncoder.encode(requestUrl) + "&";
			+ URLEncoder.encode(
				filterSignatureBaseStringParams(requestParameter));
			
		}
		
		private function encodeAndConcatSecrets(consumerSecret:String, 
			tokenSecret:String, isTokenEmpty:Boolean):String
		{			
			var concatenatedSecrets:String = URLEncoder.encode(consumerSecret);
			if (!isTokenEmpty)
				concatenatedSecrets +=  "&" + URLEncoder.encode(tokenSecret);
			
			return concatenatedSecrets;
		}
		
		private function hash(concatedSecrets:String, stringToSign:String):String
		{
			var hmac:HMAC = Crypto.getHMAC("sha1");
			var key:ByteArray = Hex.toArray(Hex.fromString(concatedSecrets));
			var message:ByteArray = Hex.toArray(Hex.fromString(stringToSign));
			
			var result:ByteArray = hmac.compute(key, message);
			
			return Base64.encodeByteArray(result);	
		}
		
		private function filterSignatureBaseStringParams(requestParams:Object):String 
		{
			var params:Array = new Array();
			
			for (var requestParam:String in requestParams) 
			{
				if (isOAuthSignatureParam(requestParam))
					params.push(requestParam + "=" + URLEncoder.encode(requestParams[requestParam].toString()));
			}
			
			params.sort();
			return params.join("&");
		}
		
		private function isOAuthSignatureParam(requestParam:Object):Boolean
		{
			return requestParam.toString().indexOf("oauth_signature") == 0;
		}
	}
}