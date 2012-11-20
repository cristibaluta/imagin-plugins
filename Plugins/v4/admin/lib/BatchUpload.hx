//
//  BatchUpload
//
//  Created by Baluta Cristian on 2009-07-04.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;




class BatchUpload extends TemplateDialog {
	
	var input_background :Array<Rectangle>;
	var input :Array<RCTextInput>;
	var _ft :Array<FileTransfer>;
	var unique_name :String;
	var extension :String;
	
	
	public function new (x, y, w, h, path:String, message_str:String) {
		super(x, y, w, h, path, message_str);
	}
	
	override function init () {
		// upload script
		_ft = new FileTransfer ( Config.API_DIR );
		_ft.onSelect = onBrowseHandler;
		_ft.onProgress = onUploadProgress;
		_ft.onComplete = onUploadComplete;
		_ft.onError = onUploadError;
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, _h - 20, 6, null, constructButton);
		menu.add ( ["Browse", "Cancel"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		this.addChild ( menu );
	}
	
	function onBrowseHandler () : Void {
		
		extension = _ft.name.split(".").pop();
		// Add text input to change the name of the uploaded file
		if (input == null) {
			input_background = new RCRectangle (10, 40, _w-15, 18, 0x666666, 1, 5);
			this.addChild ( input_background );

			//
			input = new RCTextInput (10, 40, unique_name == null ? _ft.name : unique_name,
									{format: FontManager.getTextFormat("default", {color : 0xFFFFFF}),
								 	 w:_w-15, h:20, antiAliasType: flash.text.AntiAliasType.NORMAL}
									);
			input.textfield.multiline = false;
			this.addChild ( input );
		}
		
		addMessage ("Rename the file if you want !");
	}
	
	function startUpload () : Void {trace(path);trace(input.text);
		addMessage ("Starting...");
		_ft.upload ( path, input.text + "." + extension );
	}
	
	function onUploadProgress () : Void {
		addMessage ("Uploading... ( " + _ft.percentLoaded + " % )");
	}
	
	function onUploadComplete () : Void {
		addMessage ("Uploaded successfully !");
		menu.remove ("Cancel");
		menu.add (["Done"]);
	}
	function onUploadError () : Void {
		//saved();
	}
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		switch (e.label) {
			case "Browse": _ft.browse ([FileTransfer.IMAGES,
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
		Fugu.safeDestroy (null, _ft);
		_ft = null;
	}
}
