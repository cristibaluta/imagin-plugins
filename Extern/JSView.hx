import js.Dom;

extern class JSView extends RCDisplayObject {
	
	public var layer :HtmlDom;
	public var parent :HtmlDom;
	
	public function new (x:Float, y:Float, ?w:Float, ?h:Float) :Void {}
	public function init () :Void {}
	
	public function setCenter (point:RCPoint) :RCPoint { }
	
	public function setX (x:Float) :Float { }
	public function setY (y:Float) :Float { }
	public function setWidth (w:Float) :Float { }
	public function setHeight (h:Float) :Float { }
	
	public function removeFromSuperView () :Void { }
}
