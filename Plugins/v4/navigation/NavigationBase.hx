package v4.navigation;

import EnumDirection;


class NavigationBase extends RCView, implements NavigationInterface {
	
	public var view :RCView;
	var mouseArea :RCRectangle;
	
	dynamic public function onLeft () :Void {}
	dynamic public function onRight () :Void {}
	dynamic public function onExit () :Void {}
	dynamic public function onPause () :Void {}
	dynamic public function onStart () :Void {}
	dynamic public function onStop () :Void {}
	
	function goLeft () :Void { onLeft(); }
	function goRight () :Void { onRight(); }
	function goExit () :Void { onExit(); }
	function goPause () :Void { onPause(); }
	function goStart () :Void { onStart(); }
	function goStop () :Void { onStop(); }
	
	
	
	public function new (mouseArea:RCRectangle) {
		
		super (0, 0);
		
		this.mouseArea = mouseArea;
		this.view = this;
	}
	
	//public function init () {}
	public function resume () :Void {}
	public function hold () :Void {}
	public function resize (limits:RCRect) :Void {}
	
}
