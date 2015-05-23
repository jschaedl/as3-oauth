package org.janschaedlich.oauth.util
{
	/**
	 * Encodes and decodes strings into URL format.
	 *
	 * Code ported from the javascript code at:
	 * http://cass-hacks.com/articles/code/js_url_encode_decode/
	 *
	 * UTF-8 bug fixed by Denis Borisenko:
	 * http://blog.dborisenko.com/en/2009/09/05/extended-utf-8-in-oauth-actionscript-library/
	*/
	public class URLEncoding
	{
		public function URLEncoding()
		{
			
		}
		
		public static function encode(decodedUrl:String):String
		{
			return new URLEncoding().internal_Encode(decodedUrl);
		}
		
		public static function decode(encodedUrl:String):*
		{
			return new URLEncoding().internal_Decode(encodedUrl);
		}
		
		
		/**
		 * Properly URL encodes a string, taking into account UTF-8
		 */
		protected function internal_Encode(decodedUrl:String):String
		{
			return encodeUrl(encodeUTF8(decodedUrl));
		}
		
		/**
		 * Decodes a string from a URL compliant format.
		 *
		 * @param encodedString String to be decoded
		 */
		protected function internal_Decode(encodedUrl:String):*
		{
			var decodedOutput:String = encodedUrl;
			var plusPattern:RegExp = /\+/gm;
			var percentEncodedPattern:RegExp = /(%[^%]{2})/;
			var percentEncodedMatch:Object;
			var binaryOctet:Number;
			var correspondingAsciiChar:String;
			
			// replace all "+" with " "
			decodedOutput = decodedOutput.replace(plusPattern, " ");
			
			// convert percent encoded octets
			while (percentEncodedMatch = percentEncodedPattern.exec(decodedOutput) != null && 
				percentEncodedMatch.length > 1 && percentEncodedMatch[1] != '')
			{
				// get binary representation of hex value
				binaryOctet = parseInt(percentEncodedMatch[1].substr(1), 16);
				
				// get the corresponding ascii char
				correspondingAsciiChar = String.fromCharCode(binaryOctet);
				
				// replace percent encoded triplet with correspondingAsciiChar
				decodedOutput = decodedOutput.replace(percentEncodedMatch[1], correspondingAsciiChar);
			}
			
			return decodedOutput;
		}

		/**
		 * Does proper UTF-8 encoding of decoded url string.
		 */
		private function encodeUTF8(decodedUrl:String):String
		{
			decodedUrl = decodedUrl.replace(/\r\n/g, '\n');
			decodedUrl = decodedUrl.replace(/\r/g, '\n');

			var asciiCharCode:Number;
			var utf8DecodedUrl:String = '';

			for (var i:int=0; i < decodedUrl.length; i++)
			{
				asciiCharCode = decodedUrl.charCodeAt(i);
				
				/*
					Char. number range  |        UTF-8 octet sequence
					(hexadecimal)    |              (binary)
					--------------------+---------------------------------------------
					0000 0000-0000 007F | 0xxxxxxx
					0000 0080-0000 07FF | 110xxxxx 10xxxxxx
					0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
					0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
				*/				
				if (asciiCharCode < 128)
				{
					utf8DecodedUrl += String.fromCharCode(asciiCharCode);
				}
				else if ((asciiCharCode > 127) && (asciiCharCode < 2048))
				{
					utf8DecodedUrl += String.fromCharCode((asciiCharCode >> 6) | 192);
					utf8DecodedUrl += String.fromCharCode((asciiCharCode & 63) | 128);
				}
				else
				{
					utf8DecodedUrl += String.fromCharCode((asciiCharCode >> 12) | 224);
					utf8DecodedUrl += String.fromCharCode(((asciiCharCode >> 6) & 63) | 128);
					utf8DecodedUrl += String.fromCharCode((asciiCharCode & 63) | 128);
				}
			}

			return utf8DecodedUrl;
		}
		
		/**
		 * Does proper UTF-8 decoding of encoded url string.
		 */
		private function decodeUTF8(encodedUrl:String):String
		{
			return "not implemented yet";
		}

		/**
		 * Encodes reserved characters of decoded URL to its percent-encoded equivalent.
		 */
		private function encodeUrl(decodedUrl:String):String
		{
			var encodedUrl:String = '';
			var asciiCharCode:Number;

			for (var i:int=0; i < decodedUrl.length; i++)
			{
				asciiCharCode = decodedUrl.charCodeAt(i);

				if (isUneservedCharacter(asciiCharCode))
				{
					encodedUrl += String.fromCharCode(asciiCharCode);
				}
				else
				{
					encodedUrl += '%' + asciiCharCode.toString(16).toUpperCase();
				}
			}

			return encodedUrl;
		}
		
		private function isUneservedCharacter(asciiCharCode:Number):Boolean
		{
			return (isALPHA(asciiCharCode) ||
				isDIGIT(asciiCharCode) ||					
				asciiCharCode == HYPEN ||
				asciiCharCode == PERIOD ||
				asciiCharCode == UNDERSCORE ||
				asciiCharCode == TILDE);
		}
		
		private function isALPHA(asciiCharCode:Number):Boolean
		{	
			return ((asciiCharCode >= 65 && asciiCharCode <= 90) || // A-Z
					(asciiCharCode >= 97 && asciiCharCode <= 122)); // a-z
		}
		private function isDIGIT(asciiCharCode:Number):Boolean
		{
			return (asciiCharCode >= 48 && asciiCharCode <= 57); // 0-9
		}
		
		private static const HYPEN:Number = 45;
		private static const PERIOD:Number = 46;
		private static const UNDERSCORE:Number = 95;
		private static const TILDE:Number = 126;
		
	}
}
