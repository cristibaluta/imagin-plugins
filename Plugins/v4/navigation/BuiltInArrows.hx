//
//  BuiltInArrows
//
//  Created by Baluta Cristian on 2009-03-18.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
/*skin_arrow_exit="0,0->4,0->14,10->24,0->28,0->28,4->18,14->28,24->28,28->24,28->14,18->4,28->0,28->0,24->10,14->0,4"
skin_arrow_navigation="0,12->2,9->19,9->14,4->17,0->30,12->17,24->14,20->19,15->2,15->0,12"
skin_start_slideshow="0,0->0,24->19,12"
skin_pause_slideshow="0,0->0,20->20,20->20,0"*/
	
package v4.navigation;

class BuiltInArrows {
	
	// Default skin for the exit arrow
	inline static var points_exit = [
					new RCPoint(0,0),
					new RCPoint(4,0),
					new RCPoint(14,10),
					new RCPoint(24,0),
					new RCPoint(28,0),
					new RCPoint(28,4),
					new RCPoint(18,14),
					new RCPoint(28,24),
					new RCPoint(28,28),
					
					new RCPoint(24,28),
					new RCPoint(14,18),
					new RCPoint(4,28),
					new RCPoint(0,28),
					new RCPoint(0,24),
					new RCPoint(10,14),
					new RCPoint(0,4)
				];
	
	// Default skin for the navigation arrow
	inline static var points_next = [
					new RCPoint(0,12),
					new RCPoint(2,9),
					new RCPoint(19,9),
					new RCPoint(14,4),
					new RCPoint(17,0),
					
					new RCPoint(30,12),
					
					new RCPoint(17,24),
					new RCPoint(14,20),
					new RCPoint(19,15),
					new RCPoint(2,15),
					new RCPoint(0,12)
				];
	//
	inline static var points_start_slideshow = [
					new RCPoint(0,0),
					new RCPoint(0,24),
					new RCPoint(19, 12)
				];
	//
	inline static var points_pause_slideshow = [
					new RCPoint(0,0),
					new RCPoint(0,20),
					new RCPoint(20,20),
					new RCPoint(20,0)
				];
	
	static var points :Hash<Array<RCPoint>>;
	
	
	public static function init () :Void {
		
		// Create a previous button from the next button but reversed
		var points_previous = new Array<RCPoint>();
		for (p in points_next) {
			var new_p = new RCPoint();
				new_p.x = 30 - p.x;
				new_p.y = p.y;
			points_previous.push ( new_p );
		}
		
		points = new Hash<Array<RCPoint>>();
		
		points.set ("skin_arrow_exit", points_exit);
		points.set ("skin_arrow_previous", points_previous);
		points.set ("skin_arrow_next", points_next);
		points.set ("skin_arrow_start", points_start_slideshow);
		points.set ("skin_arrow_pause", points_pause_slideshow);
	}
	
	public static function get (key:String) :Array<RCPoint> {
		return points.get( key );
	}
}
