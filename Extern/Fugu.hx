//
//  Fugu
//
//  Created by Baluta Cristian on 2011-07-29.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class Fugu {
	public static function safeDestroy (obj:Dynamic, ?destroy:Null<Bool>, ?pos:haxe.PosInfos) :Bool {}
	public static function safeRemove (obj:Dynamic) :Bool {}
	public static function safeAdd (target:RCView, obj:Dynamic) :Bool {}
	public static function align (obj:RCView, alignment:String, constraint_w:Float, constraint_h:Float, ?obj_w:Null<Float>, ?obj_h:Null<Float>, ?delay_x:Int=0, ?delay_y:Int=0) :Void {}
	public static function glow (target:RCView, color:Null<Int>, alpha:Null<Float>, blur:Null<Float>, strength:Float=0.6) :Void {}
	public static function resetColor (target:RCView) :Void {}
	public static function brightness (target:RCView, brightness:Int) :Void {}
}
