// Simple implementation of the Signal events system

extern class RCSignal<T> {
	
	public var enabled :Bool;
	
	
	public function new () :Void {}
	
	/**
	*  Add a listener to this signal
	*/
	public function add (listener:T) :Void {}
	public function addOnce (listener:T, ?pos:haxe.PosInfos) :Void {}
	// Useful for native components, this listener will be called first
	public function addFirst (listener:T, ?pos:haxe.PosInfos) :Void {}
	public function remove (listener:T) :Void {}
	public function removeAll() :Void {}
	
	
	public function dispatch (?p1:Dynamic, ?p2:Dynamic, ?p3:Dynamic, ?p4:Dynamic, ?pos:haxe.PosInfos) :Void {}
	
	public function exists (listener:T) :Bool {}
	
	public function destroy () :Void {}
}
