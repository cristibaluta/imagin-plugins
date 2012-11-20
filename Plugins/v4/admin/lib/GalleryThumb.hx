//
//  Caption
//
//  Created by Baluta Cristian on 2009-07-04.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;


import flash.geom.Point;
import v4.SyncronizeSlider;


class GalleryThumb extends RCView {
	
	var path :String;
	var _read :IMURLRequest;
	var _write :RCHttp;
	var photo :RCImage;
	var status :RCTextView;
	var menu :RCGroupButtons<RCButton>;
	var mark :RCPolygon;
	
	public var editable (null, setEditable) :Bool;
	dynamic public function onComplete () :Void {}
	
	
	public function new (x, y, w, h, label:String, path:String){
		super(x, y);
		this.path = path;
		this.w = w;
		this.h = h;
		
		this.addChild ( new RCRectangle (0, 0, w, h, 0xEEEEEE) );
		this.addChild ( new RCPolygon (w/2,-15, [new Point(0,0),new Point(7,15),new Point(-7,15)], 0xeeeeee));
		this.addChild ( new RCText (10, 3, label,
						{format: FontManager.getTextFormat("default", {color : 0x333333}),
						 antiAliasType: flash.text.AntiAliasType.NORMAL}
						));
						
		init();
	}
	
	function init () :Void {
		
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(50, h / 2 - 8, 6, null, constructButton);
		menu.add ( ["Crop", "Upload"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		this.addChild ( menu );
		
		// Read the caption from IPTC metadata
		photo = new RCImage (10, 20, path);
		photo.onComplete = onPhotoLoadedd;
		this.addChild ( photo );
	}
	function onPhotoLoadedd () {
		Fugu.safeDestroy ( menu );
		menu = new RCGroupButtons<RCButton>(100, 20, null, 6, constructButton);
		menu.add ( ["Crop", "Upload"] );
		this.addChild ( menu );
		photo.scaleToFit (Math.round(h-20), Math.round(h-20));
	}
	
	function constructButton (label:String) :RCButton {
		var s = new SkinAdminButtonWithText (label, Config.COLORS_BUTTON_ADMIN1);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		switch ( e.label ) {
			case "Crop": null;
			case "Upload": null;
		}
	}
	
	
	
	public function setStatus (str:String) :Void {
		if (status == null)
			status = new RCText (40, h-16, str,
								{format:FontManager.getTextFormat("default", {color:0x666666}),
								 antiAliasType: flash.text.AntiAliasType.NORMAL});
		else
			status.text = str;
		this.addChild ( status );
	}
	
	public function setEditable (editable:Bool) :Bool {
		return this.editable = editable;
	}
	
	
	// Clean mess
	override public function destroy () :Void {
		
	}
}
