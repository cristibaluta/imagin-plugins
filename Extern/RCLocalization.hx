//
//  RCLocalization
//
//  Created by Baluta Cristian on 2011-07-29.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class RCLocalization {
	
	public static var percentLoaded :Int;
	public static var hash :Hash<String>;
	//public static var list :RCLocalizationProxy;// Has autocomplete
	
	dynamic public static function onLoadComplete () :Void {}
	dynamic public static function onLoadProgress () :Void {}
	dynamic public static function onLoadError () :Void {}
	
	
	public static function init () :Void {}
	public static function loadDictionary (path:String) :Void {}
	public static function set (key:String, value:String) :Void {}
	public static function get (key:String) :String {}
	public static function clean () :Void {}
}