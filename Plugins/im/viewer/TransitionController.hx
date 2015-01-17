//
//  Transitions
//
//  Created by Baluta Cristian on 2007-08-04.
//  Copyright (c) 2007 http://imagin.ro. All rights reserved.
//
/*
Tweener transitions
Standard transitions
	* "linear"

Curve-based transitions
	* "easeInCubic", "easeOutCubic", "easeInOutCubic", "easeOutInCubic"
	
Mixed transitions
	* "colorBurn"
	* "colorDodge"
	* "zoomIn"
	* "zoomOut"
	* "KenBurns"
	* "dissolve"
	* "slide"
	* "fade"
	* "none"
*/
package im.viewer;

//import EnumTransition;


class TransitionController {
	
	inline public static function TRANSITIONS_WITH_BACKGROUND () :Array<String> { return ["colorburn", "colordodge", "fade", "pixelator"]; }
	
	public var limits :RCRect;
	var viewerIn :RCView;
	var viewerOut :RCView;
	
	dynamic public function fadedIn  () :Void {}
	dynamic public function fadedOut () :Void {}
	
	
	public function new ( limits : RCRect )
	{
		this.limits = limits;
	}
	
	
	
	public function fadeIn (viewer:RCView, transition:String, speed:Float) :Void {
		this.viewerIn = viewer;
		trace("fadeId, "+transition+", "+speed);
		
		switch ( transition.toLowerCase() ) {
		#if flash
			case "colorburn":	color (viewer, "colorBurnOut", speed, _fadedIn);
			case "colordodge":	color (viewer, "colorDodgeOut", speed, _fadedIn);
			case "pixelator":	pixelator (viewer, "pixelateOut", speed, eq.Cubic.OUT, _fadedIn);
		#end
			case "zoomin":		zoom (viewer, "zoomInIn", speed, _fadedIn);
			case "zoomout":		zoom (viewer, "zoomOutIn", speed, _fadedIn);
			case "kenburns":	kenBurns (viewer, speed, _fadedIn);
			case "slide":		fade (viewer, limits.size.width, (limits.size.width - viewer.width)/2, 0, 1, speed,
									eq.Cubic.IN_OUT, _fadedIn);
			case "dissolve":	fade (viewer, viewer.x, viewer.x, 0, 1, speed, eq.Linear.NONE, _fadedIn);
			case "fade":		fade (viewer, viewer.x, viewer.x, 0, 1, speed, eq.Cubic.OUT, _fadedIn);
			default:/*none*/	fade (viewer, viewer.x, viewer.x, 0, 1, 0, eq.Linear.NONE, _fadedIn);
		}
	}
	
	public function fadeOut (viewer:RCView, transition:String, speed:Float) :Void {
		this.viewerOut = viewer;
		trace("fadeOut, "+transition+", "+speed);
		
		switch ( transition.toLowerCase() ) {
		#if flash
			case "colorburn":	color (viewer, "colorBurnIn", speed, _fadedOut);
			case "colordodge":	color (viewer, "colorDodgeIn", speed, _fadedOut);
			case "pixelator":	pixelator (viewer, "pixelateIn", speed, eq.Cubic.IN, _fadedOut);
		#end
			case "zoomin":		zoom (viewer, "zoomInOut", speed, _fadedOut);
			case "zoomout":		zoom (viewer, "zoomOutOut", speed, _fadedOut);
			case "kenburns":	kenBurns (viewer, speed, _fadedOut);
			case "slide":		fade (viewer, (limits.size.width - viewer.width)/2, - viewer.width, 1, 0, speed,
									eq.Cubic.IN_OUT, _fadedOut);
			case "dissolve":	fade (viewer, viewer.x, viewer.x, 1, 0, speed, eq.Linear.NONE, _fadedOut);
			case "fade":		fade (viewer, viewer.x, viewer.x, 1, 0, speed, eq.Cubic.IN, _fadedOut);
			default:/*none*/	fade (viewer, viewer.x, viewer.x, 1, 0, 0, eq.Linear.NONE, _fadedOut);
		}
	}
	
#if flash
	/**
	 *	Animations that use color transformations
	 */
	function color (viewer:RCView,
					kindOfColorTransformation:String,
					speed:Float, F:Dynamic) :Void
	{
		Fugu.resetColor ( viewer );
		
		var obj = new CATColors (viewer, {color: kindOfColorTransformation}, speed);
			obj.animationDidStop = F;
			obj.timingFunction = eq.Cubic.IN_OUT;
			
		RCAnimation.add ( obj );
	}
	
	/**
	 *	Animations that use pixelator effect
	 */
	function pixelator (viewer:RCView, kindOfPixelation:String, speed:Float,
						timingFunction:Dynamic, F:Dynamic) :Void
	{
		Fugu.resetColor ( viewer );
		//catransitions.Pixelator.resetPixels ( activeCAObject );
		
		var properties = {pixelSize: kindOfPixelation};
		var obj = new CATPixelator (viewer, properties, speed);
			obj.timingFunction = timingFunction;
			obj.animationDidStop = F;
			
		RCAnimation.add ( obj );
	}
#end
	
	
	/**
	 *	Animations that use only fade effects and movement from a point to another
	 */
	function fade (	viewer:RCView,
					fromX:Float, toX:Float,
					fromA:Float, toA:Float,
					speed:Float, timingFunction:Dynamic, F:Dynamic) :Void
	{
		Fugu.resetColor ( viewer );
		
		var properties = {x:{fromValue:fromX, toValue:toX}, alpha:{fromValue:fromA, toValue:toA}};
		var obj = new CATween (viewer, properties, speed);
			obj.animationDidStop = F;
			obj.timingFunction = timingFunction;
			
		RCAnimation.add ( obj );
	}
	
	
	/**
	 *	Animations that use zoom effect
	 */
	function zoom (viewer:RCView, kindOfZoom:String, speed:Float, F:Dynamic) :Void
	{
		Fugu.resetColor ( viewer );
		
		var properties = {zoom: kindOfZoom};
		var obj = new CATZoom (viewer, properties, speed);
			obj.animationDidStop = F;
			obj.timingFunction = eq.Cubic.OUT;
			
		RCAnimation.add ( obj );
	}
	
	
	function kenBurns (viewer:RCView, speed:Float, F:Dynamic) :Void
	{
		Fugu.resetColor ( viewer );
		
		var properties = {};
		var obj = new CATKenBurns (viewer, properties, speed);
			obj.timingFunction = eq.Linear.NONE;
			obj.constraintBounds = new RCRect (0, 0, limits.size.width, limits.size.height);
			
		if (F == _fadedOut)
			obj.kenBurnsDidFadedIn = F;
		else
			obj.kenBurnsBeginsFadingOut = F;
			
		RCAnimation.add ( obj );
	}
	
	
	function _fadedIn  () { if (Reflect.isFunction(fadedIn))  fadedIn();  }
	function _fadedOut () { if (Reflect.isFunction(fadedOut)) fadedOut(); }
	
	
	// clean active transitions
	public function terminateLastTransition () :Void {
		RCAnimation.remove ( viewerIn );
		RCAnimation.remove ( viewerOut );
	}
	
	public function destroy () :Void {
		RCAnimation.remove ( viewerIn );
		RCAnimation.remove ( viewerOut );
	}
}
