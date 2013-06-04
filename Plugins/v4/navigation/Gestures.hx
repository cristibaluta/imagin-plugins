package v4.navigation;

import EnumDirection;


class Gestures extends NavigationBase implements NavigationInterface {
	
	//var cursor :RCCustomCursor;
	//var mouseg :RCGestureRecognizer;
	
	
	// Xml config
	var colorBackground :Null<Int>;
	var colorArrow :Null<Int>;
	var colorArrowOver :Null<Int>;// color used to change the color of the arrow at rollover
	
	
	
	public function new (mouseArea:RCRectangle) {
		
		super( mouseArea );
		config();
	}
	
	function config () {
		
/*		colorBackground = Preferences.hexColorForKey ("color_background_menu");
		colorArrow = Preferences.hexColorForKey ("color_arrow");
		colorArrowOver = Preferences.hexColorForKey ("color_highlighted");*/
	}
	
	override public function init () {
		
/*		mouse = new EVMouse ( RCWindow.target, mouseArea, mouseArea );
		mouse.onMiddle = cursorMiddle;
		mouse.onLeft = cursorLeft;
		mouse.onRight = cursorRight;
		mouse.onOver = showCustomCursor; // This will add the cursor
		mouse.onOut = hideCustomCursor; // This will remove the cursor
		*/
/*		mouseg = new RCGestureRecognizer ( RCWindow.target, mouseArea );
		mouseg.clickDragRightRelease = start;
		mouseg.clickDragLeftRelease = stop;
		mouseg.onClick = clickHandler;
		mouseg.onLeft = rotateCursorToLeft;
		mouseg.onRight = rotateCursorToRight;*/
	}
	
	
	
	/**
	 *	Add and remove cursor from the stage
	 */
	function showCustomCursor () :Void {
		
		//if (cursor != null) return;
		
		//cursor = new RCCustomCursor ( RCWindow.target );
/*		cursor.x = RCWindow.target.mouseX;
		cursor.y = RCWindow.target.mouseY;*/
		
		//RCWindow.addChild ( cursor );
		
/*		if (direction == right)
			cursorRight();
		else
			cursorLeft();*/
	}
	
	function hideCustomCursor () :Void {
/*		Fugu.safeDestroy ( cursor );
		cursor = null;*/
	}
	
	
	/**
	 *  RCMouse events
	 */
/*	function cursorMiddle () :Void {
		if (cursor == null) return;
		direction = middle;
		cursor.draw ( ArrowsManager.get("skin_arrow_exit") );
		//cursor.rotation = 0;
		showMiddleInfo();
	}
	function cursorLeft () :Void {
		if (cursor == null) return;
		direction = right;
		hideMiddleInfo();
		rotateCursorToLeft();
	}
	function cursorRight () :Void {
		if (cursor == null) return;
		direction = left;
		hideMiddleInfo();
		rotateCursorToRight();
	}
	*/
	
	
	/**
	 *	Gestures events
	 */
/*	override public function rotateCursorToLeft () :Void {
		if (mouseg == null || cursor == null || direction == middle) return;
		if (direction != left) {
			cursor.draw ( ArrowsManager.get("skin_arrow_previous") );
			direction = left;
		}
		mouseg.forceDirection ("left");
	}
	
	override public function rotateCursorToRight () :Void {
		if (mouseg == null || cursor == null || direction == middle) return;
		if (direction != right) {
			cursor.draw ( ArrowsManager.get("skin_arrow_next") );
			direction = right;
		}
		mouseg.forceDirection ("right");
	}
	*/
	
	
	
	
/*	function showMiddleInfo () {
		Fugu.safeAdd (this, [butPlayPause, butSound, butExit]);
	}
	function hideMiddleInfo () {
		Fugu.safeRemove ([butPlayPause, butSound, butExit]);
	}
	
	
	override public function addPlayPauseButton (slideshow_is_running:Bool=false) :Void {
		if (!slideshow_is_running) {
			super.addPlayPauseButton ( slideshow_is_running );
		}
	}*/
	
	override public function destroy () {
		//Fugu.safeDestroy ( [mouse, mouseg, cursor] );
		super.destroy();
	}
}
