//
//  Animation
//
//  Created by Baluta Cristian on 2008-09-28.
//  Copyright (c) 2008 ralcr.com. All rights reserved.
//
extern class CoreAnimation {
	
	public static var defaultTimingFunction = caequations.Linear.NONE;
	public static var defaultDuration = 0.8;
	
	public static function add (obj:CAObject) :Void {}
	public static function remove (obj:Dynamic) :Void {}
	public static function removeCAObject (a:CAObject) :Void {}
	public static function destroy () :Void {}
}
