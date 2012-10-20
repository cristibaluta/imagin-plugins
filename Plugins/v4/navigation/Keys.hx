package v4.navigation;

import EnumDirection;


class Keys extends NavigationBase {
	
	var kb :RCKeys;
	
	public function new () {
		super ( null );
	}
	
	override public function init () {
		
		kb = new RCKeys();
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
