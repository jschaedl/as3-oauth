package org.janschaedlich.oauth.request
{
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	import mx.utils.UIDUtil;
	
	import org.janschaedlich.oauth.OAuthConsumer;
	import org.janschaedlich.oauth.OAuthToken;
	import org.janschaedlich.oauth.signature.ISignatureMethod;
	import org.janschaedlich.oauth.util.URLEncoding;

	public class OAuthRequest
	{
		private var _requestMethod:String;
		private var _requestUrl:String;

		private var _authorizationRealm:String = '';
		private var _consumer:OAuthConsumer;
		private var _token:OAuthToken;
		private var _signatureMethod:ISignatureMethod;
		private var _version:String = '1.0';
		//private var _timestamp:String;
		//private var _nonce:String;
		
		private var _requestParams:Object;
		
		public function OAuthRequest(requestMethod:String, requestUrl:String)
		{
			_requestMethod = requestMethod;
			_requestUrl = requestUrl;
			
			_requestParams = new Object();			
		}

		public function get requestMethod():String
		{
			return _requestMethod;
		}
		
		public function get requestUrl():String
		{
			return _requestUrl;
		}
		
		public function get requestParams():Object
		{
			return _requestParams;
		}
		
		public function get authorizationRealm():String
		{
			return _authorizationRealm;
		}

		public function get consumerKey():String
		{
			return (_consumer != null && !_consumer.isEmpty) ? 
				_consumer.key : '';
		}
		
		public function get consumerSecret():String
		{
			return (_consumer != null && !_consumer.isEmpty) ? 
				_consumer.secret : '';
		}
		
		public function get signatureMethodName():String
		{
			return _signatureMethod.methodName;
		}
		
		public function get isAuthTokenEmpty():Boolean
		{
			return (_token != null) ? _token.isEmpty : true;
		}
		
		public function get authToken():String
		{
			return (_token != null && !_token.isEmpty) ? 
				_token.token : '';
		}
		
		public function get authTokenSecret():String
		{
			return (_token != null && !_token.isEmpty) ? 
				_token.secret : '';
		}
		
		public function addAuthorizationRealm(authorizationRealm:String):void
		{
			_authorizationRealm = authorizationRealm;
		}
		
		public function buildRequest():URLRequest
		{
			// Todo: check if consumer and signatureMethod setted properly
			
			requestParams["oauth_consumer_key"] = consumerKey;
			requestParams["oauth_signature_method"] = signatureMethodName;
			
			requestParams["oauth_timestamp"] = (new Date()).time;
			requestParams["oauth_nonce"] = UIDUtil.getUID(new Date());
			requestParams["oauth_version"] = _version;

			(_token != null && !_token.isEmpty) ? 
				requestParams["oauth_token"] = _token.token : 
				deleteOAuthTokenOnRequestParams();

			requestParams["oauth_signature"] = _signatureMethod.createSignature(this);
			
			var request:URLRequest = new URLRequest();
			request.method = requestMethod;
			request.url = requestUrl;
			request.requestHeaders.push(createAuthorizationHeader(authorizationRealm));
			
			return request;
		}
		
		protected function addConsumer(consumer:OAuthConsumer):void
		{
			_consumer = consumer;
		} 
		
		protected function addToken(token:OAuthToken):void
		{
			_token = token;
		}
		
		protected function addSignatureMethod(signatureMethod:ISignatureMethod):void
		{
			_signatureMethod = signatureMethod;
		}
		
		private function deleteOAuthTokenOnRequestParams():void 
		{
			if (requestParams.hasOwnProperty("oauth_token"))
				delete(requestParams.oauth_token);
		}
		
		private function createAuthorizationHeader(authorizationRealm:String = ''):URLRequestHeader 
		{
			var authorizationHeaderData:String = 'OAuth ';
			
			if (authorizationRealm.length > 0)
				authorizationHeaderData += 'realm="' + authorizationHeaderData + '"';
			
			for (var requestParam:Object in requestParams) 
			{
				if (isOAuthParam(requestParam)) 
				{
					// Todo add comma after param and 
					authorizationHeaderData += ',' 
						+ requestParam + '="' + URLEncoding.encode(requestParams[requestParam]) + '"';
				}
			}
			
			return new URLRequestHeader("Authorization", authorizationHeaderData);
		}

		private function isOAuthParam(requestParam:Object):Boolean
		{
			return requestParam.toString().indexOf("oauth") == 0
		}
	}
}