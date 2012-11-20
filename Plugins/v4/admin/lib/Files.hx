//
//  RCFiles
//
//  Created by Baluta Cristian on 2009-06-24.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;


import flash.geom.Point;
import v4.SyncronizeSlider;


class RCFiles extends RCView {
	
	var path :String;
	var request :IMURLRequest;
	var dirs :Array<String>;
	var media :Array<String>;
	var menu :RCGroupButtons<RCButton>;
	var files :RCGroupButtons<RCButton>;
	var filesMask :RCRectangle;
	var mark :RCPolygon;
	var slider :RCSlider;
	var syncronizer :SyncronizeSlider;
	
	var dialog :TemplateDialog;//NewFolder, Delete, Upload, Rename
	var mask_mc :RCRectangle;
	
	public var label :String;
	public var containsFolders :Bool;
	public var editable (null, setEditable) :Bool;
	
	dynamic public function onClick () :Void {}
	dynamic public function onComplete () :Void {}
	
	
	public function new (x, y, w, h, label:String, path:String){
		super(x, y);
		this.path = path;
		this.w = w;
		this.h = h;
		
		this.addChild ( new RCRectangle (0, 0, w, 18, 0x666666) );
		this.addChild ( new RCRectangle (0, 18, w, h - 18, 0xeeeeee) );
		this.addChild ( new RCText (10, 3, label,
						{format: FontManager.getTextFormat("default", {color : 0xFFFFFF}),
						 antiAliasType: flash.text.AntiAliasType.NORMAL}
						));
		
		init();
	}
	
	function init () :Void {
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h - 16, 6, null, constructButton);
		menu.add ( ["New", "Upload", "Rename", "Delete"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		menu.disable ("Rename");
		menu.disable ("Delete");
		this.addChild ( menu );
		
		readDirectory ();
	}
	
	function constructButton (label:String) :RCButton {
		var s = new SkinAdminButtonWithText (label, Config.COLORS_BUTTON_ADMIN1);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	function constructButton2 (label:String) :RCButton {
		var s = new SkinAdminButtonWithText (label, [null, null, 0x000000, 0xff3300]);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	
	
	function readDirectory () {
		
		request = new IMURLRequest ( Config.API_DIR );
		request.onComplete = onDirectoryComplete;
		request.readDirectory ( path, true );
	}
	
	function onDirectoryComplete () :Void {
		
		var f = request.result;
		dirs = Reflect.field (request.result, "dir");
		media = Reflect.field (request.result, "media");
		
		containsFolders = dirs.length > 0 ? true : false;
		//menu.disable ("Delete");
		
		// Add files list
		if (files == null) {
			files = new RCGroupButtons<RCButton>(10, 30, null, 0, constructButton2);
			files.add ( dirs.concat( media ) );
			files.addEventListener (GroupEvent.CLICK, clickFileHandler);
			this.addChild ( files );
		}
		else
			files.update ( dirs.concat( media ) );
		
		if (filesMask == null)
		addScrollbar ( files );
		onComplete();
	}
	
	function addScrollbar (obj:DisplayObjectContainer) :Void {
		
		if (obj.height < h - 60) return;
		
		filesMask = new RCRectangle (0, 30, w, h - 60, 0x000000);
		this.addChild ( filesMask );
		obj.mask = filesMask;
		
		// Add the slider
		var colors = [null, null, 0xff3300, 0xff3300];
		var sliderh = Zeta.lineEquationInt (h-60-10, 30,  obj.height-filesMask.height, 1, filesMask.height);
			sliderh = Math.round ( Zeta.limits (sliderh, 30, filesMask.height) );
		var skin = new SkinSlider (5, sliderh, 5, h - 60, colors);
		slider = new RCSlider (w - 8, 30, null, Std.int (h - 60), skin);
		this.addChild ( slider );
		
		syncronizer = new SyncronizeSlider (this, obj, slider, Std.int (h - 60), "vertical");
	}
	
	
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		if (!editable) {
			return;
		}
		switch ( e.label ) {
			case "New": createDirectory();
			case "Upload": uploadFile();
			case "Delete": deleteDirectoryOrFile();
			case "Rename": rename();
		}
	}
	
	
	
	/**
	 *	When a file was clicked
	 */
	function clickFileHandler (e:GroupEvent) :Void {
		label = e.label;
		files.select ( e.label );
		menu.enable ("Rename");
		menu.enable ("Delete");
		onClick();
	}
	
	
	/**
	 *	When a file was clicked
	 */
	function createDirectory () :Void {
		clean();
		
		dialog = new NewFolder (0, h, w, 100, path, "Create a new album:");
		dialog.onComplete = refresh;
		dialog.onCancel = hideDialog;
		this.addChild ( dialog );
		
		addMask();
		showDialog();
	}
	
	/**
	 *	Delete a folder or file
	 */
	function deleteDirectoryOrFile () :Void {
		clean();
		
		var question = "Are you sure you want to delete " + files.label + " ?";
		
		dialog = new Delete (0, h, w, 60, path + files.label, question);
		dialog.onComplete = refresh;
		dialog.onCancel = hideDialog;
		this.addChild ( dialog );
		
		addMask();
		showDialog();
	}
	
	/**
	 *	Delete a folder or file
	 */
	function uploadFile () :Void {
		clean();
		
		dialog = new Upload (0, h, w, 150, path, "Upload new files:");
		dialog.onComplete = refresh;
		dialog.onCancel = hideDialog;
		this.addChild ( dialog );
		
		addMask();
		showDialog();
		
		// Set unique file name
		var unique_name = Date.now().toString();
			unique_name = StringTools.replace (unique_name, "-", "");
			unique_name = StringTools.replace (unique_name, ":", "");
			unique_name = StringTools.replace (unique_name, " ", "-");
		cast (dialog, Upload).setUniqueNameToday ( unique_name );
	}
	
	
	/**
	 *	Delete a folder or file
	 */
	function rename () :Void {
		clean();
		
		dialog = new Rename (0, h, w, 100, path, "Rename " + files.label + " to:");
		dialog.onComplete = refresh;
		dialog.onCancel = hideDialog;
		this.addChild ( dialog );
		
		addMask();
		showDialog();
		
		// Set the directory content so far
		cast (dialog, Rename).setFilesList ( dirs.concat(media) );
		cast (dialog, Rename).setFileName ( files.label );
	}
	
	
	
	function addMask () :Void {
		if (mask_mc == null)
			mask_mc = new RCRectangle (0, 0, w, h, 0x000000);
		dialog.mask = mask_mc;
		this.addChild ( mask_mc );
	}
	
	function showDialog () {
		CoreAnimation.add (dialog, {y:h-dialog.height}, {duration:0.4, timingFunction:caequations.Cubic.Out});
	}
	
	function hideDialog () {
		CoreAnimation.add (dialog, {y:h}, {duration:0.4, timingFunction:caequations.Cubic.Out});
	}
	
	function refresh () {
		menu.disable ("Rename");
		menu.disable ("Delete");
		hideDialog();
		readDirectory();
	}
	
	
	public function setMark (y:Int) {
		mark = new RCPolygon (-15, y, [new Point(0,0), new Point(15,-7), new Point(15,7)], 0xeeeeee);
		this.addChild ( mark );
	}
	
	public function setEditable (editable:Bool) :Bool {
		return this.editable = editable;
	}
	
	function clean () :Void {
		Fugu.safeDestroy ([dialog, mask_mc]);
		dialog = null;
		mask_mc = null;
	}
	
	override public function destroy () {
		
	}
}