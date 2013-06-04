//
//  Numbers
//
//  Created by Baluta Cristian on 2009-08-16.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package v4.timeline;


class Digits extends MenuBackground implements TimelineInterface {
	
	public var view :RCView;
	
	var path :String;
	var files :Array<Photo>;
	var digits :Array<RCButton>;
	var digitsRCView :RCView;
	var digitsMask :RCRectangle;
	var nr :Int; // currently displaying photo index
	var moving :Bool;
	var thumb :ThumbDigit;
	
	// from xml
	var COLORS :Array<Null<Int>>;
	var useBackground :Bool;
	var colorText :Int;
	var colorLink :Int;
	var colorBackground :Int;
	var fontType :String;
	
	inline static var THUMB_W :Int = 65;
	inline static var BG_HEIGHT :Int = 16;
	inline static var DIST :Int = 12;
	
	
	public function new (path:String, files:Array<Photo>) {
		super();
		
		this.size.width = w;
		this.path = path;
		this.files = files;
		this.nr = 0;
		this.moving = false;
		this.view = this;
		
		// settings from xml
		useBackground = Preferences.boolForKey ("enable_background_menu");
		fontType = Preferences.stringForKey ("font_type_menu");
		colorText = Preferences.hexColorForKey ("color_text");
		colorLink = Preferences.hexColorForKey ("color_highlighted");
		colorBackground = Preferences.hexColorForKey ("color_background_timeline");
		
		COLORS = [null, null, colorText, colorLink];
		
		init();
	}
	
	public function init () :Void {
		
		digitsRCView = new RCView (0, 0);
		digits = new Array<RCButton>();
		
		// Iterate over 
		for (i in 0...files.length) {
			var digit = buttonForLabel ( RCStringTools.add0 (i + 1) );
				digit.x = (i == 0) ? 0 : Math.round (digits[i-1].x + digits[i-1].width + 8);
				digit.alpha = 0.3;
				digit.onClick = clickHandler.bind (i);
				digit.onOver = showThumbnail.bind (i);
				digit.onOut = destroyThumbnail;
				
			digits.push ( digit );
			digitsRCView.addChild ( digit );
		}
		
		size.width = (digitsRCView.width < size.width)
		? Math.round (digitsRCView.width + (useBackground ? DIST*2 : 0))
		: size.width;
		size.height = fontType == "default" ? BG_HEIGHT : Math.round (digitsRCView.height - 6);
		
		if (useBackground) {
			super.redraw(); // Draw the background in super class
			
			digitsRCView.y = (fontType == "default") ? 0 : 2;
			digitsRCView.x = 12;
		}
		
		
		// Add mask over thumbs_mc at an offset of 2px
/*		digitsMask = new RCRectangle (useBackground ? 12 : 0, 0, size.width - (useBackground ? DIST*2 : 0), size.height, 0x000000);
		digitsRCView.mask = digitsMask;*/
		
		Fugu.safeAdd (this, [digitsRCView, digitsMask]);
		
		//this.setW ( _w );
	}
	function buttonForLabel (label:String) :RCButton {
		var s = new SkinButtonWithText (label, COLORS);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	
	function clickHandler (i:Int) :Void {
		//this.dispatchEvent ( new TimelineEvent (TimelineEvent.CLICK, i) );
	}
	function showThumbnail (i:Int) :Void {
		destroyThumbnail();
		thumb = new ThumbDigit (path + files[i].thumbURL);
		//RCWindow.target.addEventListener (EVMouse.MOVE, thumbFollowMouse);
		thumbFollowMouse( null );
		RCWindow.addChild ( thumb );
	}
	function destroyThumbnail () :Void {
		Fugu.safeDestroy ( thumb );
		thumb = null;
		//RCWindow.target.removeEventListener (EVMouse.MOUSE_MOVE, thumbFollowMouse);
	}
	
	function thumbFollowMouse (e:EVMouse) {
		//thumb.x = RCWindow.target.mouseX;
		//thumb.y = this.parent.y;
	}
	
	
	
	/**
	 * Update the progress bar of each thumb corespondingly with the percent loaded of the big picture
	 */
	public function updateLoaderProgress (nr:Int, percent:Int) :Void {
		digits[nr].alpha = Zeta.lineEquation (0.3, 1, percent, 0, 100);
	}
	
	// Update the slider position in timeline
	public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) {
		if (nr != currentItem) {
			//digits[nr].untoggle();
			nr = currentItem;
			//digits[nr].toggle();
		}
	}
	
	
	
	/**
	 * Check the position of the mouse every time we move it.
	 * So, zoom in or zoom out the thumbs
	 */
	function mouseMoveHandler (e:EVMouse) :Void {
		checkIfMouseIsOver()
		? {	if (!moving) startMove(); }
		: {	if (moving)  stopMove();  }
	}
	
	
	
	/**
	 * Zoom in the group of thumbs
	 */
	function startMove () :Void {
		stopMove(); // stop zoom out in case is runing
		moving = true;
		//this.addEventListener (EVMouse.MOUSE_MOVE, mouseHandler);
	}
	
	
	/**
	 * Zoom out the group of thumbs
	 */
	function stopMove () : Void {
		moving = false;
		//this.removeEventListener (EVMouse.MOUSE_MOVE, mouseHandler);
	}
	
	
	
	/**
	 * Position the slider when the mouse is moving
	 */
	function mouseHandler (e:EVMouse) :Void {
		//this.addEventListener (Event.ENTER_FRAME, slideThumbsHandler);
	}
	
	function slideThumbsHandler () :Void {
		
		if (digitsRCView.width < background.width) {
			//this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
			digitsRCView.x = Math.round ((RCWindow.sharedWindow().width - DIST*2)/2 - ((THUMB_W+1)*files.length) / 2);
			return;
		}
		
		var c_x = getCorrectSliderX();
		var next_x = digitsRCView.x + (c_x - digitsRCView.x) / 6;
		digitsRCView.x = Math.round ( next_x );
		
		//if (Math.abs (c_x - next_x) <= 1)
			//this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
	}
	
	
	
	// Returns the correct x of the slider depending on the x of the mouse
	function getCorrectSliderX () :Int {
		
		var xm1 = 60.0;
		var xm2 = background.width - 60;
		var xm  = 0;//Math.round ( Zeta.limitsInt (RCWindow.target.mouseX, xm1, xm2) );
		
		var x1  = DIST;
		var x2  = x1 - digitsRCView.width + background.width - x1*2;
		var x0 = Zeta.lineEquationInt (x1, x2, xm, xm1, xm2);
		
		return x0;
	}
	
	
	
	/**
	 *	Returns if we are on the background area
	 *	and no far than 30px on top of it
	 */
	function checkIfMouseIsOver () :Bool {
		return (this.mouseY > -10 && this.mouseY < this.height + 10)
		? { (this.mouseX > 0 && this.mouseX < digitsMask.width + DIST*2 + 20) ? true : false; }
		: false;
	}
	
	
	/*
	 * When the stage resizes, reposition all elements acordingly
	 */
	public function resize (w:Int, h:Int) :Void {
		//setW ( w );
		size.width = w;
		redraw();
	}
	public function setW (w:Int) :Void {
		
		size.width = (digitsRCView.width < w)
		? Math.round (digitsRCView.width + (useBackground ? DIST*2 : 0))
		: w;
		redraw();
		
		
		digitsMask.width = size.width - (useBackground ? DIST*2 : 0);
		
/*		if (digitsRCView.width > digitsMask.width)
			this.addEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
		else {
			this.removeEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
			if (useBackground) digitsRCView.x = 12;
		}*/
	}
	public function getW():Int {
		return Math.round(size.width);
	}
	
	public function expand () :Void {
		
	}
	
	
	
	
	
	// Clean mess
	override public function destroy () :Void {
		// Remove Listeners
		//this.removeEventListener (EVMouse.MOUSE_MOVE, mouseHandler);
		//this.removeEventListener (Event.ENTER_FRAME, slideThumbsHandler);
		//this.removeEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
		
		// Remove graphics
		Fugu.safeDestroy ( digits );
		digits = null;
		destroyThumbnail();
		super.destroy();
	}
}
