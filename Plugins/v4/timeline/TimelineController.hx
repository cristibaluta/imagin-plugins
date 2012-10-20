//
//  TimelineController.hx
//
//  Created by Baluta Cristian on 2008-12-23.
//  Copyright (c) 2008-2012 http://imagin.ro. All rights reserved.
//
package v4.timeline;


class TimelineController extends RCView, implements TimelineInterface {
	
	public var view :RCView;
	
	var path :String;
	var files :Array<Photo>;// Link to the photos array
	var timeline :TimelineInterface;
	
	public var click :RCSignal<Int->Void>;
	
	// from xml
	var enableThumbnails :Bool;
	var timelineType :String;
	 
	
	public function new (path:String, files:Array<Photo>) {
		
		super (0, 0);
		
		this.path = path;
		this.files = files;
		this.view = this;
		click = new RCSignal <Int->Void>();
		
		// settings from xml
		enableThumbnails = Preferences.boolForKey ("enable_timeline_thumbnails");
		timelineType = Preferences.stringForKey ("timeline").toLowerCase();
	}
	
	override public function init () :Void {
		
		super.init();
		
		switch (timelineType) {
			//case "digits":		timeline = new Digits (size.width, size.height, path, files);
			case "vertical":		timeline = new Vertical (path, files);
			case "horizontal":		timeline = new Horizontal (path, files);
			case "timeline":		timeline = new Expandable (path, files);
									enableThumbnails = false;
			case "expanded":		timeline = new Expandable (path, files);
									expand();
			default:				timeline = new Expandable (path, files);
		}
		
		if (enableThumbnails) {
			timeline.click.add ( clickHandler );
			//timeline.zooming.add ( zoomingHandler );
		}
		this.addChild ( timeline.view );
		timeline.view.size = size;
		timeline.init();
	}
	
	function clickHandler (i:Int) {
		click.dispatch ( i );
	}
	
	// Timeline interface
	
	public function expand () :Void {
		if (timeline != null)
			timeline.expand();
	}
	
	public function updateLoaderProgress (nr:Int, percent:Int) :Void {
		if (timeline != null)
			timeline.updateLoaderProgress ( nr, percent );
	}
	
	public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) :Void {
		trace("updateSliderPosition "+currentItem);
		if (timeline != null)
			timeline.updateSliderPosition (currentItem, currentTime, slideshow_is_running);
	}
	
	public function resize (w:Int, h:Int) :Void {
		if (timeline != null)
			timeline.resize (w, h);
	}
	
	
	override public function destroy () :Void {
		
		Fugu.safeDestroy ( timeline );
		timeline = null;
		click.destroy();
		
		super.destroy();
	}
	
	
	// Don't do anything, plugins are instantiated from the main app
	public static function main(){ RCLog.redirectTraces(); }
	
}