//
//
//  Created by Baluta Cristian
//  Copyright (c) 2013 http://imagin.ro. All rights reserved.
//
package im.viewer;


@:keep class ViewerPageFlow extends ViewerBase implements ViewerInterface {
	
	var ys :Map<Int,Float>;
	var already_scrolled :Bool;
	var bottomLine :RCRectangle;
	
	// After instantiation you should fill the properties from outside
	public function new () {
		trace("new ViewerPageFlow");
		super (0, 0);
		
		view = this;// Required by the interface
		ys = new Map<Int,Float>();
		
		// This viewer supports y scrollbar
		untyped RCWindow.sharedWindow().target.style.overflowY = "auto";
		
		bottomLine = new RCRectangle(0, 0, 10, 50, 0x000000);
		addChild ( bottomLine );
	}
	
	/**
	*  Init the viewer
	*  file = the filename that should start the slideshow with. Optional parameter
	**/
	public function initWithFile (?file:String) :Void {
		//trace("init ( "+file+" )");
		//view.clipsToBounds = false;
		timerComplete.dispatch();
	}
	
	
	/**
	 *  Control the Slideshow
	 */
	public function startSlideshow () :Void {
		trace("start slideshow and create timer");
	}
	
	public function pauseSlideshow () :Void {
		trace("pause slideshow");
	}
	
	public function stopSlideshow () :Void {
		trace("stop slideshow and remove timer");
	}
	
	
	/**
	 *	START A SLIDE CYCLE
	 *
	 *	1. Fade out current photo
	 *	2. Resize the background to next photo size
	 *	3. Fade in the next photo
	
	 *	transition - pass the transition to be used through the entire slide cycle
	 **/
	public function switchPhotos (	currentPhoto:IMMediaViewerInterface,
									nextPhoto:IMMediaViewerInterface,
									mouseActioned:Bool)
	{
		
	}
	
	public function addPhoto (	prevPhoto:IMMediaViewerInterface,
								nextPhoto:IMMediaViewerInterface,
								mouseActioned:Bool)
	{
		nextPhoto.view.alpha = 1;
		nextPhoto.view.resetScale();
		this.addChild ( nextPhoto.view );
		
		// First arrange the photo in the center of the page
		arrangePhoto ( nextPhoto );
		
		// Then reposition on Y axis to flow one after another
		var old_y :Null<Float> = ys.get(nextPhoto.index);
		
		if (old_y != null) {
			nextPhoto.view.y = old_y;
		}
		else if (prevPhoto == null) {
			// Appoximate position based on a fixed height
			nextPhoto.view.y = 0 + (nextPhoto.view.height + 20) * nextPhoto.index;
			ys.set(nextPhoto.index, nextPhoto.view.y);
			if (!already_scrolled) {
				js.Browser.window.scrollTo (0, Math.round(-70 + (nextPhoto.view.height + 20) * nextPhoto.index));
				already_scrolled = true;
			}
		}
		else {
			nextPhoto.view.y = prevPhoto.view.y + prevPhoto.view.height + 20;
			ys.set(nextPhoto.index, nextPhoto.view.y);
		}
		if (nextPhoto.view.y + nextPhoto.view.height > bottomLine.y) {
			bottomLine.y = nextPhoto.view.y + nextPhoto.view.height;
		}
/*		trace('photo ${nextPhoto.index} was added to y ${nextPhoto.view.y} $old_y');*/
		
		haxe.Timer.delay ( function(){ slideCycleFinished.dispatch(); }, 10);
	}
	
	// Called each time the window resizes
	public function arrangePhoto (photo:IMMediaViewerInterface) {
		
		if (photo != null && photo.isLoaded) {
			
			switch (scaleMode) {
				case "fit":	photo.view.scaleToFit ( Math.round(limits.size.width), Math.round(limits.size.height) );
				case "fill": photo.view.scaleToFill ( Math.round(limits.size.width), Math.round(limits.size.height) );
			}
			
			// Align the photo in the provided limits
			Fugu.align (photo.view, alignmentPhotos, limits.size.width, limits.size.height, photo.view.width, photo.view.height);
		}
	}
	
	override public function resize (limits:RCRect) {
		super.resize ( limits );
	}
	
	override public function destroy () {	
		super.destroy();
	}
	
	
	// Don't do anything, plugins are instantiated from the master software when needed.
	public static function main(){
		Type.resolveClass("");// Hack to store in the $hxClasses the class names so they can be used with Type
	}
}
