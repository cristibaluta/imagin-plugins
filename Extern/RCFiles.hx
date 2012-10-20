extern class RCFiles {
	
	public static var PHOTOS :Array<String>;
	public static var MUSIC :Array<String>;
	public static var FLASH :Array<String>;
	public static var PANO2VR :Array<String>;
	public static var VIDEOS :Array<String>;
	public static var TEXT :Array<String>;
	
	public var dir :Array<String>;
	public var media :Array<String>;//all pictures and videos
	public var photos :Array<String>;
	public var flash :Array<String>;
	public var pano2vr :Array<String>;
	public var music :Array<String>;
	public var video :Array<String>;
	public var text :Array<String>;
	public var xml :Array<String>;
	public var extra :Array<String>;// Add here any supplimentar files from outside
	
	
	public function new (files:Array<String>) :Void {}
	public static function isDirectory (file:String) :Bool {}
	public static function extract (str:String, ?separator:String="*") :Array<String> {}
	public function toString():String {}
}
