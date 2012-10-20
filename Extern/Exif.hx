
extern class Exif {
	
	// IPTC
	public var description :String;
	public var city :String;
	public var location :String;
	public var geodata :String;
	
	// EXIF
	public var exposure (null, setExposure) :String;
	public var aperture (null, setAperture) :String;
	public var focalLength (null, setFocalLength) :String;
	public var iso (null, setIso) :String;
	public var exif (getExif, null) :String;
	
	
	public function new () :Void {}
	
	
	function setExposure (val:String) :String {}
	function setAperture (val:String) :String {}
	function setFocalLength (val:String) :String {}
	function setIso (val:String) :String {}
	
	
	function getExif () :String {}
	
	
	public function toString () :String {}
}
