//
//  Thumb of the timeline
//
//  Created by Baluta Cristian on 2008-12-24.
//  Copyright (c) 2008 http://imagin.ro. All rights reserved.
//
package im.timeline;


class ThumbCircle extends RCControl {
	
	var photo :IMPhoto;
	var path :String;
	var labelStr :String;
	
	var background :RCRectangle;
	var circle :RCRectangle;
	var circleActive :RCRectangle;
	var vertical :Bool;
	var segmentLength :Int;
	var timer :haxe.Timer;
	var photoView :RCImage;// Load and store it into the Photo object
	var labelView :Slider;
	//var url :IMURLRequest;
	var inited :Bool;
	var loaded :Null<Bool>;
	
	// xml
	var _colorBackground :Int;
	var _colorLoader :Int;
	var _colorLink :Int;
	
	dynamic public function onInit () :Void {} // called after the photo has loaded succesfuly, or not
	
	
	public function new (x, y, w, h, path:String, photo:IMPhoto, nr:Int) {
		
		super (x, y, w, h);
		
		this.inited = false;
		this.loaded = null;
		this.vertical = w > h ? false : true;
		this.path = path;
		this.photo = photo;
		this.labelStr = Std.string ( nr );
/*		this.clipsToBounds = true;*/
		
		_colorLoader = IMPreferences.hexColorForKey ("color_highlighted");
		_colorLink = IMPreferences.hexColorForKey ("color_highlighted");
		_colorBackground = IMPreferences.hexColorForKey ("color_background_timeline");
		
		segmentLength = Math.ceil ((this.vertical ? w : h) / 5);
		
		var d = Math.round(8+w);
		var r = Math.round(d/2);
		
		if (vertical) {
			background = new RCRectangle (2, 0, 2, h, _colorLoader, 0.4);
			circle = new RCRectangle (-d/2+2+1, h/2-d/2, d, d, _colorLoader, 1.0, d);
			circle.addChild ( new RCRectangle (1, 1, d-2, d-2, 0xFFFFFF, 1.0, d-2) );
		}
		else {
			background = new RCRectangle (0, 2, w, 2, _colorLoader, 0.4);
			circle = new RCRectangle (0, 2, d, d, _colorLoader, 1, d);
		}
		
		circleActive = new RCRectangle (circle.x, circle.y, d, d, _colorLink, 0.0, d);
		
		this.addChild ( background );
		this.addChild ( circle );
		this.addChild ( circleActive );
	}
	
	override public function init () :Void {
		
		super.init();
		
		if (inited) return;
			inited = true;
	}
	
	
	/**
	 * Progress bar when the big picture is loading
	 */
	public function updateLoaderProgress (percent:Int) :Void {
		
		if (percent != 0) {
			circle.alpha = Zeta.lineEquationInt (0, 1,  percent, 0, 100);
		}
		if (percent == 100) {
			circle.alpha = 1.0;
/*			haxe.Timer.delay (stopLoader, 1000);*/
		}
		
	}
	
	function stopLoader () {
		
	}
	
	
	/**
	 * 
	 */
	public function showPhoto () :Void {
		
	}
	public function hidePhoto () :Void {
		//Fugu.safeRemove ([labelView, photoView]);
	}
	
	
	
	/**
	 * Set the thumb as loaded even if an error occures
	 */
	function onLoadHandler () :Void {
/*		Fugu.safeRemove ( labelView );
		photoView.width = 65;
		photoView.height = 65;
		loaded = true;
		if (onInit != null)
			onInit();*/
	}
	function onErrorHandler () :Void {
		if (onInit != null)
			onInit();
	}
	
/*	override function rollOverHandler (e:EVMouse) :Void {
		if (photoView != null) photoView.alpha = 1;
		if (labelView != null) this.addChild ( labelView );
	}
	
	override function rollOutHandler (e:EVMouse) :Void {
		if (photoView != null) photoView.alpha = background.width != loader.width ? .3 : 1;
		if (loaded) Fugu.safeRemove ( labelView );
	}
	
	*/
	
	
	/**
	 * Set the width and height when zooming
	 */
/*	function setW (w:Int) :Int {
		background.width = w;
		
		// Recalculate the width of the loader
		if (loader.width != 0)
			loader.width = w;
		
		return w;
	}
	function setH (h:Int) :Int {
		background.height = h;
		loader.height = h - 4;
		
		return h;
	}*/
	
	
	// Clean mess
	override public function destroy () : Void {
		
		Fugu.safeDestroy ( [background, circle, circleActive] );
		background = null;
		circle = null;
		circleActive = null;
		
		super.destroy();
	}
}
