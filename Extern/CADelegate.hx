//
//  CADelegate
//
//  Created by Baluta Cristian on 2009-03-22.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
extern class CADelegate {
	
	public var animationDidStart :Dynamic;
	public var animationDidStop :Dynamic;
	public var animationDidReversed :Dynamic;
	public var arguments :Array<Dynamic>;// A list of objects to be passed when the animation state changes
	
	public var kenBurnsDidFadedIn :Dynamic;
	public var kenBurnsBeginsFadingOut :Dynamic;
	public var kenBurnsArgs :Array<Dynamic>;
	
	// For Ken Burns transition only
	public var startPointPassed :Bool;
	public var kenBurnsPointInPassed :Bool;
	public var kenBurnsPointOutPassed :Bool;
	public var kenBurnsPointIn :Null<Float>;// if not inited, they'll get some default values: 1/10 from total time
	public var kenBurnsPointOut :Null<Float>;
	public var pos :haxe.PosInfos;
	
	
	public function new () :Void {}
	public function start () :Void {}
	public function stop () :Void {}
	public function repeat () :Void {}
	public function kbIn () :Void {}
	public function kbOut () :Void {}
}
