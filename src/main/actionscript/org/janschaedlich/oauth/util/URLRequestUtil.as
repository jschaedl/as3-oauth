package org.janschaedlich.oauth.util
{
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;

	public class URLRequestUtil
	{
		public function URLRequestUtil()
		{
		}
		
		public static function getAuthorizationRequestHeader(urlRequest:URLRequest):URLRequestHeader
		{
			return new URLRequestUtil().internal_getAuthorizationRequestHeader(urlRequest);
		}
		
		public static function authorizationRequestHeaderContainsParam(param:String, 
			authorizationRequestHeader:URLRequestHeader):Boolean
		{
			return new URLRequestUtil().internal_authorizationRequestHeaderContainsParam(param, authorizationRequestHeader);
		}
		
		public function internal_getAuthorizationRequestHeader(urlRequest:URLRequest):URLRequestHeader
		{
			var authorizationRequestHeader:URLRequestHeader = null;
			
			for each (var requestHeader:URLRequestHeader in urlRequest.requestHeaders) 
			{
				if (requestHeader.name == "Authorization")
				{
					authorizationRequestHeader = requestHeader;
					break;
				}
			}
			
			return authorizationRequestHeader;
		}
		
		public function internal_authorizationRequestHeaderContainsParam(param:String, 
			authorizationRequestHeader:URLRequestHeader):Boolean
		{
			return (authorizationRequestHeader.value.indexOf(param) != -1);
		}
	}
}