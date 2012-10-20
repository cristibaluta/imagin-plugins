//
//  MainVideo
//
//  Created by Baluta Cristian on 2011-07-25.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//
package video;

extern class MainVideo extends flash.display.RCView {
	public function new():Void;
	public function startVideo (URL:String, ?file:String=null):Void;
	public function pauseVideo():Void;
	public function resumeVideo():Void;
	public function destroy():Void;
}
