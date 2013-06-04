//
//  Arrows
//
//  Created by Baluta Cristian on 2009-03-18.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package v4;

import ArrowView;
import BuiltInArrows;


class ArrowsManager {
	
	inline static public var EXIT = "skin_arrow_exit";
	inline static public var PREV = "skin_arrow_previous";
	inline static public var NEXT = "skin_arrow_next";
	inline static public var PLAY = "skin_arrow_start";
	inline static public var PAUSE = "skin_arrow_pause";
	inline static function KEYS () :Array<String> { return [EXIT, PREV, NEXT, PLAY, PAUSE]; }
	static var arrows :Hash<ArrowView>;
	
	
	public static function init () :Void {
		BuiltInArrows.init();// init the points that construct an arrow
		arrows = new Hash<ArrowView>();
		var color :Int = Preferences.hexColorForKey ("color_arrow");
		
		for (key in KEYS) set (key, new ArrowView(key, color, true));
	}
	
	public static function set (key:String, arrow:ArrowView) :Void {
		arrows.set (key, arrow);
	}
	
	public static function get (key:String) :ArrowView {
		return arrows.get ( key );
	}
}
