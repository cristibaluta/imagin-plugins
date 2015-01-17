package im.navigation;

import EnumDirection;


class Keys extends NavigationBase {
	
	var kb :RCKeyboardController;
	
	public function new () {
		super ( null );
	}
	
	override public function init () {
		
		kb = new RCKeyboardController();
		kb.onLeft = goLeft;
		kb.onRight = goRight;
		kb.onUp = goLeft;
		kb.onDown = goRight;
		kb.onEsc = goExit;
		kb.onSpace = goPause;
		
	}
	
	override public function destroy () {
		Fugu.safeDestroy ( kb );
		kb = null;
		super.destroy();
	}
}
