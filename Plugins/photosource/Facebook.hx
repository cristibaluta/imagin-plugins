package photosource;


class Server extends Photosource implements PhotosourceInterface {
	
	
	public function new (scriptsPath:String) {
		super ( scriptsPath );
	}
	
	public function getCurrentPath (path:String) :String {
		return ( IMConfig.PHOTOS_PATH + (path == null ? "" : path) );
	}
	
	public function readDirectory (dir:String, ?resize:Bool) :Void {
		var kindOfThumbnailResize = resize
		?	"fill"
		:	(IMPreferences.boolForKey("enable_timeline_thumbnails") ? "fill" : "none");
		
		var params = {	sort : "LastModifiedDescending",
						w : 65, h : 65,
						resize : kindOfThumbnailResize,
						path : dir
					};
		
		request = new RCHttp ( scriptsPath );
		request.onComplete = completeHandler;
		request.onError = errorHandler;
		request.call ("filesystem/readAndCreateThumbs.php", params);
	}
	
	function completeHandler () :Void {
		trace(request.result);
		if (request.result.split("::")[0] == "error") {
			errorMessage = request.result.split("::").pop();
			onError();
		}
		else {
			// RCFiles are grouped in two parts: the files found on the server
			// The separator -> 
			// And a list of files found in the _sort.xml
			var f = request.result.split ("[FILES::").pop().split ("::FILES]").shift().split ("->");
			
			// files on server
			files = new RCFiles ( f[0].split("*") );
			
			// RCFiles used for sorting
			if (f.length > 1)
				files.extra = f[1].split("*");
			
			onComplete();
		}
	}
	
	
	/**
	 *  Get the file path
	 */
	public function getFilePath (file:String) :Void {
		this.file = scriptsPath + file;
		onComplete();
	}
	
	public function getPreviewPath (file:String) :Void {
		this.file = scriptsPath + file;
		onComplete();
	}
	
	public function getGalleryThumb (path:String) :String {
		return scriptsPath + path + "/_thumb.jpg";
	}
	
	public function getTimelineThumb (path:String) :String {
		var arr = path.split(".");
		var ext = arr.pop(); // original extension of the file
		var new_ext = "th." + (Zeta.isIn (ext, ["jpg","jpeg","png"], "fit") ? ext : "jpg");
		return (arr.join(".") + "." + new_ext);
	}
	public function getPhotoPreview (path:String) :String {if(path==null)return "";
		var arr = path.split(".");
		var ext = arr.pop(); // original extension of the file
		var new_ext = "preview." + (Zeta.isIn (ext, ["jpg","jpeg","png"], "fit") ? ext : "jpg");
		return (scriptsPath + arr.join(".") + "." + new_ext);
	}
	
	public function getFiles (files:RCFiles) :Array<String> {
		return files.media.concat ( files.text );
	}
	
	public function loadExif (file:String) :Void {
		file = IMConfig.PHOTOS_PATH + file;
/*		trace("LOAD EXIF "+file);trace(scriptsPath);trace( StringTools.replace(file,scriptsPath+"../","") );*/
		// The path to the photo converted to use it as relative from scripts_path
		request = new RCHttp ( scriptsPath );
		request.onComplete = onExifLoaded;
		request.onError = errorHandler;
		request.call ("filesystem/getFileInfo.php", {path: "../../photos/test4/20120301-2.1-signed.jpg
"});
			//StringTools.replace (file, scriptsPath + "../", "")});
	}
	
	function onExifLoaded () :Void {
/*		trace(request.result);*/
		return;
		exif = new Exif();
		
		var xml = Xml.parse( request.result ).firstElement();
		
		for (e in xml.elements())
			switch (e.nodeName.toLowerCase()) {
				case "description":	exif.description = e.nodeValue;
				case "city":		exif.city = e.nodeValue;
				case "location":	exif.location = e.nodeValue;
				case "geodata":		exif.geodata = e.nodeValue;
				case "exposure":	exif.exposure = e.nodeValue;
				case "aperture":	exif.aperture = e.nodeValue;
				case "focalLength":	exif.focalLength = e.nodeValue;
				case "iso":			exif.iso = e.nodeValue;
			}
			trace(exif);
		onComplete();
	}
}
