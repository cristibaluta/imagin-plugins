//
//  New File
//
//  Created by Baluta Cristian on 2008-07-02.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin.lib;




class Delete extends TemplateDialog {
	
	var fs : FileSystem;
	
	
	public function new (x, y, w, h, path:String, message_str:String) {
		super(x, y, w, h, path, message_str);
	}
	
	override function init () {
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h - 20, 6, null, constructButton);
		menu.add ( ["Delete", "Cancel"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		this.addChild ( menu );
	}
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		var label = e.label;
		
		switch (label) {
			case "Delete": deleteDirectory();
			case "Cancel": cancel();
		}
	}
	
	
	
	//
	//	Analyze what to delete, a folder or a file
	//
	function deleteDirectory () :Void {
		
		fs = new FileSystem ( Config.API_DIR );
		fs.onComplete = onDirectoryDeleted;
		fs.onError = onDirectoryError;
		
		if (Zeta.isDirectory( path )) {
			addMessage ("Deleting album...");
			fs.deleteDirectory ( path );
		}
		else {
			addMessage ("Deleting file...");
			fs.deleteFile ( path );
		}
	}
	
	function onDirectoryDeleted () :Void {trace(fs.result);
		addMessage ("Deleted successfully!");
		onComplete();
	}
	
	function onDirectoryError () :Void {trace(fs.result);
		addMessage ("Error deleting ! (" + fs.result + ")");
		onError();
	}
	
	
	
	
	// clean mess
	override public function destroy () : Void {
		
	}
}
