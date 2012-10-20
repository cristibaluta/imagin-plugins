//
//  Thumb of the timeline
//
//  Created by Baluta Cristian on 2008-12-24.
//  Copyright (c) 2008 http://imagin.ro. All rights reserved.
//
package v4.timeline;


class Thumb extends RCControl {
	
	var photo :Photo;
	var path :String;
	var labelStr :String;
	
	var background :RCRectangle;
	var loader :RCRectangle;
	var indeterminateLoader :RCView;
	var vertical :Bool;
	var segmentLength :Int;
	var timer :haxe.Timer;
	var photoView :RCImage;// Load and store it into the Photo object
	var labelView :Slider;
	//var url :IMURLRequest;
	var inited :Bool;
	var loaded :Null<Bool>;
	
	// xml
	var colorBackground :Int;
	var colorLoader :Int;
	var colorLink :Int;
	
	dynamic public function onInit () :Void {} // called after the photo has loaded succesfuly, or not
	
	
	public function new (x, y, w, h, path:String, photo:Photo, nr:Int) {
		
		super (x, y, w, h);
		
		this.inited = false;
		this.loaded = null;
		this.vertical = w > h ? false : true;
		this.path = path;
		this.photo = photo;
		this.labelStr = Std.string ( nr );
		this.clipsToBounds = true;
		
		colorLoader = Preferences.hexColorForKey ("color_highlighted");
		colorLink = Preferences.hexColorForKey ("color_highlighted");
		colorBackground = Preferences.hexColorForKey ("color_background_timeline");
		
		segmentLength = Math.ceil ((w > h ? w : h) / 5);
		
		if (vertical) {
			background = new RCRectangle (2, 0, 2, h, colorLoader, 0.4);
			loader = new RCRectangle (2, 0, 2, 1, colorLoader);
			indeterminateLoader = new RCView (2, 0);
			for (i in 0...5) indeterminateLoader.addChild ( new RCRectangle (0, i*(segmentLength+2), 2, segmentLength, colorLoader) );
		}
		else {
			background = new RCRectangle (0, 2, w, 2, colorLoader, 0.4);
			loader = new RCRectangle (0, 2, 1, 2, colorLoader);
			indeterminateLoader = new RCView (0, 2);
			for (i in 0...5) indeterminateLoader.addChild ( new RCRectangle (i*(segmentLength+2), 0, segmentLength, 2, colorLoader) );
		}
		
		this.addChild ( background );
		this.addChild ( loader );
		loader.visible = false;
	}
	
	override public function init () :Void {
		
		super.init();
		
		if (inited) return;
			inited = true;
		
		labelView = new Slider ( colorLink );
		labelView.expand(); // Show the expanded state of the symbol
		labelView.x = Math.floor (background.width / 2);
		labelView.y = Math.floor (background.height / 2);
		this.addChild ( labelView );
	}
	
	
	/**
	 * Progress bar when the big picture is loading
	 */
	public function updateLoaderProgress (percent:Int) :Void {
		
		if (percent != 0) {
			this.addChild ( indeterminateLoader );
			timer = new haxe.Timer(40);
			timer.run = moveLoader;
		}
		if (percent == 100) {
			haxe.Timer.delay (stopLoader, 1000);
		}
		if (size.width > size.height)
			loader.width = Zeta.lineEquationInt (0, background.width,  percent, 0, 100);
		else
			loader.height = Zeta.lineEquationInt (0, background.height,  percent, 0, 100);
		
/*		if (photoView != null)
			photoView.view.alpha = (percent == 100) ? 1 : .3;*/
	}
	
	function moveLoader () {
		
		if (vertical) {
			indeterminateLoader.y --;
			if (indeterminateLoader.y <= -segmentLength)
				indeterminateLoader.y = 0;
		}
		else {
			indeterminateLoader.x --;
			if (indeterminateLoader.x <= -segmentLength)
				indeterminateLoader.x = 0;
		}
	}
	function stopLoader () {
		timer.stop();
		loader.visible = true;
		indeterminateLoader.removeFromSuperView();
	}
	
	
	/**
	 * 
	 */
	public function showPhoto () :Void {
		
/*		if (loaded == false || loaded == null)
			Fugu.safeAdd (this, labelView);
			
		if (photo.thumbView != null) {
			this.addChild ( photo.thumbView );
			onInit();
		}
		else {
			// Load the photo
			url = new IMURLRequest ( path );
			
			photoView = new RCImage (0, 0, url.getTimelineThumb ( path + photo.photoURL ));
			photoView.onComplete = onLoadHandler;
			photoView.onError = onErrorHandler;
			this.addChild ( photoView );
			photo.thumbView = photoView;
		}
		
		if (background.width != loader.width)
			photoView.alpha = .3;*/
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
		loaded = false;
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
		
		Fugu.safeDestroy ( [background, loader, photoView, labelView] );
		background = null;
		loader = null;
		photoView = null;
		labelView = null;
		
		super.destroy();
	}
}
