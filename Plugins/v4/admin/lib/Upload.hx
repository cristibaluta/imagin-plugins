//
//  Upload
//
//  Created by Baluta Cristian on 2008-07-02.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin.lib;




class Upload extends TemplateDialog {
	
	var input_background :RCRectangle;
	var input : RCTextInput;
	var ft :FileTransfer;
	var unique_name :String;
	var extension :String;
	
	
	public function new (x, y, w, h, path:String, message_str:String) {
		super(x, y, w, h, path, message_str);
	}
	
	override function init () {
		// upload script
		ft = new FileTransfer ( Config.API_DIR );
		ft.onSelect = onBrowseHandler;
		ft.onProgress = onUploadProgress;
		ft.onComplete = onUploadComplete;
		ft.onError = onUploadError;
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h - 20, 6, null, constructButton);
		menu.add ( ["Browse", "Upload", "Cancel"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		menu.disable ("Upload");
		this.addChild ( menu );
	}
	
	function onBrowseHandler () : Void {
		
		extension = ft.name.split(".").pop();
		// Add text input to change the name of the uploaded file
		if (input == null) {
			input_background = new RCRectangle (10, 40, w-15, 18, 0x666666, 1, 5);
			this.addChild ( input_background );

			//
			input = new RCTextInput (10, 40, unique_name == null ? ft.name : unique_name,
									{format: FontManager.getTextFormat("default", {color : 0xFFFFFF}),
								 	 w:w-15, h:20, antiAliasType: flash.text.AntiAliasType.NORMAL}
									);
			input.textfield.multiline = false;
			this.addChild ( input );
		}
		
		addMessage ("Rename the file if you want !");
		menu.enable ("Upload");
	}
	
	function startUpload () : Void {
		addMessage ("Starting...");
		menu.disable ("Browse");
		ft.upload ( path, input.text + "." + extension );
	}
	
	function onUploadProgress () : Void {
		addMessage ("Uploading... ( " + ft.percentLoaded + " % )");
	}
	
	function onUploadComplete () : Void {
		addMessage ("Uploaded successfully !");
		menu.remove ("Cancel");
		menu.add (["Done"]);
		menu.enable ("Browse");
		menu.disable ("Upload");
	}
	function onUploadError () : Void {
		addMessage ("Error !");
	}
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		switch (e.label) {
			case "Browse": ft.browse ([FileTransfer.IMAGES,
										FileTransfer.MUSIC,
										FileTransfer.FLASH,
										FileTransfer.VIDEOS,
										FileTransfer.TEXT]
									);
			case "Upload": startUpload();
			case "Cancel": destroy(); cancel();
			case "Done": onComplete();
		}
	}
	
	
	/**
	 *	Set an unique name to set for upload
	 */
	public function setUniqueNameToday (name:String) :Void {
		unique_name = name;
	}
	
	// clean mess
	override public function destroy () :Void {
		Fugu.safeDestroy ( ft );
		ft = null;
	}
}
