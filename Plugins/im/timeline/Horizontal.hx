//
//  Horizontal
//
//  Created by Baluta Cristian on 2011-07-08.
//  Copyright (c) 2012 ralcr.com. All rights reserved.
//
package im.timeline;


class Horizontal extends Expandable implements TimelineInterface {
	
	
	override public function init () :Void {
		
		// Recalculate the width of the timeline
		var w = ( thumbSize().width + 1 ) * files.length;// real length of the timeline
		clipsToBounds = true;
		
		// Add the slightly rounded background
		var r = Math.round (IMConfig.ROUNDNESS / 2);
		background = new RCRectangle (0, 0, w, size.height, colorBackground, 1, r);
		this.addChild ( background );
		
		super.init();
	}
	
	
	
	
	// Update the slider position in timeline
	
	override public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) :Void {
		
		super.updateSliderPosition (currentItem, currentTime, slideshow_is_running);
		
		// If the timeline is expanded, and
		// If the mouse is not over the timeline area, try to center the current thumbnail in the visible area
		if (!mouseOver() && expanded)
		if (thumbsView.x + thumbs[nr].x > 2 + size.width - thumbs[nr].width ||
			thumbsView.x + thumbs[nr].x < 2)
		{
			thumbsView.x = 2 - thumbs[nr].x;
		}
		
		slider.x = Math.round (thumbs[nr].x + thumbs[nr].width / 2);
	}
	
	
	
	
	// Utilities
	
	override function thumbSize () :RCSize {
		var len = Math.floor ( (size.width - files.length) / files.length );
		return new RCSize ( (len < size.height) ? size.height : len, size.height);
	}
	
	// The position of a given thumb in thumbsView. s is the 'segmentSize' of the thumb
	override function thumbPosition (i:Int, s:RCSize) :RCPoint {
		return new RCPoint ((s.width + 1) * i, 0);
	}
	
	override function separatorSize () :RCSize {
		return new RCSize (1, 2);
	}
	override function separatorPosition (i:Int, s:RCSize) :RCPoint {
		return new RCPoint ((s.width + 1) * (i + 1) - 1, 2);
	}
	
	
	
	// Returns the correct x of the slider depending on the x of the mouse
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
