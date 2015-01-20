//
//  Expandable
//
//  Created by Baluta Cristian on 2011-07-08.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//
package im.timeline;


class Expandable extends RCView implements IMTimelineInterface {
	
	public var view :RCView;
	
	inline public static var THUMB_W :Int = 65;
	inline public static var PADDING :Int = 20;
	inline public static var EASING :Float = .4;
	
	public var click :RCSignal<Int->Void>;
	
	var _path :String;
	var _files :Array<IMPhoto>;// Reference of the photos array, when the thumbs are loaded are cached here
	
	// Views
	var _background :RCRectangle;
	var _thumbsView :RCView; // Attach thumbs here
	var _thumbs :Array<RCControl>;
	var _separators :Array<RCRectangle>;
	var _slider :Slider; // The slider indicates us where we are on the limeline
	
	var _nr :Int; // Currently displaying photo index
	var _hasMouse :Bool;
	var _expanded :Bool;
	
	
	// From xml setings
	var _colorText :Int;
	var _colorLink :Int;
	var _colorBackground :Int;
	var _COLORS :Array<Null<Int>>;
	
	
	public function new (path:String, files:Array<IMPhoto>) {
		
		super (0, 0);
		
		this._path = path;
		this._files = files;
		this._nr = 0;
		this._expanded = false;
		this._hasMouse = true;
		this.view = this;
		
		click = new RCSignal <Int->Void>();
		
		config();
	}
	
	function config () {
		// Settings from xml
		_colorText = IMPreferences.hexColorForKey ("color_text");
		_colorLink = IMPreferences.hexColorForKey ("color_highlighted");
		_colorBackground = IMPreferences.hexColorForKey ("color_background_timeline");
	}
	
	override public function init () :Void {
		
		super.init();
		
		// Override it and calculate the new size.width that will fit all the thumbs
		//
		
		// Add thumbs container on top of background
		_thumbsView = new RCView (0, 0);
		this.addChild ( _thumbsView );
		
		addThumbs();
		addSlider();
		
		#if flash
			RCWindow.target.addEventListener (flash.events.Event.MOUSE_LEAVE, leaveStageHandler);
			//this.addEventListener (EVMouse.MOVE, mouseMoveHandler);
		#end
	}
	
	
	/**
	 * Add thumbs and separators between each thumb
	 */
	function addThumbs () :Void {
		
		_thumbs = new Array<RCControl>();
		_separators = new Array<RCRectangle>();
		var ts = thumbSize();
		var ss = separatorSize();
		
		// Iterate over files and create thumbs
		for (i in 0..._files.length) {
			
			var p = thumbPosition (i, ts);
			var thumb = new Thumb (p.x, p.y, ts.width, ts.height, _path, _files[i], i+1);
				thumb.onClick = clickThumbHandler.bind (i);
			_thumbs.push ( thumb );
			_thumbsView.addChild ( thumb );
			
			// Add the separation dot between each thumb
			if (i < _files.length - 1) {
				var p = separatorPosition (i, ts);
				var dot = new RCRectangle (p.x, p.y, ss.width, ss.height, 0xFFFFFF);
				_thumbsView.addChild ( dot );
				_separators.push ( dot );
			}
		}
	}
	
	function clickThumbHandler (nr:Int) {
		click.dispatch ( nr );
	}
	
	
	
	/**
	 *	Slider is the little colored dot and can be expanded to show the number of the photo
	 */
	function addSlider () {
		// Add slider that indicates where we are on the timeline
		_slider = new Slider ( _colorLink );
		_slider.normal();
		_thumbsView.addChild ( _slider );
	}
	
	
	/**
	 * Update the progress bar of each thumb corespondingly with the percent loaded of the picture
	 */
	public function updateLoaderProgress (i:Int, percent:Int) {
		var thumb :Thumb = cast(_thumbs[i], Thumb);
		thumb.updateLoaderProgress ( percent );
	}
	
	// Update the slider position in timeline
	
	public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) {
		// Override it
		_nr = currentItem;
		_slider.setLabel ( Std.string ( _nr + 1 ) );
		
	}
	
	
	
	/**
	 * Check the position of the mouse every time we move it.
	 * So, zoom in or zoom out the thumbs
	 */
	function mouseMoveHandler (e:EVMouse) {
		
		if (!_hasMouse) _hasMouse = true;
		
		mouseOver()
		? {	if (!_expanded) zoomIn(); }
		: {	if (_expanded)  zoomOut();}
	}
#if flash
	function leaveStageHandler (e:flash.events.Event) {
		_hasMouse = false;
	}
#end
	
	
	/**
	 * Zoom in the group of thumbs
	 */
	function zoomIn () {
		
		if (!_hasMouse) return;
		
		_expanded = true;
		stopZoom(); // stop zoom out in case is runing
		Fugu.safeRemove ( _separators ); // remove from stage the dots
		_thumbsView.y = 1;
		_slider.expand(); // go to the expanded state of the slider
		_thumbsView.addChild ( _slider );
		
		//this.addEventListener (Event.ENTER_FRAME, zoomInHandler);
		//this.addEventListener (EVMouse.MOUSE_MOVE, mouseHandler);
		//RCWindow.target.addEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
	}
	function zoomInHandler () {
		zoomTo (THUMB_W, THUMB_W);
		//slideThumbsHandler(null);
		//this.dispatchEvent ( new TimelineEvent (TimelineEvent.ZOOMING, 1));
	}
	
	
	/**
	 * Zoom out the group of thumbs
	 */
	function zoomOut () : Void {
		
		if (!_hasMouse) return;
		
		_expanded = false;
		stopZoom(); // stop the zoom in case its runing
		
		for (i in 0..._thumbs.length) {
			var thumb :Thumb = cast(_thumbs[i], Thumb);
			thumb.onInit = null; // cancel the process of recursive loading thumbs
			thumb.hidePhoto();
		}
		_thumbsView.y = 0;
		_thumbsView.x = 0;
		_slider.normal(); // go to the normal state of the slider
		this.addChild ( _slider );
		
/*		this.addEventListener (Event.ENTER_FRAME, zoomOutHandler);
		this.removeEventListener (EVMouse.MOUSE_MOVE, mouseHandler);
		this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
		RCWindow.target.removeEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);*/
	}
	
	function zoomOutHandler () {
		//zoomTo (segmentWidth, TIMELINE_H);
		//this.dispatchEvent (new TimelineEvent (TimelineEvent.ZOOMING, -1));
	}
	
	
	/**
	 * Zoom each individual thumb to the new width and height
	 */
	function zoomTo (w:Int, h:Int) : Void {
		
		var next_w = _thumbs[0].width + (w - _thumbs[0].width) * EASING;
		var next_h = _thumbs[0].height + (h - _thumbs[0].height) * EASING;
		
		for (i in 0..._thumbs.length) {
			_thumbs[i].set_width ( Math.round (next_w) );
			_thumbs[i].set_height ( Math.round (next_h) );
			_thumbs[i].x = Math.round (next_w + 1) * i;
		}
		
/*		var backgroundWidth = (segmentWidth + 1) * files.length; // length of the background
		size.width = Math.round (background.width +
					((expanded ? (RCWindow.sharedWindow().width - PADDING*2) : backgroundWidth) - background.width) * EASING);
		size.height = Math.round (background.height +
					((expanded ? (h + 2) : h) - background.height) * EASING);*/
		
		_background.size.width = size.width;
		_background.size.height = size.height;
		_background.redraw();
		_slider.y = Math.round (next_h/2);
		
		
		// Stop zooming.
		// Arrange all elements to the corect position
		if (Math.abs (_thumbs[0].width - w) <= 1 &&
			Math.abs (_thumbs[0].height - h) <= 1) {
			
			stopZoom(); // stop enterFrame listener
			
/*			for (i in 0...thumbs.length) {
				thumbs[i].setWidth ( w );
				thumbs[i].setHeight ( h );
				thumbs[i].x = (w + 1) * i;
				
				// after zoomed in, begin to show photos for each thumb, one by one
				if (expanded)
					thumbs[i].init(); // show the basic graphics of the thumb whyle photos are loaded
				else if (i < thumbs.length-1) {
					separators[i].x = (segmentWidth + 1) * (i + 1) - 1;
					thumbsView.addChild ( separators[i] );
				}
			}*/
			
			if (_expanded) {
				_background.size.width = RCWindow.sharedWindow().width - PADDING*2;
				_background.size.height = h + 2;
				_background.redraw();
				_slider.y = Math.round (THUMB_W/2 - 1);
				recursiveThumbLoader ( 0 ); // load photos one by one
			}
			else {
/*				var len = (segmentWidth + 1) * files.length;
				var len2= (len > size.width) ? size.width : len;
				background.size.width = len2;
				background.size.height = h;
				background.redraw();*/
				_slider.y = size.height / 2;
				
/*				var ev = new TimelineEvent ("", nr);
					ev.currentCount = 15;
					ev.repeatCount = 30;
				updateSliderPosition (ev, Session.get ("slideshow_is_running"));*/
			}
		}
	}
	
	/**
	 *	Load all thumbs recursively
	 */
	function recursiveThumbLoader (i:Int) :Void {
		if (i < _thumbs.length) {
			var thumb :Thumb = cast(_thumbs[i], Thumb);
			thumb.onInit = recursiveThumbLoader.bind (i + 1);
			thumb.showPhoto(); // If not already loaded, load the photo first
		}
	}
	
	
	/**
	 * Remove ENTER_FRAME listeners for zoom in or zoom out
	 */
	function stopZoom () :Void {
/*		if (this.hasEventListener (Event.ENTER_FRAME)) {
			this.removeEventListener (Event.ENTER_FRAME, zoomInHandler);
			this.removeEventListener (Event.ENTER_FRAME, zoomOutHandler);
		}*/
	}
	
	
	public function expand () :Void {
		zoomIn();
	}
	
	
	/**
	 * Position the slider when the mouse is moving
	 */
	function mouseHandler (e:EVMouse) :Void {
		//this.addEventListener (Event.ENTER_FRAME, slideThumbsHandler);
	}
	
	function slideThumbsHandler () :Void {
		
		if (_thumbsView.width < RCWindow.sharedWindow().width - PADDING*4) {
			//this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
			_thumbsView.x = Math.round ((RCWindow.sharedWindow().width - PADDING*2)/2 - ((THUMB_W+1)*_files.length) / 2);
			return;
		}
		
		var c_x = getCorrectSliderX();
		var next_x = _thumbsView.x + (c_x - _thumbsView.x) / 6;
		_thumbsView.x = Math.round ( next_x );
		
		//if (Math.abs (c_x - next_x) <= 1)
			//this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
	}
	
	
	/**
	 * Utilities
	 * Calculate the length of a thumb. Can't be smaller than 10px
	 * 	keep an indentation of PADDING px each margin
		create a dot of 1x2px between each thumb
	 */
	function thumbSize () :RCSize {
		var len = Math.floor ( (size.width - _files.length) / _files.length );
		return new RCSize ( (len < size.height) ? size.height : len, size.height);
	}
	
	function thumbPosition (i:Int, s:RCSize) :RCPoint {
		return new RCPoint ((s.width + 1) * i, 0);// Hoizontal alignment
	}
	
	function separatorSize () :RCSize {
		return new RCSize (1, 2);// Hoizontal
	}
	
	function separatorPosition (i:Int, s:RCSize) :RCPoint {
		return new RCPoint ((s.width + 1) * (i + 1) - 1, 2);
	}
	
	
	
	// Returns the correct x of the slider depending on the x of the mouse
	public function getCorrectSliderX () :Int {
		var xm1 = 60;
		var xm2 = RCWindow.sharedWindow().width - 60;
		var xm  = 0;//Math.round ( Zeta.limitsInt (RCWindow.target.mouseX, xm1, xm2) );
		
		var x1  = PADDING;
		var x2  = x1 - _thumbsView.width + RCWindow.sharedWindow().width - x1*2 - PADDING*2;
		
		var x0 = Zeta.lineEquationInt (x1, x2, xm, xm1, xm2);
		return x0;
	}
	
	/**
	 *	Returns if the timeline is in a state of zooming or already zoomed
	 */
	public function isExpanded () :Bool {
		return _expanded;
	}
	
	/**
	 *	Returns if we are on the background area
	 *	and no far than 30px on top of it
	 */
	function mouseOver () :Bool {
		return (this.mouseY > -10)
		? {(this.mouseX < _background.width + 20) ? true : false;}
		: false;
	}
	
	/*
	 * When the stage resizes, reposition all elements accordingly
	 */
	public function resize (w:Int, h:Int) :Void {
		
		// Recalculate the length of a thumb when is closed
		var s = thumbSize();
		
		// Diferent rules: when zoomed and when not zoomed
		if (_expanded) {
			_background.size.width = w - PADDING*2;
			_background.size.height = THUMB_W + 2;
			_background.redraw();
/*			thumbsMask.size.width = w - PADDING*4;
			thumbsMask.size.height = THUMB_W + 2;
			thumbsMask.x = PADDING;
			thumbsMask.redraw();*/
		}
/*		else {
			var len = (segmentWidth + 1) * files.length;
			var len2= (len > w) ? w : len;
			background.size.width = len2;
			//background.size.height = TIMELINE_H;
			background.redraw();
			//thumbsView.size.width = len2 - 4;
			//thumbsView.size.height = TIMELINE_H;
			
			// iterate over all thumbs and resize acordingly with the new _length
			for (i in 0...thumbs.length) {
				thumbs[i].setWidth ( segmentWidth );
				thumbs[i].x = (segmentWidth + 1) * i;
				if (i < thumbs.length - 1)
					separators[i].x = (segmentWidth + 1) * (i + 1) - 1;
			}
		}*/
	}
	
	
	
	// Clean mess
	override public function destroy () :Void {
		// Remove Listeners
		stopZoom();
/*		this.removeEventListener (EVMouse.MOUSE_MOVE, mouseHandler);
		this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
		this.removeEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
		RCWindow.target.removeEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
		RCWindow.target.removeEventListener (Event.MOUSE_LEAVE, leaveStageHandler);*/
		
		// Remove graphics
		Fugu.safeDestroy ( _thumbs );
		_thumbs = null;
		click.destroy();
		
		super.destroy();
	}
}
