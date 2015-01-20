//
//  Circles Timeline
//
//  Created by Baluta Cristian on 2015-01-20.
//  Copyright (c) 2015 ralcr.com. All rights reserved.
//
package im.timeline;


class Circles extends Expandable implements IMTimelineInterface {
	
	
	override public function init () {
		
		// Recalculate the width of the timeline
		var h = ( thumbSize().height + 1 ) * _files.length;// real length of the timeline
/*		clipsToBounds = true;*/
		
		// Add the slightly rounded background
		var r = Math.round (IMConfig.ROUNDNESS / 2);
		_background = new RCRectangle (0, 0, size.width, h, _colorBackground, 0.6, r);
		this.addChild ( _background );
		
		super.init();
	}
	
	
	/**
	 * Add thumbs and separators between each thumb
	 */
	override function addThumbs () :Void {
		
		_thumbs = new Array<RCControl>();
		var ts = thumbSize();
		
		// Iterate over files and create thumbs
		for (i in 0..._files.length) {
			
			var p = thumbPosition (i, ts);
			var thumb = new ThumbCircle (p.x, p.y, ts.width, ts.height, _path, _files[i], i+1);
				thumb.onClick = clickThumbHandler.bind ( i );
			_thumbs.push ( thumb );
			_thumbsView.addChild ( thumb );
		}
	}
	
	
	// Update the slider position in timeline
	
	override public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) {
		
		super.updateSliderPosition (currentItem, currentTime, slideshow_is_running);
		
		// If the timeline is expanded, and
		// If the mouse is not over the timeline area, try to center the current thumbnail in the visible area
		if (!mouseOver() && _expanded)
		if (_thumbsView.y + _thumbs[_nr].y > 2 + size.height - _thumbs[_nr].height ||
			_thumbsView.y + _thumbs[_nr].y < 2)
		{
			_thumbsView.y = 2 - _thumbs[_nr].y;
		}
		
		_slider.x = Math.round (_thumbs[_nr].width / 2);
		_slider.y = Math.round (_thumbs[_nr].y + _thumbs[_nr].height / 2);
	}
	
	
	// Utilities
	
	override function thumbSize () :RCSize {
		var len = Math.floor ( (size.height - _files.length) / _files.length );
		var s = new RCSize ( size.width, (len < size.width) ? size.width : len );
		return s;
	}
	
	// The position of a given thumb in thumbsView. s is the 'segmentSize' of the thumb
	override function thumbPosition (i:Int, s:RCSize) :RCPoint {
		return new RCPoint ( 0, (s.height + 1) * i );
	}
	
	override function separatorSize () :RCSize {
		return new RCSize (2, 1);
	}
	
	override function separatorPosition (i:Int, s:RCSize) :RCPoint {
		return new RCPoint ( 2, (s.height + 1) * (i + 1) - 1 );
	}
	
	
	// Returns the correct y of the slider depending on the y of the mouse
	
	override public function getCorrectSliderX () :Int {
		var xm1 = 60;
		var xm2 = RCWindow.sharedWindow().width - 60;
		var xm  = 0;//Math.round ( Zeta.limitsInt (RCWindow.target.mouseX, xm1, xm2) );
		
		var x1  = Expandable.PADDING;
		var x2  = x1 - _thumbsView.width + RCWindow.sharedWindow().width - x1*2 - Expandable.PADDING*2;
		
		var x0 = Zeta.lineEquationInt (x1, x2, xm, xm1, xm2);
		return x0;
	}
	
}
