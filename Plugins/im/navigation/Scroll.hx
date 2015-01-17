package im.navigation;

import EnumDirection;


class Scroll extends NavigationBase implements NavigationInterface {
	
	var mousew :EVMouse;
	var currentIndex :Int;
	var limits :RCRect;
	
	override public function init () {
		
		currentIndex = 0;
/*		mousew = new EVMouse ( EVMouse.WHEEL, RCWindow.sharedWindow().stage );
		mousew.add ( wheelHandler );*/
		
		js.Browser.window.addEventListener("scroll", scroll);
	}
	
	function scroll (evt) {
		var window_h = RCWindow.sharedWindow().height;
		var offset_y = js.Browser.window.pageYOffset;
		var p_h = limits.size.height > 600 ? 600 : limits.size.height;
		var index = Math.ceil ((offset_y - limits.origin.y) / (p_h + 20));
/*		trace('$currentIndex $index $offset_y $window_h ${limits.origin.y} ${limits.size.height}');*/
	
		if (index >= 0 && index < currentIndex) {
			currentIndex = index;
/*			onLeft();*/
			goTo(index);
		}
		else if (index > currentIndex) {
			currentIndex = index;
/*			onRight();*/
			goTo(index);
		}
	}
	
	function wheelHandler (e:EVMouse) {
		
/*		var window_h = RCWindow.sharedWindow().height;
		var offset_y = js.Browser.window.pageYOffset;
		var index = Math.floor ( offset_y / window_h);
		trace('$window_h $offset_y $index');

		if (index < currentIndex) {
			currentIndex = index;
			onLeft();
		}
		else if (index > currentIndex) {
			currentIndex = index;
			onRight();
		}*/
	}
	
	override public function resize (limits:RCRect) :Void {
		this.limits = limits;
	}
	
	override public function destroy () {
		
		Fugu.safeDestroy ( mousew );
		mousew = null;
		js.Browser.window.removeEventListener("scroll", scroll);
		
		super.destroy();
	}
}
