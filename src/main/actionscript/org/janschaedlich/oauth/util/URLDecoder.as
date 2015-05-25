package org.janschaedlich.oauth.util
{
	public class URLDecoder
	{
		public function URLDecoder()
		{
			
		}
		
		/**
		 * Decodes a string from a URL compliant format, taking UTF-8 into account. 
		 *
		 * @param encodedString String to be decoded
		 */
		public static function decode(encodedUrl:String):String
		{
			return new URLDecoder().internal_Decode(encodedUrl);
		}
		
		protected function internal_Decode(encodedUrl:String):String
		{
			return percentDecode(utf8Decode(encodedUrl));
		}
		
		/**
		 * Does proper UTF-8 decoding of encoded url string.
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
		private function utf8Decode(utf8EncodedUrl:String):String
		{
			utf8EncodedUrl = utf8EncodedUrl.replace(/\r\n/g, '\n');
			utf8EncodedUrl = utf8EncodedUrl.replace(/\r/g, '\n');
			
			var utf8OctetCount:int = 0;
			var firstOctet:Number;
			var secondOctet:Number;
			var thirdOctet:Number;
			var utf8DecodedUrl:String = '';
			
			while (utf8OctetCount < utf8EncodedUrl.length)
			{
				firstOctet = utf8EncodedUrl.charCodeAt(utf8OctetCount);
				
				// 0000 0000-0000 007F | 0xxxxxxx
				if (firstOctet < 128)
				{
					utf8DecodedUrl += String.fromCharCode(firstOctet);
					utf8OctetCount++;
					
				}
				// 0000 0080-0000 07FF | 110x xxxx 10xx xxxx
				// in the range 1100 0000 = 192 - 1101 1111 = 223 is one octet following
				else if (firstOctet > 192 && firstOctet < 224) 
				{
					secondOctet = utf8EncodedUrl.charCodeAt(utf8OctetCount+1);
					utf8DecodedUrl = String.fromCharCode((firstOctet & 31) << 6 | (secondOctet & 63));
					utf8OctetCount += 2;
					
				}
				// 0000 0800-0000 FFFF | 1110 xxxx 10xx xxxx 10xx xxxx
				// in the range 1110 0000 = 224 - 1110 1111 = 239 are two octets following
				else if (firstOctet > 224 && firstOctet < 240)
				{
					secondOctet = utf8EncodedUrl.charCodeAt(utf8OctetCount+1);
					thirdOctet = utf8EncodedUrl.charCodeAt(utf8OctetCount+2);
					utf8DecodedUrl = String.fromCharCode(((firstOctet & 15) << 12) | ((secondOctet & 63) << 6) | (thirdOctet & 63));
					utf8OctetCount += 3;
				}
				else 
				{
					throw new Error('Sorry, this char code range is not supported in ActionScript.');
				}
			}
			
			return utf8DecodedUrl;
		}
		
		/**
		 * Decodes reserved characters of encoded URL to its percent-decoded equivalent.
		 */
		private function percentDecode(encodedUrl:String):String
		{
			var decodedOutput:String = encodedUrl;
			
			var plusPattern:RegExp = /\+/gm;
			var percentEncodedPattern:RegExp = /(%[^%]{2})/;
			var percentEncodedMatch:Object;
			var charCode:Number;
			var charCodeString:String;
			
			// replace all "+" with " "
			decodedOutput = decodedOutput.replace(plusPattern, " ");
			
			// convert percent encoded octets
			while (percentEncodedMatch = percentEncodedPattern.exec(decodedOutput) != null && 
				percentEncodedMatch.length > 1 && percentEncodedMatch[1] != '')
			{
				// get binary representation of hex value
				charCode = parseInt(percentEncodedMatch[1].substr(1), 16);
				
				// get the corresponding ascii char
				charCodeString = String.fromCharCode(charCode);
				
				// replace percent encoded triplet with correspondingAsciiChar
				decodedOutput = decodedOutput.replace(percentEncodedMatch[1], charCodeString);
			}
			
			return decodedOutput;
		}
	}
}
