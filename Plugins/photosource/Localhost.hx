package photosource;


class Localhost extends Photosource implements PhotosourceInterface {
	
	
	public function new (scriptsPath:String) {
		super( scriptsPath );
	}
	
	public function getCurrentPath (path:String) :String {
		return ( IMConfig.PATH + (path == null ? "" : path) );
	}
	
	public function readDirectory (dir:String, ?resize:Bool) :Void {
		// connect to System
		var cnx = swhx.Connection.desktopConnect();
		// call MainDesktop.readDirectory( dir )
		var arr :Array<String> = cnx.MainDesktop.readDirectory.call ( [dir] );
		files = new RCFiles ( arr );
		onComplete();
	}
	
	public function getFilePath (file:String) :Void {
		this.file = scriptsPath + file;
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
	
	public function getExif (file:String) :Void {
		exif = new Exif();
		onComplete();
	}
	
	public function getFiles (files:RCFiles) :Array<String> {
		return files.media.concat ( files.text );
	}
	
	
	public function destroy () {
		if (request != null)
			request.destroy();
			request = null;
	}
}
