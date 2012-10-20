//
//  An universal interface between Imagin and different services is getting photos from:
//	localhost, neko desktop server, flickr
//
//  Created by Baluta Cristian on 2008-10-26.
//  Copyright (c) 2008 http://imagin.ro. All rights reserved.
//

extern class IMURLRequest {
	
	public var files :RCFiles;
	public var file :String;
	public var exif :Exif;
	public var errorMessage :String;
	
	dynamic public function onComplete () :Void {}
	dynamic public function onError () :Void {}
	
	
	public function new (scriptsPath:String) :Void {}
	
	public function getCurrentPath ( suffixPath:String ) :String {}
	public function readDirectory (directory:String, ?resize:Bool) :Void {}
	public function getFile (file:String) :Void {}
	public function getGalleryThumb (path:String) :String {}
	public function getTimelineThumb (path:String) :String {}
	public function getPhotoPreview (path:String) :String {}
	public function loadExif (file:String) :Void {}
	public function getFiles (files:RCFiles) :Array<String> {}
	
	public function destroy () :Void {}
}
