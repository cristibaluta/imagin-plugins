//
//  RCFiles
//
//  Created by Baluta Cristian on 2009-06-24.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;


import v4.SyncronizeSlider;


class Photos extends RCFiles {
	
	var filesRCView :RCView;
	var thumbs :Array<Thumb>;
	var allFiles :Array<String>;
	
	
	public function new (x, y, w, h, label:String, path:String){
		super(x, y, w, h, label, path);
	}
	
	override function init () :Void {
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h-16, 6, null, constructButton);
		menu.add ( ["Batch Upload", "Delete", "Www"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		this.addChild ( menu );
		
		filesRCView = new RCView (0, 0);
		filesRCView.x = 10;
		filesRCView.y = 30;
		this.addChild ( filesRCView );
		
		readDirectory ();
	}
	
	override function onDirectoryComplete () {
		var f = request.result;
		//var dirs :Array<String> = Reflect.field (request.result, "dir");
		allFiles = Reflect.field (request.result, "media");
		
		// Add files list
		thumbs = new Array<Thumb>();
		var line = 0, column = 0;
		var	path = Config.PATH + path.split ( Config.PHOTOS_PATH ).pop();
		
		for (i in 0...allFiles.length) {
			var th = new Thumb (80*column, 80*line, 65, 65, path + allFiles[i], i);
				th.onClick = callback (onClickThumbHandler, i);
			filesRCView.addChild ( th );
			thumbs.push ( th );
			
			column ++;
			if (column >= 6) {
				column = 0;
				line ++;
			}
		}
		
		if (filesMask == null)
		addScrollbar ( filesRCView );
	}
	
	
	/**
	 *	Analyze what button was clicked
	 */
	override function clickHandler (e:GroupEvent) :Void {
		
		switch ( e.label ) {
			case "Batch Upload": batchUpload();
			
			case "Www": HXAddress.href ("http://cristi.imagin.ro/#/Gallery/"+path, "_blank");
		}
	}
	
	function onClickThumbHandler (i:Int) :Void {
		label = allFiles[i];trace(label);
		onClick();
	}
	
	
	
	function batchUpload () :Void {
		trace("batch upload");
	}
	
	
	override function clean () :Void {
		Fugu.safeDestroy ([dialog, mask_mc]);
		dialog = null;
		mask_mc = null;
	}
	
	override public function destroy () {
		
	}
}