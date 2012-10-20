//
//  Settings
//
//  Created by Baluta Cristian on 2008-03-23.
//  Copyright (c) 2008 http://ralcr.com. All rights reserved.
//

extern class Config {
	
	public static var FIXED_W :Null<Int>;
	public static var FIXED_H :Null<Int>;
	
	// Path to pictures folder and scripts folder
	public static var TITLE :String;
	public static var PREFERENCES_PATH :String;
	public static var CONFIG_PATH :String;
	public static var API_DIR :String;
	public static var FILES_DIRECTORY :String;
	public static var PHOTOS_DIRECTORY :String;
	public static var FILES_PATH :String;
	public static var PHOTOS_PATH :String;
	public static var THEME_PATH :String;
	
	public static var COLORS_BUTTON_ADMIN1 :Array<Int>;
	public static var ROUNDNESS :Int;
	public static var RND :String;
	
	
	public static function init () :Void {}
}
