// The properties a display object must have

extern class RCDisplayObject {
	
	public var viewWillAppear :RCSignal<Void->Void>;
	public var viewWillDisappear :RCSignal<Void->Void>;
	public var viewDidAppear :RCSignal<Void->Void>;
	public var viewDidDisappear :RCSignal<Void->Void>;
	
	
	// Properties of a View
	public var bounds (getBounds, setBounds) :RCRect; // Real size of the view
	public var size :RCSize; // Visible size of the layer. 
	public var center (default, setCenter) :RCPoint; // Position this view with the center
	public var clipsToBounds (default, setClipsToBounds) :Bool;
	public var backgroundColor (default, setBackgroundColor) :Null<Int>;
	public var x (getX, setX) :Float; // Animatable property
	public var y (getY, setY) :Float; // Animatable property
	public var width (getWidth, setWidth) :Float; // Real size of the layer, can be different than the bounds
	public var height (getHeight, setHeight) :Float; // Animatable property
	public var scaleX (getScaleX, setScaleX) :Float; // Animatable property
	public var scaleY (getScaleY, setScaleY) :Float; // Animatable property
	public var alpha (default, setAlpha) :Float; // Animatable property
	public var rotation (default, setRotation) :Float; // Animatable property
	public var visible (default, setVisible) :Bool;
	public var mouseX (getMouseX, null) :Float;
	public var mouseY (getMouseY, null) :Float;
	
	
	public function new () :Void {}
	
	public function scaleToFit (w:Int, h:Int) :Void {}
	
	public function scaleToFill (w:Int, h:Int) :Void {}

	public function scale (sx:Float, sy:Float) :Void {}
	
	public function resetScale () :Void {}
	
	public function addChild (child:RCView) :Void {}
	public function addChildAt (child:RCView, index:Int) :Void {}
	public function removeChild (child:RCView) :Void {}
	
	
	/**
	 *  Start an animation
	 **/
	public function addAnimation (obj:CAObject) :Void {}
	
	
	/**
	 *  Removes running animation, if any.
	 */
	public function destroy () :Void {}
	
}
