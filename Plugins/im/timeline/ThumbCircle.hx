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
	
	var _lineUp :RCRectangle;
	var _lineDown :RCRectangle;
	var circle :RCRectangle;
	var circleActive :RCRectangle;
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
		this.path = path;
		this.photo = photo;
		this.labelStr = Std.string ( nr );
/*		this.clipsToBounds = true;*/
		
		_colorLoader = IMPreferences.hexColorForKey ("color_text");
		_colorLink = IMPreferences.hexColorForKey ("color_highlighted");
		_colorBackground = IMPreferences.hexColorForKey ("color_background");
		
		segmentLength = Math.ceil ((isHorizontal() ? w : h) / 5);
		
		var d = Math.round (4 + (isHorizontal() ? h : w));
		var r = Math.round (d / 2);
		
		if (isHorizontal()) {
			_lineUp = new RCRectangle (0, 2, w/2-d/2, 1, _colorLoader, 1);
			_lineDown = new RCRectangle (w/2+d/2, 2, w/2-d/2, 1, _colorLoader, 1);
			circle = new RCRectangle (w/2-d/2, -d/2+2+1, d-2, d-2, [null,_colorLoader], 0.8, d);
		}
		else {
			_lineUp = new RCRectangle (2, 0, 1, h/2-d/2, _colorLoader, 1);
			_lineDown = new RCRectangle (2, h/2+d/2, 1, h/2-d/2, _colorLoader, 1);
			circle = new RCRectangle (-d/2+2+1, h/2-d/2, d-2, d-2, [null,_colorLoader], 0.8, d);
		}
		
		circleActive = new RCRectangle (w/2-2, h/2-2, 4, 4, _colorLoader, 0.0, 4);
		
		this.addChild ( _lineUp );
		this.addChild ( _lineDown );
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
		
		if (percent < 100) {
			circleActive.alpha = Zeta.lineEquationInt (0.0, 1.0,  percent, 0, 100);
		}
		else {
			circleActive.alpha = 1.0;
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
	
	inline function isHorizontal () :Bool {
		return size.width > size.height;
	}
	
	// Clean mess
	override public function destroy () : Void {
		
		Fugu.safeDestroy ( [_lineUp, _lineDown, circle, circleActive] );
		_lineUp = null;
		_lineDown = null;
		circle = null;
		circleActive = null;
		
		super.destroy();
	}
}
