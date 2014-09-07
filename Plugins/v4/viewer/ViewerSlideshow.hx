//
//
//  Created by Baluta Cristian on 2008-12-24.
//  Copyright (c) 2008-2012 http://imagin.ro. All rights reserved.
//
package v4.viewer;

import haxe.Timer;
//import RCVideo;


@:keep class ViewerSlideshow extends ViewerBase implements ViewerInterface {
	
	inline static var TICK :Int = 50;
	
	var bg :RCRectangle;
	var background :RCRectangle;
	var transitionController :TransitionController;
	var timer :Timer;
	var maxCount :Int;
	var currentCount :Int;
	
	
	// After instantiation you should fill the properties from outside
	public function new () {
		trace("new SlideshowView() - PLUGIN");
		super (0, 0);
		view = this;// Required by the interface
	}
	
	
	/**
	*  Init the viewer
	*  file = the filename that should start the slideshow with. Optional parameter
	**/
	public function initWithFile (?file:String) {
		trace("init ( "+file+" )");
		//this.addChild ( bg = new RCRectangle (0,0, limits.size.width, limits.size.height, 0xff300, 0.2) );
		
		transitionController = new TransitionController ( limits );
		
		// Init the timer
		maxCount = (transition != "kenburns") ? Math.round (pause*1000 / TICK) : 0;
		currentCount = 0;
		trace("pause "+pause+" maxCount "+maxCount);
		
		trace("previewsLimits "+previewsLimits);trace(limits);
		// Draws a background under current photo.
		// This background creates visual animations between photos
		var background_color :Int = switch ( transition ) {
			case "colorburn" : 0xFFFFFF;
		 	case "colordodge" : 0x000000;
			default : colorBackgroundUnderPhoto == null ? 0x000000 : colorBackgroundUnderPhoto;
		}
		background = new RCRectangle (	previewsLimits.origin.x - limits.origin.x,
										previewsLimits.origin.y - limits.origin.y, 
										previewsLimits.size.width, 
										previewsLimits.size.height, 
										background_color);
		
		if (enableBackground)
			this.addChild ( background );
		
		if (file != null && file != "")
			slideshowIsRunning = false;
	}
	
	
	/**
	 *  Control the Slideshow
	 */
	public function startSlideshow () {
		trace("start slideshow and create timer");
		slideshowIsRunning = true;
		if (timer == null)
			timer = new Timer ( TICK );
			timer.run = timerTickHandler;
	}
	
	public function pauseSlideshow () {
		trace("pause slideshow");
		slideshowIsRunning = false;
		if (timer != null)
			timer.stop();
	}
	
	public function stopSlideshow () {
		trace("stop slideshow and remove timer");
		pauseSlideshow();
		currentCount = 0;
		if (timer != null)
			timer.stop();
			timer = null;
	}
	
	function timerTickHandler () {
		currentCount ++;
		tick.dispatch ( currentCount, maxCount );
		
		if (currentCount >= maxCount) {
			stopSlideshow();
			timerComplete.dispatch();
		}
	}
	
	
	/**
	 *	START A SLIDE CYCLE
	 *
	 *	1. Fade out current photo
	 *	2. Resize the background to next photo size
	 *	3. Fade in the next photo
	
	 *	transition - pass the transition to be used through the entire slide cycle
	 **/
	
	public function addPhoto (	prevPhoto:IMMediaViewerInterface,
								nextPhoto:IMMediaViewerInterface,
								mouseActioned:Bool)
	{
		
	}
	
	public function switchPhotos (	currentPhoto:IMMediaViewerInterface,
									nextPhoto:IMMediaViewerInterface,
									mouseActioned:Bool) :Void
	{
		var t = mouseActioned ? transition : transitionOnClick;
		trace("BEGIN A FADE CYCLE with transiton="+t);
		//transitionController.terminateAllTransitions();
		
		if (currentPhoto == null) {
			// This is the first photo loaded in the slideshow because currentPhoto didn't existed
			var speed = Zeta.isIn (transition, TransitionController.TRANSITIONS_WITH_BACKGROUND()) ? 0.6 : 0;
			resizeBackground (currentPhoto, nextPhoto, transition, speed);
			// Set the alpha of the background to 1 in a separate tween
			if (background.alpha < 1 && enableBackground)
			if (Zeta.isIn (t, TransitionController.TRANSITIONS_WITH_BACKGROUND().concat(["normal"])))
				RCAnimation.add ( new CATween (background, {alpha:1}, .6) );
		}
		else {
			// We have already a photo displaying, so this is not the first photo
			// Start the slide cycle by fading out the current photo
			fadeOut (currentPhoto, nextPhoto, t);
		}
	}
	
	function fadeOut (currentPhoto:IMMediaViewerInterface, nextPhoto:IMMediaViewerInterface, t:String) :Void {
		trace("1. fade out currentPhoto:"+currentPhoto+", nextPhoto:"+nextPhoto+", transition:"+t+", speed:"+speed);
		
		if (Zeta.isIn (t, TransitionController.TRANSITIONS_WITH_BACKGROUND().concat(["normal"]))) {
			// Fade out the current photo with the default transition for this slideshow
			currentPhoto.isTweening = true;
			transitionController.fadedOut = fadedOut.bind (currentPhoto, nextPhoto, t);
			transitionController.fadeOut (currentPhoto.view, transition, speed);
		}
		else {
			//if (t != "none") background.alpha = 0;
			// Fade out the current photo with a speed of 0
			transitionController.fadedOut = null;
			transitionController.fadeOut (currentPhoto.view, transition, 0);
			resizeBackground (currentPhoto, nextPhoto, t, 0);
		}
	}
	
	function fadedOut (currentPhoto:IMMediaViewerInterface, nextPhoto:IMMediaViewerInterface, t:String) :Void {
		trace("2. faded out currentPhoto:"+currentPhoto+", nextPhoto:"+nextPhoto+", transition:"+t);
		
		transitionController.fadedOut = null;
		currentPhoto.isTweening = false;
		
		// Current photo faded out, now remove it from display list
		currentPhoto.view.removeFromSuperview();
		
		// Continue with the resizing of the background
		resizeBackground (currentPhoto, nextPhoto, t, .6);
	}
	
	
	// Step 2: resize the background
	function resizeBackground (currentPhoto:IMMediaViewerInterface, nextPhoto:IMMediaViewerInterface, t:String, s:Float) :Void {
		trace("3. resize background currentPhoto:"+currentPhoto+", nextPhoto:"+nextPhoto+", transition:"+t);
		
		var frame :RCRect;
		
		// If we have kenburns transition, the background should stay at a fixed position
		if (t == "kenburns") {
			s = 0;
			frame = new RCRect (0, 0, limits.size.width, limits.size.height);
			background.alpha = 1;
		}
		// Place the background under the photo bounds
		else {
			frame = nextPhoto.view.bounds;
		}
		trace(background.bounds);
		trace(frame);
		// Cases when the background will resize without animation
		if (s != 0)
		if (enableBackground) {
			var dif_x = Math.abs (x - background.x);
			var dif_y = Math.abs (y - background.y);
			
			// Calculate the new speed depending on the longer axis to tween on
			s = (t == "fast")
			? 0
			: Zeta.lineEquation (.1, .6, (dif_x > dif_y ? dif_x : dif_y), 10, 160);
		}
		else s = 0;
#if flash
		// Remove the glow while the background is fading
		if (enableBackground && enableShadow && s >= .1)
			Fugu.glow (background, null, null, null);
#end
		// Resize the background
		var props = {x:frame.origin.x, y:frame.origin.y, width:frame.size.width, height:frame.size.height};
		var obj = new CATween (background, props, s, 0, eq.Cubic.IN_OUT);
			obj.animationDidStop = fadeIn;
			obj.arguments = [currentPhoto, nextPhoto, t];
		
		RCAnimation.add ( obj );
		//fadeIn(currentPhoto, nextPhoto, t);
	}
	
	
	// Step 3: fadeIn the next photo
	function fadeIn (currentPhoto:IMMediaViewerInterface, nextPhoto:IMMediaViewerInterface, t:String) :Void
	{
		trace("4. fadeIn currentPhoto:"+currentPhoto+", nextPhoto:"+nextPhoto+", transition:"+t);
		
		// add photo to the display list
		nextPhoto.view.alpha = 0;
		nextPhoto.view.resetScale();
		nextPhoto.view.scaleToFit (Math.round(limits.size.width), Math.round(limits.size.height));
		nextPhoto.view.x = Math.round ( (limits.size.width - nextPhoto.view.width)  / 2 );
		nextPhoto.view.y = Math.round ( (limits.size.height - nextPhoto.view.height) / 2 );
		this.addChild ( nextPhoto.view );
		
		// Indicate in timeline where we are
		timerTickHandler();
#if flash
		// Add again the glow to the margin of the photo
		if (enableBackground && enableShadow)
			Fugu.glow (background, 0x000000, 1, 12);
#end
		// Calculate the speed of fading in
		var s = speed;
		
		if (t == "fast") {
			s = .4;
			t = transition;
		}
		else if (t == "normal") {
			t = transition;
		}
		
		nextPhoto.isTweening = true;
		transitionController.fadedIn = fadedIn.bind (currentPhoto, nextPhoto);
		transitionController.fadeIn ( nextPhoto.view, t, s );
	}
	
	function fadedIn (currentPhoto:IMMediaViewerInterface, nextPhoto:IMMediaViewerInterface) :Void {
		trace("5. faded in currentPhoto:"+currentPhoto+", nextPhoto:"+nextPhoto);
		trace("END A FADE CYCLE ");
		
		nextPhoto.isTweening = false;
		transitionController.fadedIn = null;
		
		if (transition == "kenburns") {
			//timerCompleteHandler ( null );
		}
		else if (!nextPhoto.isVideo) {
			trace("slideshowIsRunning "+slideshowIsRunning);
			
			currentCount = 0;
			startSlideshow();
/*			if (slideshowIsRunning || true)
			if (timer != null)
			if (maxCount != 0) {
				currentCount = 0;
				timer.run = timerTickHandler;
			}
			else
				timerComplete.dispatch();*/
		}
		else {
			trace("we have video. startVideo()");
			// if we have video do not start the timer
			// wait the video to finish and then go to next photo directly
			nextPhoto.startVideo();
		}
		
		slideCycleFinished.dispatch();
	}
	// << END SLIDE CICLE
	
	
	/**
	 * When we resize the stage
	 */
	override public function resize (limits:RCRect) :Void {
		
		super.resize ( limits );
		
		if (bg != null) {
		bg.size = limits.size;
		bg.redraw();
		}
		// Center all loaded photos
		if (transition == "kenburns") {
			if (background != null) {
				background.x = 0;
				background.y = 0;
				background.width = limits.size.width;
				background.height = limits.size.height;
			}
		}
/*		else
			if (photosManager != null)
			if (photosManager.getFiles() != null)
				for (i in 0...photosManager.getFiles().length) {
					arrangePhoto ( i );
					
					var photo = photosManager.getPhoto( i );
					
					if (photo != null)
					if (photo.isLoaded && i == photosManager.getCurrentPhotoIndex() && background != null) {
						// Align the background to fit the current photo
						background.x = photo.view.x;
						background.y = photo.view.y;
						background.width = photo.view.width;
						background.height = photo.view.height;
					}
				}*/
	}
	
	// Called from photoManager after the photo is created, and each time the window resizes
	public function arrangePhoto (photo:IMMediaViewerInterface) :Void {
		
		if (photo != null && photo.isLoaded) {
			
			switch (scaleMode) {
				case "fit":	photo.view.scaleToFit ( Math.round(limits.size.width), Math.round(limits.size.height) );
				case "fill": photo.view.scaleToFill ( Math.round(limits.size.width), Math.round(limits.size.height) );
			}
			
			// Center the photo in the provided limits
			photo.view.x = Math.round ( (limits.size.width - photo.view.width) / 2 );
			photo.view.y = Math.round ( (limits.size.height - photo.view.height) / 2 );
		}
	}
	
	
	override public function destroy () :Void
	{
		stopSlideshow();
		Fugu.safeDestroy ( transitionController );
		transitionController = null;
		
		super.destroy();
	}
	
	// Don't do anything, this is a plugin
	public static function main () {
		Type.resolveClass("");// Hack to include the class definitions in the generated code
	}
	
}
