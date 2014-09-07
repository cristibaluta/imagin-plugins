//
//  NavigationController.hx
//
//  Created by Baluta Cristian on 2009-02-25.
//  Copyright (c) 2009-2012 milc.ro. All rights reserved.
//
/*
	- none
	- gestures ->	the mouse will transform into a custom arrow
	- wheel ->	use the mouse wheel to navigate through photos
	- keyboard ->	use the arrow keys and escape to navigate
	- arrows ->	left button is placed on the left side of the photo, right button is placed in right, play and exit in middle
*/
package v4.navigation;


class NavigationController extends NavigationBase implements NavigationInterface {
	
	inline public static var NONE = "none";
	inline public static var GESTURES = "gestures";
	inline public static var GROUPED = "grouped";
	inline public static var ARROWS = "arrows";
	inline public static var KEYBOARD = "keyboard";
	inline public static var WHEEL = "wheel";
	inline public static var SCROLL = "scroll";
	
	
	var navigations :Array<NavigationBase>;
	
	
	public function new (mouseArea:RCRectangle) {
		trace("new NavigationController "+mouseArea);
		super ( mouseArea );
		
		navigations = new Array<NavigationBase>();
	}
	
	override public function init () {
		
		var navigationTypes = StringTools.replace ( Preferences.stringForKey("navigation").toLowerCase(), " ", "").split(",");
		
		for (nav in navigationTypes) {
			
			var navigation :NavigationBase = null;
			
			switch ( nav ) {
				
				case GESTURES:	navigation = new Gestures ( mouseArea );
				case ARROWS:	navigation = new Arrows ( mouseArea );
				case GROUPED:	navigation = new Grouped ( mouseArea );
				case KEYBOARD:	navigation = new Keys();
				case WHEEL:		navigation = new Wheel ( mouseArea );
				case SCROLL:	navigation = new Scroll ( mouseArea );
			}
			
			if (navigation != null) {
				
				navigation.onLeft = goLeft;
				navigation.onRight = goRight;
				navigation.onExit = goExit;
				navigation.onPause = goPause;
				navigation.onStart = goStart;
				navigation.onStop = goStop;
				navigation.onNumberSelected = goTo;
				
				addChild ( navigation.view );
				navigations.push ( navigation );
				navigation.init();
			}
			
		}
	}
	
	override public function resume () :Void {
		
		for(nav in navigations)
			nav.resume();
	}
	
	override public function hold () :Void {
		
		for(nav in navigations)
			nav.hold();
	}
	
	override public function resize (limits:RCRect) :Void {
		
		for(nav in navigations)
			nav.resize ( limits );
	}
	
	override public function destroy () :Void {
		
		Fugu.safeDestroy ( navigations );
		navigations = null;
		
		super.destroy();
	}
	
	
	// Don't do anything, this is a plugin
	public static function main () {
		Type.resolveClass("");// Hack to include the class definitions in the generated code
	}
	
}
