//
//  RSS2
//
//  Created by Baluta Cristian on 2009-06-23.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin;


import admin.lib.Files;
import admin.lib.Photos;
import admin.lib.Caption;
import admin.lib.GalleryThumb;


class Galleries extends RCView {
	
	var tree :Array<String>;
	var albums :Array<Files>;
	var albumsThumb :Array<GalleryThumb>;
	var photos :Photos;
	var caption :Caption;
	
	
	public function new (x, y) {
		super(x, y);
		
		tree = new Array<String>();
		albums = new Array<Files>();
		albumsThumb = new Array<GalleryThumb>();
		
		addAlbumLevel ( 0 );
	}
	
	
	/**
	 *	Add a new level in the hierarchy
	 */
	function addAlbumLevel (i:Int) {
		trace("add level "+i);
		
		if (i > 0) if (!Zeta.isDirectory( albums[i-1].label )) return;
		
		// First thing to do is to remove all levels greater and equal with i
		var j = tree.length;
		while (j >= i) {
			trace("remove level "+j);
			Fugu.safeDestroy ( [albums[j], albumsThumb[j-1]] );
			
			tree.pop();
			albums.pop();
			albumsThumb.pop();
			
			j--;
		}
		// Also remove the photos and caption
		Fugu.safeDestroy ([photos, caption]);
		
		// Construct the new complete path
		if (i > 0)
			tree[i-1] = albums[i-1].label;
		
		var path = Config.PHOTOS_PATH + tree.join("/");
		trace(tree);trace(path);
		
		
		// Construct the files manager for level i
		var album = new RCFiles (i*180, 0, 160, 300, i==0?"root:":tree[i-1]+":", path + "/");
			album.onClick = addAlbumLevel.bind (i+1);
			album.onComplete = albumDidFinishInitialization.bind (i);
			album.editable = true;//(Session.get ("album") == "admin" || Session.get ("album") == "") ? true : false;
			
		if (i > 0)
			album.setMark ( Math.round(this.mouseY) );
			
		this.addChild ( album );
		albums.push ( album );
		
		
		if (i == 0) return;
		// Add thumbnail for the selected gallery
		var pathThumb = new IMURLRequest( Config.PATH ).getGalleryThumb( tree.join("/") );
		var thumb = new GalleryThumb (i*180, 315, 160, 100, "Thumbnail:", pathThumb);
			thumb.editable = true;//(Session.get ("album") == "admin" || Session.get ("album") == "") ? true : false;
			
		this.addChild ( thumb );
		albumsThumb.push ( thumb );
	}
	
	function albumDidFinishInitialization (i:Int) {
		if (i > 0)
		//if (!albums[i].containsFolders)
			addPhotos ( i );
	}
	
	
	/**
	 *	Add photos
	 */
	function addPhotos (i:Int) {
		
		var path = Config.PHOTOS_PATH + tree.join("/") + "/";
		
		photos = new Photos (180*(i+1), 0, 500, 300, "Media files:", path);
		photos.onClick = addCaption;
		photos.setMark ( Math.round (this.mouseY) );
		this.addChild ( photos );
		
		// Set the new min width of the flash stage
		RCWindow.setWidth ( Math.round ( photos.x + photos.width ) );
	}
	
	
	/**
	 *	Add caption
	 */
	function addCaption () {
		
		Fugu.safeDestroy ( caption );
		
		var path = Config.PHOTOS_PATH + tree.join("/") + "/" + photos.label;
		
		caption = new Caption (photos.x, 300 + 15, 500, 100, "Caption:", path);
		caption.editable = true;//(Session.get ("album") == "admin" || Session.get ("album") == "") ? true : false;
		this.addChild ( caption );
	}
	
	
	
	override public function destroy () {
		
	}
}
