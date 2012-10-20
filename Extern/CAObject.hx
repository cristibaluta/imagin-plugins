//
//  CAProperties
//
//  Created by Baluta Cristian on 2009-03-22.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//

extern class CAObject {
	
	public var target :Dynamic;// The object that is animated (DisplayObjectContainer, TextField, Sound)
	public var prev :CAObject;// Previous object in the list
	public var next :CAObject;// Next object in the list
	
	// Properties to be animated:
	public var properties :Dynamic;
	public var fromValues :Dynamic;// initial values of the properties that are animated
	public var toValues :Dynamic;// final values of the properties that are animated
	
	// Parameters of the animation:
	public var fromTime :Float;// the starting time (ms)
	public var delay :Float;// s
	public var duration :Float;// s
	public var repeatCount :Int;
	public var autoreverses :Bool;
	public var timingFunction :Float -> Float -> Float -> Float -> Dynamic -> Float;
	public var modifierFunction :Float -> Void;//function used to modify values in HaxeGetSet transition
	public var constraintBounds :RCRect;// used by kenburns and slide
	public var delegate :CADelegate;
	
	
	public function new (	obj :Dynamic,
							properties :Dynamic,
							?duration :Null<Float>,
							?delay :Null<Float>,
							?Eq :Float -> Float -> Float -> Float -> Dynamic -> Float,
							?pos :haxe.PosInfos) :Void
	{}
	
	
	public function init () :Void {}
	public function animate (time_diff:Float) :Void {}
	public function initTime () :Void {}
	public function repeat () :Void {}
	public function calculate (time_diff:Float, prop:String) :Float {}
}
