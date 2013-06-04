
extern class Exif {
	
	// IPTC
	public var description :String;
	public var city :String;
	public var location :String;
	public var geodata :String;
	
	// EXIF
	public var exposure (null, set) :String;
	public var aperture (null, set) :String;
	public var focalLength (null, set) :String;
	public var iso (null, set) :String;
	public var exif (get, null) :String;
	
	
	public function new () :Void {}
	
	
	function set_exposure (val:String) :String {}
	function set_aperture (val:String) :String {}
	function set_focalLength (val:String) :String {}
	function set_iso (val:String) :String {}
	
	
	function get_exif () :String {}
	
	
	public function toString () :String {}
}
