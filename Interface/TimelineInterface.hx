//
//  ITimeline
//
//  Created by Baluta Cristian on 2009-08-16.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
interface TimelineInterface {

public var view :RCView;

public var click :RCSignal<Int->Void>;

public function init () :Void;
public function expand () :Void;
public function updateLoaderProgress (nr:Int, percent:Int) :Void;
public function updateSliderPosition (currentItem:Int, currentTime:Int, slideshow_is_running:Bool) :Void;
public function resize (w:Int, h:Int) :Void;
public function destroy () :Void;

}
