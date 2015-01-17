package photosource;




class FlickrServer extends Photosource implements PhotosourceInterface {
	//inline public static var DEFAULT_FLICKR_API_KEY :String = "8cfd03bda401f64e02d0a9fc53ed5d2a";
/*	Key:
	856eba0cb4064fc9b0d398316307466b
	Secret:
	a084489fce1788cb*/
	
	// From xml
	var api_key :String;
	var user_name :String;
	var photoset_name :String;
	
	var flickr :Flickr;
	
	
	public function new(){
		super( null );
		
		api_key = IMPreferences.stringForKey ("flickr_api_key");
		if (api_key == "" || api_key == null)
			api_key = IMConfig.DEFAULT_FLICKR_API_KEY;
		user_name = IMPreferences.stringForKey ("flickr_user_name");
		photoset_name = IMPreferences.stringForKey ("flickr_photoset_name");
	}
	
	public function getCurrentPath (path:String) :String {
		return path.split("/").shift();
	}
	
	public function readDirectory (dir:String, ?resize:Bool) :Void {
		flickr = new Flickr (api_key, user_name);
		
		if (dir == "") {
			flickr.onComplete = onFlickrPhotosets;
			flickr.getPhotosetsList();
		}
		else if (Flickr.photosets == null) {
			// Load photosets first then load the photos list
			flickr.onComplete = rerequestDirectory.bind (dir);
			flickr.getPhotosetsList();
		}
		// Find the flickr result object that coresponds to the path
		else for (p in Flickr.photosets)
			if (Reflect.field (p, "title") == dir.split("/").shift()) {
				flickr.onComplete = onFlickrPhotos;
				flickr.getPhotosList( Reflect.field (p, "id") );
				break;
			}
	}
	
	function onFlickrPhotosets () :Void {
		
		var f = new Array<String>();
		for (r in Flickr.photosets)
			f.push( Reflect.field (r, "title") );
			
		files = new RCFiles ( f );
		onComplete();
	}
	
	function onFlickrPhotos () :Void {
		
		var f = new Array<String>();
		for (r in Flickr.photos)
			f.push( Reflect.field (r, "id") );
			
		files = new RCFiles ( f );
		onComplete();
	}
	
	function rerequestDirectory (dir:String) :Void {
		readDirectory ( dir );
	}
	
	
	
	/**
	 *  Get the file path
	 */
	public function getFilePath (file:String) :Void {
		flickr = new Flickr (api_key, user_name);
		flickr.onComplete = onFileFound;
		flickr.getSizes ( file );// file is the id of the photo
	}
	function onFileFound () :Void {
		file = Reflect.field (flickr.result, "Large");
		onComplete();
	}
	
	
	
	
	public function getGalleryThumb (path:String) :String {
		// find the flickr result object that coresponds to the path
		for (p in Flickr.photosets)
			if (Reflect.field (p, "title") == path)
				
				return FlickrURL.getMedium ( {	farm:	Reflect.field(p, "farm"),
												server:	Reflect.field(p, "server"),
												id:		Reflect.field(p, "primary"),
												secret:	Reflect.field(p, "secret")
											} );
			return "";
	}
	
	
	
	public function getTimelineThumb (path:String) :String {
		// find the flickr result object that coresponds to the path
		for (p in Flickr.photos) {
			if (Reflect.field (p, "id") == path)
				return FlickrURL.getSmall ( {	farm:	Reflect.field(p, "farm"),
												server:	Reflect.field(p, "server"),
												id:		Reflect.field(p, "id"),
												secret:	Reflect.field(p, "secret")
											} );
		}
				return "";
	}
	
	
	/**
	 *  Get the IPTC and EXIF
	 */
	public function getExif (file:String) :Void {
		flickr = new Flickr (api_key, user_name);
		flickr.onComplete = onFlickrExifLoad;
		flickr.getInfo( file );// file is the id of the photo
	}
	
	function onFlickrExifLoad () :Void {
		// Extract the data from flickr.result ( description, city, location ) and add it to the new result
		exif = new Exif();
		exif.description = Reflect.field (flickr.result, "description");
		exif.city = Reflect.field (flickr.result, "city");
		exif.location = Reflect.field (flickr.result, "location");
		exif.geodata = Reflect.field (flickr.result, "geodata");
		
		onComplete();
	}
	
	
	public function getFiles (files:RCFiles) :Array<String> {
		return files.dir;
	}
	
	
	public function destroy () {
		if (request != null)
			request.destroy();
			request = null;
	}
}
