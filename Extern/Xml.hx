extern class Xml {
	public function exists(att : String) : Bool;
	public function get(att : String) : String;
	public function firstElement() : Xml;
	public static function parse(str : String) : Xml;
}