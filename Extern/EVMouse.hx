extern class EVMouse extends RCSignal<EVMouse->Void> {
	
	public static var UP :String;
	public static var DOWN :String;
	public static var OVER :String;
	public static var OUT :String;
	public static var MOVE :String;
	public static var CLICK :String;
	public static var DOUBLE_CLICK :String;
	public static var WHEEL :String;
	
	public var target :Dynamic;// The original object
	public var type :String;
	//public var e :MouseEvent;
	public var delta :Int;
	
	
	public function new (type:String, target:Dynamic, ?pos:haxe.PosInfos) :Void {}
}