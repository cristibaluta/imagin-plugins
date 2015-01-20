package im.navigation;
import RCDevice;

class Arrows extends NavigationBase implements IMNavigationInterface {
	
	
	var butLeft :RCButton;
	var butRight :RCButton;
	var butExit :RCButton;
	var butPlayPause :RCButton;
	var butSound :RCButton;
	var butFullScreen :RCButton;
	
	
	override public function init () {
		
		addLeftButton();
		//addExitButton( false );
		addRightButton();
		
/*		mouse = new RCMouse ( RCWindow.target, mouseArea, mouseArea );
		mouse.onMiddle = showMiddle;
		mouse.onLeft = showLeft;
		mouse.onRight = showRight;*/
		//mouse.onOver = show;
		//mouse.onOut = hide;
		
		
/*		if (Session.get("viewer") == "slideshow") {
			
			addPlayPauseButton ( Session.get ("slideshow_is_running") );
			if (SoundManager.exists() && Session.get ("slideshow_is_running") == false)
				addSoundButton();
		}*/
	}
	
	/**
	 *	Add start/stop slideshow and sound buttons
	 */
	function addLeftButton () {
		
		var suffix = getSuffix();
		var s = new SkinButtonWithImage ( IMConfig.THEME_PATH + "ArrowLeft"+suffix+".png", IMConfig.THEME_PATH + "ArrowLeftHighlighted"+suffix+".png" );
		butLeft = new RCButton (0, 0, s);
		butLeft.onRelease = goLeft;
		this.addChild ( butLeft );
		butLeft.init();
	}
	
	function addRightButton () {
		
		var suffix = getSuffix();
		var s = new SkinButtonWithImage ( IMConfig.THEME_PATH + "ArrowRight"+suffix+".png", IMConfig.THEME_PATH + "ArrowRightHighlighted"+suffix+".png" );
		butRight = new RCButton (0, 0, s);
		butRight.onRelease = goRight;
		this.addChild ( butRight );
		butRight.init();
	}
	function getSuffix():String{
		return switch (RCDevice.currentDevice().type) {
			case IPhone : "-touch";
			case IPad : "-touch";
			case IPod : "-touch";
			case Android : "-touch";
			case WebOS : "-touch";
			case Mac : "";
			case Playstation : "";
			case Other : "";
		}
	}
	function addExitButton (?shadowed:Bool=true) {
/*		butExit = constructButtonNavigation ( new ArrowView ("skin_arrow_exit", colorArrow, shadowed) );
		butExit.onClick = exit;
		this.addChild ( butExit );*/
	}
	
	
	function addFullScreenButton () {
		// Add the fullscreen button only once

/*		if (IMPreferences.boolForKey("enable_fullscreen") && arr == null) {
			#if flash
				var o = new SkinEnterFullScreen (0, 0, 0xbbbbbb);
				var s = new SkinButtonWithObject (o, COLORS);
			#elseif js
				var s = new SkinButtonWithImage (IMConfig.THEME_PATH+"FullScreenOn.png");
			#end
			
			butFullScreen = new RCButton (RCWindow.sharedWindow().width - 21, 1, s);
			butFullScreen.onRelease = clickHandler.bind ("fullscreen");
			//IMAppDelegate.view.layerInfo.addChild ( butFullScreen );
			
			RCNotificationCenter.addObserver ("fullscreen", fullScreenHandler);
			fullScreenHandler();
		}*/
	}
	
	
	function showLeft () {
		hideMiddle();
		butLeft.alpha = 1;
		butRight.alpha = .4;
	}
	function showRight () {
		hideMiddle();
		butLeft.alpha = .4;
		butRight.alpha = 1;
	}
	function showMiddle () {
		Fugu.safeAdd ( this, butExit );
		Fugu.safeRemove ( [butLeft, butRight] );
	}
	function hideMiddle () {
		Fugu.safeRemove ( butExit );
		Fugu.safeAdd ( this, [butLeft, butRight] );
	}
	function show () {
		this.visible = true;
	}
	function hide () {
		this.visible = false;
	}
	
	/**
	 * Construct buttons
	 */
/*	function constructButtonNavigation (obj:ArrowView) :RCButton {
		var s = new SkinButtonWithArrow (obj, [null, null, colorArrow, colorArrowOver]);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	function constructButtonStartStop (obj:ArrowView) :RCButton {
		var s = new SkinButtonWithArrow (obj, [colorBackground, colorBackground,
														colorArrow, colorArrowOver]);
		var b = new RCButton (0, 0, s);
		return b;
	}
	function constructButtonSound (index:Int) :RCButton {
		var label = "";
		var s = new SkinRoundedButtonWithText (label, [colorBackground, colorBackground,
														colorArrow, colorArrowOver]);
		var b = new RCButton (0, 0, s);
		return b;
	}*/
	
	
/*	override function addExitButton () {
		if (Session.get("viewer") == "slideshow") {
			butExit = constructButtonSound ( RCLocalization.list.back );
			butExit.onClick = exit;
			this.addChild ( butExit );
		}
	}*/
	
	
	
	override public function resize  (limits:RCRect) {
		haxe.Timer.delay ( function(){ resize_(limits); }, 100);
	}
	function resize_ (limits:RCRect) {
		trace("resize "+limits);
		// x alignment
		if (limits.origin.x < 40) {
			butLeft.x = 0;
			butRight.x = Math.round (limits.origin.x * 2 + limits.size.width - 40);
		}
		else {
			butLeft.x = Math.round (limits.origin.x - butLeft.width - 20);
			butRight.x = Math.round (limits.origin.x + limits.size.width + 20);
		}
		
		// arrange buttons in the middle on Y axis
		butLeft.y = Math.round (limits.origin.y + (limits.size.height - butLeft.height) / 2);
		butRight.y = Math.round (limits.origin.y + (limits.size.height - butRight.height) / 2);
		/*
		if (butPlayPause != null) {
			butPlayPause.x = Math.round ( (limits.size.width - butPlayPause.size.width) / 2 );
			butPlayPause.y = Math.round ( (limits.size.height - butPlayPause.size.height) / 2 );
		}
		if (butSound != null) {
			butSound.x = butPlayPause.x;
			butSound.y = Math.round ( butPlayPause.y + butPlayPause.size.height + 10 );
		}
		if (butExit != null) {
			butExit.x = Math.round (limits.size.width / 2);
			butExit.y = (butSound != null)
						? Math.round ( butSound.y + butSound.size.height + 10 )
						: (butPlayPause != null)
							? Math.round ( butPlayPause.y + butPlayPause.height + 10 )
							: Math.round (limits.size.height / 2);
		}*/
	}
	
}
