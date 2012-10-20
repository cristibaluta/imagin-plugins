//
//  RCStringTools
//
//  Created by Baluta Cristian on 2011-07-29.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class RCStringTools {
	
	public static function add0 (nr:Int) :String {}
	public static function formatTime (t:Float) :String {}
	public static function cutString (str:String, limit:Int) :String {}
	public static function cutStringAtLine (textfield:flash.text.TextField, line:Int) :String {}
	public static function stringWithFormat (str:String, arr:Array<Dynamic>) :String {}
    public static function toTitleCase (str:String) :String {}
	public static function addSlash (str:String) :String {}
	public static function validateEmail (email:String) :Bool {}
	public static function encodeEmail (email:String, ?replacement:String="[-AT-]") :String {}
	public static function decodeEmail (email:String, ?replacement:String="[-AT-]") :String {}
	public static function parseLinks (str:String) :String {}
	public static function removeLinks (str:String) :String {}
}
