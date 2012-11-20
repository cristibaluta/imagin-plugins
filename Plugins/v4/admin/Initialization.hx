//
//  Init
//
//  Created by Baluta Cristian on 2009-01-13.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin;


class Initialization {
	
	dynamic public static function onComplete() :Void {}
	
	
	static public function start () {
		
		Config.init();
		
		// >> initialization process from bottom to top \\
		FontManager.onInit = init;
		FontManager.init();
	}
	
	static function init () {
		
		MacMouseWheel.setup ( RCWindow.target );
		RegisterFonts.init();
		onComplete();
	}
}
