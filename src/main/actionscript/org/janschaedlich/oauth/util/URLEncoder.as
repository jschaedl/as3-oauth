package org.janschaedlich.oauth.util
{
	public class URLEncoder
	{
		public function URLEncoder()
		{
			
		}
		
		/**
		 * Properly URL encodes a string, taking UTF-8 into account.
		 * 
		 * @param decodedUrl String to be encoded
		 */
		public static function encode(decodedUrl:String):String
		{
			return new URLEncoder().internal_Encode(decodedUrl);
		}
		
		protected function internal_Encode(decodedUrl:String):String
		{
			return percentEncode(utf8Encode(decodedUrl));
		}
		
		/**
		 * Does proper UTF-8 encoding of decoded url string.
		 * 
		 *
		 * Char. number range  | UTF-8 octet sequence
		 * (hexadecimal)       | (binary)
		 * --------------------+---------------------------------------------
		 * 0000 0000-0000 007F | 0xxxxxxx
		 * 0000 0080-0000 07FF | 110xxxxx 10xxxxxx
		 * 0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
		 * 0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx		
		 * 
		 */
		private function utf8Encode(decodedUrl:String):String
		{
			decodedUrl = decodedUrl.replace(/\r\n/g, '\n');
			decodedUrl = decodedUrl.replace(/\r/g, '\n');

			var utf8EncodedUrl:String = '';
			var charCodeCount:int = 0;
			var charCode:Number; 	// charCode => correspondends to a unicode codePoint
			

			for (; charCodeCount < decodedUrl.length; charCodeCount++)
			{
				charCode = decodedUrl.charCodeAt(charCodeCount);
				
				// 0000 0000-0000 007F | 0xxxxxxx
				if (charCode < 128)
				{
					utf8EncodedUrl += String.fromCharCode(charCode);
				}
				// 0000 0080-0000 07FF | 110xxxxx 10xxxxxx
				// in the range 0000 0080 = 128 - 0000 07FF = 2047 
				// we need to fill in 2 utf8 octets
				else if ((charCode > 127) && (charCode < 2048))
				{
					utf8EncodedUrl += String.fromCharCode((charCode >> 6) | 192);
					utf8EncodedUrl += String.fromCharCode((charCode & 63) | 128);
				}
				// 0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
				// in the range 0000 0800 = 2048 - 0000 FFFF = 65535 
				// we need to fill in 3 utf8 octets
				else if ((charCode > 2047) && (charCode < 65536))
				{
					utf8EncodedUrl += String.fromCharCode((charCode >> 12) | 224);
					utf8EncodedUrl += String.fromCharCode(((charCode >> 6) & 63) | 128);
					utf8EncodedUrl += String.fromCharCode((charCode & 63) | 128);
				}
				else
				{
					throw new Error('Sorry, this char code range is not supported in ActionScript.');
				}
			}

			return utf8EncodedUrl;
		}

		/**
		 * Encodes reserved characters of decoded URL to its percent-encoded equivalent.
		 */
		private function percentEncode(decodedUrl:String):String
		{
			var encodedUrl:String = '';
			var charCodeCount:int = 0;
			var charCode:Number;
			
			for (; charCodeCount < decodedUrl.length; charCodeCount++)
			{
				charCode = decodedUrl.charCodeAt(charCodeCount);

				if (isUnreservedCharacter(charCode))
				{
					encodedUrl += String.fromCharCode(charCode);
				}
				else
				{
					encodedUrl += '%' + charCode.toString(16).toUpperCase();
				}
			}

			return encodedUrl;
		}
		
		private function isUnreservedCharacter(charCode:Number):Boolean
		{
			return (isALPHA(charCode) ||
				isDIGIT(charCode) ||					
				charCode == HYPEN ||
				charCode == PERIOD ||
				charCode == UNDERSCORE ||
				charCode == TILDE);
		}
		
		private function isALPHA(charCode:Number):Boolean
		{	
			return ((charCode >= 65 && charCode <= 90) || // A-Z
					(charCode >= 97 && charCode <= 122)); // a-z
		}
		private function isDIGIT(charCode:Number):Boolean
		{
			return (charCode >= 48 && charCode <= 57); // 0-9
		}
		
		private static const HYPEN:Number = 45;
		private static const PERIOD:Number = 46;
		private static const UNDERSCORE:Number = 95;
		private static const TILDE:Number = 126;
	}
}
