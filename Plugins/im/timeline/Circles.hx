//
//  Circles Timeline
//
//  Created by Baluta Cristian on 2015-01-20.
//  Copyright (c) 2015 ralcr.com. All rights reserved.
//
package im.timeline;


class Circles extends RCView implements IMTimelineInterface {
	
	public var view :RCView;
	public var click :RCSignal<Int->Void>;
	
	var _path :String;
	var _files :Array<IMPhoto>;// Reference of the photos array, when the thumbs are loaded are cached here
	
	// Views
	var _background :RCRectangle;
	var _thumbsView :RCView; // Attach thumbs here
	var _thumbs :Array<RCControl>;
	var _separators :Array<RCRectangle>;
	var _slider :RCRectangle; // The slider indicates us where we are on the limeline
	
	var _nr :Int; // Currently displaying photo index
	
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
	
	
	override public function init () {
		
		super.init();
		addThumbs();
		
		var d = Math.round (4 + (isHorizontal() ? size.height : size.width));
		_slider = new RCRectangle (0, 0, d, d, _colorLink, 1.0, d);
		this.addChild ( _slider );
	}
	
	
	/**
	 * Add thumbs and separators between each thumb
	 */
	function addThumbs () :Void {
		
		_thumbs = new Array<RCControl>();
		var ts = thumbSize();
		
		// Iterate over files and create thumbs
		for (i in 0..._files.length) {
			
			var p = thumbPosition (i, ts);
			var thumb = new ThumbCircle (p.x, p.y, ts.width, ts.height, _path, _files[i], i+1);
				thumb.onClick = clickThumbHandler.bind ( i );
			_thumbs.push ( thumb );
			this.addChild ( thumb );
		}
	}
	
	function clickThumbHandler (nr:Int) {
		click.dispatch ( nr );
	}
	
	
	// Update the slider position in timeline
	
	public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) {
		_nr = currentItem;
		if (isHorizontal()) {
			_slider.x = Math.round (_thumbs[_nr].x + _thumbs[_nr].width / 2 - _slider.width/2);
			_slider.y = Math.round (_thumbs[_nr].height / 2 - _slider.height/2);
		}
		else {
			_slider.x = Math.round (_thumbs[_nr].width / 2 - _slider.width/2);
			_slider.y = Math.round (_thumbs[_nr].y + _thumbs[_nr].height / 2 - _slider.height/2);
		}
	}
	
	public function updateLoaderProgress (i:Int, percent:Int) {
		var thumb :ThumbCircle = cast(_thumbs[i], ThumbCircle);
		thumb.updateLoaderProgress ( percent );
	}
	
	
	// Utilities
	
	function thumbSize () :RCSize {
		
		if (isHorizontal()) {
			var len = Math.floor ( size.width / _files.length );
			var s = new RCSize ( (len < size.height) ? size.height : len, size.height );
			return s;
		}
		var len = Math.floor ( size.height / _files.length );
		var s = new RCSize ( size.width, (len < size.width) ? size.width : len );
		return s;
	}
	
	// The position of a given thumb in thumbsView. s is the 'segmentSize' of the thumb
	function thumbPosition (i:Int, s:RCSize) :RCPoint {
		if (isHorizontal()) {
			return new RCPoint ( s.width * i, 0 );
		}
		return new RCPoint ( 0, s.height * i );
	}
	
	
	// Returns the correct y of the slider depending on the y of the mouse
	
	public function getCorrectSliderX () :Int {
		var xm1 = 60;
		var xm2 = RCWindow.sharedWindow().width - 60;
		var xm  = 0;//Math.round ( Zeta.limitsInt (RCWindow.target.mouseX, xm1, xm2) );
		
		var x1  = Expandable.PADDING;
		var x2  = x1 - _thumbsView.width + RCWindow.sharedWindow().width - x1*2 - Expandable.PADDING*2;
		
		var x0 = Zeta.lineEquationInt (x1, x2, xm, xm1, xm2);
		return x0;
	}
	
	inline function isHorizontal () :Bool {
		return size.width > size.height;
	}
	
	public function expand () :Void {
		
	}
	
	public function resize (w:Int, h:Int) :Void {
		
	}
}
