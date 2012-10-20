//
//  DigitThumb
//
//  Created by Baluta Cristian on 2009-09-01.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package v4.timeline;


class ThumbDigit extends RCView {
	
	var background :RCRectangle;
	var indicator :RCPolygon;
	var photo :RCImage;
	
	public var orientation (null, setOrientation) :String;
	
	
	public function new (path:String) {
		super (0, 0);
		var backgroundColor :Int = Preferences.hexColorForKey ("color_background_timeline");
		
		var corner_roundness = Math.round (Config.ROUNDNESS / 2);
		var length = 65 + corner_roundness*2;
		background = new RCRectangle (-32 - corner_roundness, -65 - corner_roundness*2 - 10,
									length, length, backgroundColor, 0.9, corner_roundness);
		this.addChild ( background );
		
		var points = [ new RCPoint(0,0), new RCPoint(14,0), new RCPoint(7,10) ];
		var c1 = new RCPolygon (-7,-10, points, backgroundColor);
		this.addChild ( c1 );
		
		// Find the real path for the photo
		var url = new IMURLRequest ( path );
		
		photo = new RCImage (-32, -65 - corner_roundness - 10, url.getTimelineThumb ( path ));
		//photo.onComplete = onLoadHandler;
		//photo.onError = onErrorHandler;
		this.addChild ( photo );
	}
	
	function setOrientation (o:String) :String {
		return o;
	}
	
	
	override public function destroy () :Void {
		Fugu.safeDestroy ( photo );
		photo = null;
		super.destroy();
	}
}
