extern class Reflect {
	public static function isFunction(f : Dynamic) : Bool{}
	public static function fields(o : Dynamic) : Array<String>{}
	public static function field(o : Dynamic, field : String) : Dynamic{}
	public static inline function setField(o : Dynamic, field : String, value : Dynamic) : Void{}
	public static function callMethod(o : Dynamic, func : Dynamic, args : Array<Dynamic>) : Dynamic{}
	public static function compareMethods(f1 : Dynamic, f2 : Dynamic) : Bool{}
	public static function hasField(o : Dynamic, field : String) : Bool{}
	public static function deleteField(o : Dynamic, f : String) : Bool{}
}
