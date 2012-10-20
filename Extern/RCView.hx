#if flash

extern class RCView extends RCDisplayObject {
	
	public var layer :flash.display.Sprite;
	public var parent :flash.display.Sprite;
	
	public function new (x:Float, y:Float, ?w:Float, ?h:Float) :Void {}
	
	public function setCenter (point:RCPoint) :RCPoint { }
	
	public function setX (x:Float) :Float { }
	public function setY (y:Float) :Float { }
	public function setWidth (w:Float) :Float { }
	public function setHeight (h:Float) :Float { }
	
	public function removeFromSuperView () :Void { }
}

#elseif js
	
	typedef RCView = JSView;

#end