extern class StringTools {

	static function endsWith(s : String, end : String) : Bool {}
	static function fastCodeAt(s : String, index : Int) : Int {}
	static function hex(n : Int, ?digits : Int) : String {}
	static function htmlEscape(s : String) : String {}
	static function htmlUnescape(s : String) : String {}
	static function isEOF(c : Int) : Bool {}
	static function isSpace(s : String, pos : Int) : Bool {}
	static function lpad(s : String, c : String, l : Int) : String {}
	static function ltrim(s : String) : String {}
	static function replace(s : String, sub : String, by : String) : String {}
	static function rpad(s : String, c : String, l : Int) : String {}
	static function rtrim(s : String) : String {}
	static function startsWith(s : String, start : String) : Bool {}
	static function trim(s : String) : String {}
	static function urlDecode(s : String) : String {}
	static function urlEncode(s : String) : String {}
	
}