package im.navigation;


class Grouped extends NavigationBase implements IMNavigationInterface {
	
	var background :RCRectangle;
	var alignmentNavigation :String;
	
	
	public function new (mouseArea:RCRectangle) {
		alignmentNavigation = IMPreferences.stringForKey ("alignment_navigation");
		super( mouseArea );
	}

	override public function init () {
/*		addLeftButton( false );
		addExitButton( false );
		addRightButton( false );
		//if (SoundManager.exists()) addSoundButton();
		
		// Arrange the buttons ready for NORMAL navigation
		butLeft.x = 20 + butLeft.width/2;
		butExit.x = butLeft.x + butLeft.width + 20;
		butRight.x = butExit.x + butExit.width + 20;
		
		if (Session.get("viewer") == "slideshow")
			addPlayPauseButton ( Session.get ("slideshow_is_running") );
		
		// Add background under navigation buttons
		background = new RCRectangle (0, 0, this.width+40, this.height+20, colorBackground, .9, IMConfig.ROUNDNESS);
		this.addChildAt ( background, 0 );
		
		butLeft.y = butExit.y = butRight.y = Math.round (background.size.height / 2);
		
		if (butPlayPause != null)
			butPlayPause.y = 12;*/
	}
	
/*	override public function addPlayPauseButton (slideshow_is_running:Bool=false) :Void {
		super.addPlayPauseButton ( slideshow_is_running );
	}*/
	
	override public function resize (limits:RCRect) {
		
		Fugu.align (this, alignmentNavigation, Math.round(limits.size.width), Math.round(limits.size.height), null, null, 20, 25);
	}
	
}
