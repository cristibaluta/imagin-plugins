
extern class Photo {
	
	public var name :String;
	public var extension :String;
	public var exif :Exif;
	//public var comments :Comments;
	public var photoView (getPhotoView, setPhotoView) :IMMediaViewerInterface;
	public var previewView (getPreviewView, setPreviewView) :RCImage;
	public var thumbView (getThumbView, setThumbView) :RCImage;
	public var photoURL :String;
	public var previewURL :String;
	public var thumbURL :String;
	
	
	public function new (url:String) :Void {}
	
	public function getPhotoView () :IMMediaViewerInterface {}
	public function setPhotoView (view:IMMediaViewerInterface) :IMMediaViewerInterface {}
	
	public function getThumbView() :RCImage {}
	public function setThumbView (view:RCImage) :RCImage {}
	
	public function getPreviewView() :RCImage {}
	public function setPreviewView (view:RCImage) :RCImage {}
	
	
	public function destroy () :Void {}
	public function toString () :String {}
}
