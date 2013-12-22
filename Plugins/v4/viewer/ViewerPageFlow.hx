//
//
//  Created by Baluta Cristian
//  Copyright (c) 2013 http://imagin.ro. All rights reserved.
//
package v4.viewer;


@:keep class ViewerPageFlow extends ViewerBase implements ViewerInterface {
	
	
	// After instantiation you should fill the properties from outside
	public function new () {
		trace("new ViewerPageFlow");
		super (0, 0);
		
		view = this;// Required by the interface
		
		// This viewer does not support scrollbars, so deactivate it
		untyped RCWindow.sharedWindow().target.style.overflowY = "auto";
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
									mouseActioned:Bool) :Void
	{
		
/*		if (currentPhoto != null)
			currentPhoto.view.removeFromSuperview();*/
		
		// Add nextPhoto to the display list, resize and reposition it
		nextPhoto.view.alpha = 1;
		nextPhoto.view.resetScale();
		this.addChild ( nextPhoto.view );
		arrangePhoto ( nextPhoto );
		
		
		if (currentPhoto == null) nextPhoto.view.y = 0;
		else nextPhoto.view.y = currentPhoto.view.y + currentPhoto.view.height + 20;
		
		haxe.Timer.delay ( function(){ slideCycleFinished.dispatch(); }, 10);
	}
	
	
	// Called each time the window resizes
	public function arrangePhoto (photo:IMMediaViewerInterface) :Void {
		
		if (photo != null && photo.isLoaded) {
			
			switch (scaleMode) {
				case "fit":	photo.view.scaleToFit ( Math.round(limits.size.width), Math.round(limits.size.height) );
				case "fill": photo.view.scaleToFill ( Math.round(limits.size.width), Math.round(limits.size.height) );
			}
			
			// Align the photo in the provided limits
			Fugu.align (photo.view, alignmentPhotos, limits.size.width, limits.size.height, photo.view.width, photo.view.height);
			
		}
	}
	
	override public function resize (limits:RCRect) :Void {
		
		super.resize ( limits );
		
		
	}
	
	override public function destroy () :Void
	{	
		super.destroy();
	}
	
	
	// Don't do anything, plugins are instantiated from the master software when needed.
	public static function main(){
		Type.resolveClass("");// Hack to store in the $hxClasses the class names so they can be used with Type
	}
}
