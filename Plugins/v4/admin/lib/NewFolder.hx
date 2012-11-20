//
//  New File
//
//  Created by Baluta Cristian on 2008-07-02.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin.lib;




class NewFolder extends TemplateDialog {
	
	var input_background :RCRectangle;
	var input :RCTextInput;
	var fs :FileSystem;
	
	
	public function new (x, y, w, h, path:String, message_str:String) {
		super(x, y, w, h, path, message_str);
	}
	
	override function init () {
		// Add text input
		input_background = new RCRectangle (10, 30, w-15, 18, 0x666666, 1, 5);
		this.addChild ( input_background );
		
		//
		input = new RCTextInput (10, 30, "",
								{format: FontManager.getTextFormat("default", {color : 0xFFFFFF}),
							 	 w:w-15, h:20, antiAliasType: flash.text.AntiAliasType.NORMAL}
								);
		input.textfield.multiline = false;
		this.addChild ( input );
		
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h - 20, 6, null, constructButton);
		menu.add ( ["Create", "Cancel"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		this.addChild ( menu );
	}
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		var label = e.label;
		
		switch (label) {
			case "Create": createDirectory();
			case "Cancel": cancel();
		}
	}
	
	
	
	//
	// creeaza folder nou pe server
	//
	function createDirectory () :Void {
		
		if (input.text == "") {
			addMessage ("Enter a name!");
			return;
		}
		addMessage ("Creating album...");
		trace(Config.API_DIR);
		trace(path + input.text);
		//return;
		fs = new FileSystem ( Config.API_DIR );
		fs.onComplete = onDirectoryCreated;
		fs.onError = onDirectoryError;
		fs.createDirectory ( path + input.text );
	}
	
	function onDirectoryCreated () :Void {trace(fs.result);
		addMessage ("Album created successfully!");
		input.text = "";
		onComplete();
	}
	
	function onDirectoryError () :Void {trace(fs.result);
		addMessage ("Error creating album! (" + fs.result + ")");
		onError();
	}
	
	
	
	
	// clean mess
	override public function destroy () : Void {
		
	}
}
