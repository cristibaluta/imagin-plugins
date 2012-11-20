//
//  Thumb
//
//  Created by Baluta Cristian on 2009-07-04.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;




class Thumb extends RCButtonEvents {
	
	var path :String;
	var label :String;
	
	var background :RCRectangle;
	var photo :RCImage;
	var url :IMURLRequest;
	
	//public var w (default, setW) :Int;
	//public var h (default, setH) :Int;
	
	dynamic public function onInit () :Void {} // called after the photo has loaded succesfuly or not
	
	
	public function new (x, y, w, h, path:String, nr:Int) {
		super (x, y);
		
		this.path = path;
		this.label = Std.string ( nr );
		
		background = new RCRectangle (0, 0, w, h, 0x000000);
		this.addChild ( background );
		
		init();
	}
	
	public function init () :Void {
		// Load the photo
		url = new IMURLRequest ( path );
		
		photo = new RCImage (0, 0, url.getTimelineThumb ( path ));
		photo.onComplete = onLoadHandler;
		photo.onError = onErrorHandler;
		this.addChild ( photo );
	}
	
	
	/**
	 * Set the thumb as loaded even if an error occures
	 */
	function onLoadHandler () :Void {
		photo.width = 65;
		photo.height = 65;
	}
	function onErrorHandler () :Void {
		
	}
	
	override function rollOverHandler (e:EVMouse) :Void {
		if (photo != null) photo.alpha = 0.5;
	}
	override function rollOutHandler (e:EVMouse) :Void {
		if (photo != null) photo.alpha = 1;
	}
	override function clickHandler (e:EVMouse) :Void {
		onClick();
		this.dispatchEvent (new ThumbEvent (ThumbEvent.CLICK, label));
	}
	
	
	// Clean mess
	override public function destroy () : Void {
		removeListeners ( this );
		Fugu.safeDestroy ( photo );
		photo = null;
	}
}
