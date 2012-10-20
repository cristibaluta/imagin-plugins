//
//  ITimeline
//
//  Created by Baluta Cristian on 2009-08-16.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
interface TimelineProtocol {

// You should realign the timeline while is zooming
public function timelineZooming (currentItem:Int) :Void;

// When you click a thumb in the timeline
public function timelineClick (currentItem:Int) :Void;

}
