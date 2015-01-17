//
//  App
//
//  Created by Baluta Cristian on 2008-12-26.
//  Copyright (c) 2008 http://ralcr.com. All rights reserved.
//
package video;

class MainVideoDesktop {
	
	static var window: swhx.Window;
	static var flash: swhx.Flash;
	
	
	static function main () {
		
		swhx.Application.init();
		window = new swhx.Window ("ImaginVideo", 800, 500/*,swhx.Window.WF_FULLSCREEN |
														swhx.Window.WF_TRANSPARENT |
														swhx.Window.WF_ALWAYS_ONTOP |
														swhx.Window.WF_NO_TASkinBAR*/);
		
		window.visible = false;
		//window.fullscreen = true;
		window.onRightClick = function() :Bool { return false; }// disable the system right click
		
		var context = new haxe.remoting.Context();
		context.addObject ("MainVideoDesktop", MainVideoDesktop);
		
		flash = new swhx.Flash (window, context);
		flash.setAttribute ("src", "imaginVideo.swf");
		flash.onConnected = callTest;
		flash.start();
#if win
		//new systools.win.Tray (window, "old_clock.ico", "Imagin Photo Gallery");
#end
		swhx.Application.loop();
		swhx.Application.cleanup();
	}
	
	
	/**
	 *	Calls to flash
	 */
	static function callTest () :Void {
		// connect to flash
/*		var cnx = swhx.Connection.flashConnect (flash);
		// call Flash.test(5,7)
		var r : Int = cnx.Flash.test.call ([5,7]);
		// display result
		systools.Dialogs.message("Result","The result is "+r,false);*/
	}
	
	
	
	/**
	 *	Calls from flash
	 */
	
	static function fullscreen () :Void {
		window.fullscreen = true;
	}
	
	static function normal () :Void {
		window.fullscreen = false;
	}
	
	static function isFullScreen () :Bool {
		return window.fullscreen;
	}
	
	
	static function getCwd () :String {
		return neko.Sys.getCwd();
	}
	
	static function setCwd (path:String) :Void {
		return neko.Sys.setCwd ( path );
	}
	
	static function readDirectory (directory:String) :Array<String> {
		var files2 = new Array<String>();
		var files :Array<String> = neko.FileSystem.readDirectory( directory );
		var not_allowed_to_read = ['.', '..', '.DS_Store', '_vti_cnf', 'Thumbs.db', '_thumb.jpg'];
		var thumb_sufix = ".th.";
		
		for (file in files) {
			var good :Bool = true;
			
			// Checking 1
			for (file2 in not_allowed_to_read)
				if (file.toLowerCase() == file2.toLowerCase())
					good = false;
			
			// Checking 2
			if (file.toLowerCase().indexOf ( thumb_sufix ) != -1)
				good = false;
			
			if (good)
				files2.push ( file );
		}
		
		return files2;
	}
	
	static function show (w:Int, h:Int) {
		window.visible = true;
		window.width = w;
		window.height = h;
	}
	
	static function hide () {
		window.visible = false;
	}
	
	static function quit () {
		window.destroy();
		swhx.Application.exitLoop();
	}
	
}
