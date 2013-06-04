//
//  Horizontal
//
//  Created by Baluta Cristian on 2011-07-08.
//  Copyright (c) 2012 ralcr.com. All rights reserved.
//
package v4.timeline;


class Vertical extends Expandable implements TimelineInterface {
	
	
	override public function init () :Void {
		
		// Recalculate the width of the timeline
		var h = ( thumbSize().height + 1 ) * files.length;// real length of the timeline
		clipsToBounds = true;
		
		// Add the slightly rounded background
		var r = Math.round (Config.ROUNDNESS / 2);
		background = new RCRectangle (0, 0, size.width, h, colorBackground, 0.6, r);
		this.addChild ( background );
		
		super.init();
	}
	
	
	
	// Update the slider position in timeline
	
	override public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) :Void {
		
		super.updateSliderPosition (currentItem, currentTime, slideshow_is_running);
		
		// If the timeline is expanded, and
		// If the mouse is not over the timeline area, try to center the current thumbnail in the visible area
		if (!mouseOver() && expanded)
		if (thumbsView.y + thumbs[nr].y > 2 + size.height - thumbs[nr].height ||
			thumbsView.y + thumbs[nr].y < 2)
		{
			thumbsView.y = 2 - thumbs[nr].y;
		}
		
		slider.x = Math.round (thumbs[nr].width / 2);
		slider.y = Math.round (thumbs[nr].y + thumbs[nr].height / 2);
	}
	
	
	
	
	// Utilities
	
	override function thumbSize () :RCSize {
		var len = Math.floor ( (size.height - files.length) / files.length );
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
		var x2  = x1 - thumbsView.width + RCWindow.sharedWindow().width - x1*2 - Expandable.PADDING*2;
		
		var x0 = Zeta.lineEquationInt (x1, x2, xm, xm1, xm2);
		return x0;
	}
	
}
