
extern class Photo {
	
	public var name :String;
	public var extension :String;
	public var exif :Exif;
	//public var comments :Comments;
	public var photoView (get, set) :IMMediaViewerInterface;
	public var previewView (get, set) :RCImage;
	public var thumbView (get, set) :RCImage;
	public var photoURL :String;
	public var previewURL :String;
	public var thumbURL :String;
	
	
	public function new (url:String) :Void {}
	
	public function get_photoView () :IMMediaViewerInterface {}
	public function set_photoView (view:IMMediaViewerInterface) :IMMediaViewerInterface {}
	
	public function get_thumbView() :RCImage {}
	public function set_thumbView (view:RCImage) :RCImage {}
	
	public function get_previewView() :RCImage {}
	public function set_previewView (view:RCImage) :RCImage {}
	
	
	public function destroy () :Void {}
	public function toString () :String {}
}
