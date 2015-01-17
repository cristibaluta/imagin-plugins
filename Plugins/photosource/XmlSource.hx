package im.photosource;


import photosource.Photosource;// from Model
import photosource.PhotosourceInterface;// from Model


class XmlSource extends Photosource implements PhotosourceInterface {
	
	var xml :Xml;
	var tree :Array<String>;
	var lastXml :Xml;// Used to extract later the exif from photos
	
	public static function main(){}
	public function new (?xmlPath:String) {
		super( xmlPath );
	}
	
	public function getCurrentPath (path:String) :String {
		return ( IMConfig.PHOTOS_PATH + (path == null ? "" : path) );
	}
	
	public function readDirectory (dir:String, ?resize:Bool) :Void {
		
		tree = dir.split( IMConfig.PHOTOS_PATH ).pop().split("/");
		tree.remove ("");
		
		if (xml == null) {
			var xml = (scriptsPath == null) ? (IMConfig.PHOTOS_PATH + "_files.xml") : scriptsPath;
			
			request = new RCHttp();
			request.onComplete = completeHandler;
			request.onError = errorHandler;
			request.readFile (xml + "?" + Math.random());
		}
		else {
			extractFromTree();
			onComplete();
		}
	}
	
	// We expect an xml of this structure
	/*
		
	*/
	function completeHandler () :Void {
		//trace(request.result);
		xml = Xml.parse( request.result ).firstElement();
		extractFromTree();
		onComplete();
	}
	
	function extractFromTree () {
		
		var arr = new Array<String>();
		lastXml = xml;
		
		for (t in tree) {
			//for (e in lastXml.elements()) {
			for (e in lastXml.elementsNamed("dir")) {
				if (e.get("name") == t) {
					lastXml = e;
					break;
		}	}	}
		for (e in lastXml.elements())
			arr.push ( e.get("name") );
			
		files = new RCFiles ( arr );
	}
	
	
	/**
	 *  Get the file path
	 */
	public function getFilePath (file:String) :Void {
		trace("getFilePath "+file);
		this.file = (file.indexOf ("http://") == -1) ? (scriptsPath + file) : file;
		onComplete();
	}
	
	public function getGalleryThumb (path:String) :String {
		return scriptsPath + path + "/_thumb.jpg";
	}
	
	
	
	public function getTimelineThumb (path:String) :String {
		var ext = path.split(".").pop(); // original extension of the file
		var new_ext = "th." + (Zeta.isIn (ext, ["jpg","jpeg","png"], "fit") ? ext : "jpg");
		return StringTools.replace (path, "." + ext, "." + new_ext);
	}
	public function getPhotoPreview (path:String) :String {
		var arr = path.split(".");
		var ext = arr.pop(); // original extension of the file
		var new_ext = "preview." + (Zeta.isIn (ext, ["jpg","jpeg","png"], "fit") ? ext : "jpg");
		return (arr.join(".") + "." + new_ext);
	}
	
	
	public function getExif (file:String) :Void {
		
		var f = file.split("/").pop();
		
		exif = new Exif();
		
		for (e in lastXml.elements()) {
			if (e.get ("name") == f) {// The file was found in the xml elements
				for (att in e.attributes())
					switch (att.toLowerCase()) {
						case "description":	exif.description = e.get( att );
						case "city":		exif.city = e.get( att );
						case "location":	exif.location = e.get( att );
						case "geodata":		exif.geodata = e.get( att );
						case "exposure":	exif.exposure = e.get( att );
						case "aperture":	exif.aperture = e.get( att );
						case "focalLength":	exif.focalLength = e.get( att );
						case "iso":			exif.iso = e.get( att );
					}
				break;
			}
		}
		
		onComplete();
	}
	
	
	public function getFiles (files:RCFiles) :Array<String> {
		return files.media.concat ( files.text );
	}
	
	
	
	public function destroy () {
		request.destroy();
		request = null;
	}
}
