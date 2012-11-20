//
//  Upload
//
//  Created by Baluta Cristian on 2008-07-02.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin.lib;




class Rename extends TemplateDialog {
	
	var input_background :RCRectangle;
	var input : RCTextInput;
	var fs : FileSystem;
	var all_files_in_directory :Array<String>;
	var file_name :String;
	var extension :String;
	
	
	public function new (x, y, w, h, path:String, message_str:String) {
		super(x, y, w, h, path, message_str);
	}
	
	override function init () {
		
		input_background = new RCRectangle (10, 30, w-15, 18, 0x666666, 1, 5);
		this.addChild ( input_background );

		//
		input = new RCTextInput (10, 30, "",
								{format: FontManager.getTextFormat("default", {color : 0xFFFFFF}),
							 	 w: w-15, h:20, antiAliasType: flash.text.AntiAliasType.NORMAL}
								);
		input.textfield.multiline = false;
		this.addChild ( input );
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h - 20, 6, null, constructButton);
		menu.add ( ["Rename", "Cancel"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		this.addChild ( menu );
	}
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		switch (e.label) {
			case "Rename": startRename();
			case "Cancel": destroy(); cancel();
		}
	}
	
	
	function startRename () {
		
		if (Zeta.isIn (input.text, all_files_in_directory, "lowercase")) {
			addMessage ("Name already taken !");
			return;
		}
		addMessage ("Renaming...");
		
		fs = new FileSystem ( Config.API_DIR );
		fs.onComplete = onRenameComplete;
		fs.onError = onRenameError;
		trace(path + file_name);
		trace(path + input.text + (extension != null ? ("." + extension) : ""));
		fs.rename ( path + file_name, path + input.text + (extension != null ? ("." + extension) : "") );
		
	}
	
	function onRenameComplete () : Void {
		addMessage ("Renamed successfully !");
		haxe.Timer.delay (onComplete, 600);
	}
	function onRenameError () : Void {
		addMessage ("Error !");
	}
	
	/**
	 *	
	 */
	public function setFilesList (files:Array<String>) :Void {
		all_files_in_directory = files;
	}
	public function setFileName (name:String) :Void {
		extension = Zeta.isDirectory ( name ) ? null : name.split(".").pop();
		file_name = name;
		input.text = file_name.split( "." + extension ).shift();
	}
	
	// clean mess
	override public function destroy () :Void {
		Fugu.safeDestroy ( fs );
		fs = null;
	}
}
