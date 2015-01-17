extern class IMPreferences {
	
	public static function get (key:String, ?pos:haxe.PosInfos) :Dynamic;
	public static function stringForKey (key:String, ?pos:haxe.PosInfos) :String;
	public static function floatForKey (key:String, ?pos:haxe.PosInfos) :Float;
	public static function integerForKey (key:String, ?pos:haxe.PosInfos) :Int;
	public static function boolForKey (key:String, ?pos:haxe.PosInfos) :Bool;
	public static function hexColorForKey (key:String, ?pos:haxe.PosInfos) :Int;
	public static function cssColorForKey (key:String, ?pos:haxe.PosInfos) :String;
	
}
