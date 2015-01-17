//
//  Arrow
//
//  Created by Baluta Cristian on 2008-12-02.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package im.navigation;

class ArrowView extends RCView {
	
	var arrow :Dynamic;// RCImage, RCPolygon
	
	
	public function new (key:String, color:Int, ?shadowed:Bool=true) {
		super(0,0,0,0);
		#if flash
			layer.mouseChildren = false;
			layer.mouseEnabled = false;
			layer.cacheAsBitmap = true;
		#end
		
		// Get the built in skin_arrow
		var points = BuiltInArrows.get( key );
		
		// Check if another skin_arrow exists in _preferences.xml
		var skin :String = IMPreferences.stringForKey ( key );
		
		if (Zeta.isIn (skin, ".png", "end")) {
			// Load the arrow from external file
			arrow = new RCImage (0, 0, IMConfig.FILES_PATH + "themes/"+IMConfig.THEME+"/arrows/" + skin);
			arrow.onComplete = centerArrow;
			this.addChild ( arrow );
			return;
		}
		else if (skin.length >= 13 && skin != "default") {
			// 13 is the minimim number of characters for a valid arrow
			// Extract from preferences.xml the new points that should be used to draw the arrow
			var point :Array<String> = skin.split("->");
			points = new Array<RCPoint>();
			
			for (p in point) {
				var pxy :Array<String> = p.split(",");
				points.push ( new RCPoint (Std.parseInt( pxy[0] ), Std.parseInt( pxy[1] )) );
			}
		}
		
		// Draw the arrow
		arrow = new RCPolygon (0, 0, points, color);
		centerArrow();// Center the arrow then add the shadow
		this.addChild ( arrow );
		
		if (shadowed) {
			var shadow = new RCPolygon (arrow.x, arrow.y + 2, points, 0x000000);
			this.addChildAt ( shadow, 0 );
		}
	}
	
	function centerArrow () {
		arrow.x = - Math.round (arrow.width  / 2);
		arrow.y = - Math.round (arrow.height / 2);
	}
}
