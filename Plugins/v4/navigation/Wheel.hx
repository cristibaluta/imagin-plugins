package v4.navigation;

import EnumDirection;


class Wheel extends NavigationBase, implements NavigationInterface {
	
	var mousew :EVMouse;
	var canDispatch :Bool;
	var timer :haxe.Timer;
	
	inline static var DELTA = 30;
	
	
	override public function init () {
		
		canDispatch = true;
		mousew = new EVMouse ( EVMouse.WHEEL, RCWindow.sharedWindow().target );
		mousew.add ( wheelHandler );
	}
	
	function wheelHandler (e:EVMouse) :Void {
		
		if (canDispatch) {
			
			if (e.delta > DELTA) {
				onLeft();
				canDispatch = false;
			}
			else if (e.delta < -DELTA) {
				onRight();
				canDispatch = false;
			}
		
			if (!canDispatch && timer == null) {
				timer = haxe.Timer.delay (canDispatchAgain, 700);
			}
		}
	}
	function canDispatchAgain () {
		canDispatch = true;
		timer = null;
	}
	
	
	override public function destroy () {
		
		Fugu.safeDestroy ( mousew );
		mousew = null;
		
		if (timer != null)
			timer.stop();
			timer = null;
		
		super.destroy();
	}
}
