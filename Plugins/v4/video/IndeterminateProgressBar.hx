//
//  IndeterminateProgressBar
//
//  Created by Cristi Baluta on 2009-11-18.
//  Copyright (c) 2009 ralcr.com. All rights reserved.
//
package video;

import flash.events.Event;


class IndeterminateProgressBar extends RCView {
	
	var sprite :RCView;
	var r :Int;
	
	
	public function new (x, y, w, h, color:Int, a, r) {
		super(x, y, w, h);
		
		this.alpha = a;
		this.r = r;
		
		sprite = new RCView (0, 0);
		for (i in 0...Math.ceil(w/10)) {
			var e = new RCRectangle (i*30, -20, 20, 60, color);
				e.rotation = 20;
			sprite.addChild ( e );
		}
		this.addChild ( sprite );
		
		// Apply blur to the progress bar
/*		var filter = new flash.filters.GlowFilter (0x000000, 1, 3, 0, 0.6, 3, false, false);
		sprite.filters = [filter];*/
		
		setW ( Math.round(size.width) );
	}
	
	public function startProgress(){
		//this.addEventListener (Event.ENTER_FRAME, loop);
	}
	
	public function stopProgress(){
		//this.removeEventListener (Event.ENTER_FRAME, loop);
	}
	
	public function setW (w:Int) {
		size.width = w;
		clipsToBounds = true;
	}
	
	function loop (_) {
			sprite.x --;
		if (sprite.x <= -29)
			sprite.x = 0;
	}
}
