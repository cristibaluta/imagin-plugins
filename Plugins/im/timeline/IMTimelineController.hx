//
//  TimelineController.hx
//
//  Created by Baluta Cristian on 2008-12-23.
//  Copyright (c) 2008-2012 http://imagin.ro. All rights reserved.
//
package im.timeline;


class IMTimelineController extends RCView implements IMTimelineInterface {
	
	public var view :RCView;
	
	var _path :String;
	var _files :Array<IMPhoto>;// Link to the photos array
	var _timeline :IMTimelineInterface;
	
	public var click :RCSignal<Int->Void>;
	
	// from xml
	var _enableThumbnails :Bool;
	var _timelineType :String;
	 
	
	public function new (path:String, files:Array<IMPhoto>) {
		
		super (0, 0);
		
		this._path = path;
		this._files = files;
		this.view = this;
		click = new RCSignal <Int->Void>();
		
		// settings from xml
		_enableThumbnails = IMPreferences.boolForKey ("enable_timeline_thumbnails");
		_timelineType = IMPreferences.stringForKey ("timeline").toLowerCase();
	}
	
	override public function init () :Void {
		
		super.init();
		
		switch (_timelineType) {
			//case "digits":		timeline = new Digits (size.width, size.height, path, files);
			case "vertical":		_timeline = new Vertical (_path, _files);
			case "horizontal":		_timeline = new Horizontal (_path, _files);
			case "circles":			_timeline = new Circles (_path, _files);
			case "simple":			_timeline = new Expandable (_path, _files);
									_enableThumbnails = false;
			case "expanded":		_timeline = new Expandable (_path, _files);
									expand();
			default:				_timeline = new Expandable (_path, _files);
		}
		
		if (_enableThumbnails) {
			_timeline.click.add ( clickHandler );
			//timeline.zooming.add ( zoomingHandler );
		}
		this.addChild ( _timeline.view );
		_timeline.view.size = size;
		_timeline.init();
	}
	
	function clickHandler (i:Int) {
		click.dispatch ( i );
	}
	
	
	// Timeline interface
	
	public function expand () :Void {
		if (_timeline != null)
			_timeline.expand();
	}
	
	public function updateLoaderProgress (nr:Int, percent:Int) :Void {
		if (_timeline != null)
			_timeline.updateLoaderProgress ( nr, percent );
	}
	
	public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) :Void {
		if (_timeline != null)
			_timeline.updateSliderPosition (currentItem, currentTime, slideshow_is_running);
	}
	
	public function resize (w:Int, h:Int) :Void {
		if (_timeline != null)
			_timeline.resize (w, h);
	}
	
	
	override public function destroy () :Void {
		
		Fugu.safeDestroy ( _timeline );
		_timeline = null;
		click.destroy();
		
		super.destroy();
	}
	
	
	// Don't do anything, plugins are instantiated from the main app
	public static function main () {
		Type.resolveClass("");// Hack to include the class definitions in the generated code
	}
	
}
