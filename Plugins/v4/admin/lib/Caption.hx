//
//  Caption
//
//  Created by Baluta Cristian on 2009-07-04.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;


import flash.geom.Point;
import v4.SyncronizeSlider;


class Caption extends RCView {
	
	var path :String;
	var read :IMURLRequest;
	var write :RCHttp;
	var input_caption :RCTextInput;
	var input_city :RCTextInput;
	var input_location :RCTextInput;
	var status :RCTextView;
	var menu :RCGroupButtons<RCButton>;
	var mark :RCPolygon;
	
	public var editable (null, setEditable) :Bool;
	dynamic public function onComplete () :Void {}
	
	
	public function new (x, y, w, h, label:String, path:String) {
		super(x, y);
		this.path = path;
		this.w = w;
		this.h = h;
		
		this.addChild ( new RCRectangle (0, 0, w, h, 0xEEEEEE) );
		this.addChild ( new RCPolygon (w/2, -15, [new Point(0,0), new Point(7,15), new Point(-7,15)], 0xeeeeee) );
		
		init();
	}
	
	function init () :Void {
		
		// Add edit textfield: description, city, wikimapia
		this.addChild ( constructLabel (10, 3, "Caption:") );
		this.addChild ( constructLabel (10, 63, "City:") );
		this.addChild ( constructLabel (220, 63, "Location:") );
		
		this.addChild ( new RCRectangle (10, 20, w - 30, 40, [null, 0x666666]) );
		this.addChild ( new RCRectangle (40, 63, 150, 15, [null, 0x666666]) );
		this.addChild ( new RCRectangle (270, 63, 210, 15, [null, 0x666666]) );
		
		// Input caption
		input_caption = new RCTextInput (10, 20, "",
									{format: FontManager.getTextFormat("default", {color : 0x000000}),
									 html: false, w:w-35, h:h-60,
									 antiAliasType: flash.text.AntiAliasType.NORMAL});
		input_caption.onFocus = removeStatus;
		input_caption.selectable = false;
		this.addChild ( input_caption );
		
		// Input city
		input_city = new RCTextInput (40, 63, "",
									{format: FontManager.getTextFormat("default", {color : 0x000000}),
									 html: false, w:150, h:16,
									 antiAliasType: flash.text.AntiAliasType.NORMAL});
		input_city.onFocus = removeStatus;
		input_city.selectable = false;
		input_city.textfield.multiline = false;
		this.addChild ( input_city );
		
		// Input location
		input_location = new RCTextInput (270, 63, "",
									{format: FontManager.getTextFormat("default", {color : 0x000000}),
									 html: false, w:210, h:16,
									 antiAliasType: flash.text.AntiAliasType.NORMAL});
		input_location.onFocus = removeStatus;
		input_location.selectable = false;
		input_location.textfield.multiline = false;
		this.addChild ( input_location );
		
		
		// Add admin buttons
		menu = new RCGroupButtons<RCButton>(10, h - 16, 6, null, constructButton);
		menu.add ( ["Save"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		menu.disable ("Save");
		this.addChild ( menu );
		
		// Read the caption from IPTC metadata
		read = new IMURLRequest ( Config.API_DIR );
		read.onComplete = parseIPTC;
		read.onError = errorHandler;
		read.getFileInfo ( path );
	}
	
	function constructButton (label:String) :RCButton {
		var s = new SkinAdminButtonWithText (label, Config.COLORS_BUTTON_ADMIN1);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	function constructLabel (x, y, label:String) :RCTextView {
		return new RCTextView (x, y, null, null, label, RCFontManager.getFont("default", {color : 0x666666}));
	}
	
	function parseIPTC () :Void {trace(read.result);
		
		var description = Reflect.field (read.result, "description");
		var city = Reflect.field (read.result, "city");
		var location = Reflect.field (read.result, "location");
		
		input_caption.text = description;
		input_city.text = city;
		input_location.text = location == "" ? "Paste Wikimapia.org URL of the location!" : location;
	}
	
	function errorHandler() :Void {
		trace(read.result);
	}
	
	
	
	/**
	 *	Analyze what button was clicked
	 */
	function clickHandler (e:GroupEvent) :Void {
		
		switch ( e.label ) {
			case "Save": writeCaption();
		}
	}
	
	
	
	function writeCaption () :Void {
		
		if (!editable) {
			setStatus ("Your user doesn't have permissions to modify this IPTC!");
			return;
		}
		setStatus ("Writing data to file...");
		
		// Parse wikimapia link
		//http://wikimapia.org/#lat=44.4333&lon=26.1&z=17&l=0&m=w&v=2
		var wikimapia_lnk = input_location.text.split("wikimapia.org/#").pop().split("&z=").shift();
		
		// The path to the photo converted to use it as relative from scriptspath
		write = new RCHttp ( Config.API_DIR );
		write.onComplete = onIPTCWrote;
		write.onError = onIPTCError;
		write.call ("filesystem/writeIPTC.php",
					{path: StringTools.replace (path, Config.API_DIR + "../", ""),
					 caption: input_caption.text,
					 city: input_city.text,
					 location: wikimapia_lnk}
					);
	}
	
	function onIPTCWrote () :Void {trace(write.result);
		setStatus ("Wrote successfully !");
		onComplete();
	}
	function onIPTCError () :Void {
		setStatus ("Write error ! ("+write.result+")");
		trace(write.result);
		//onError();
	}
	
	
	public function setStatus (str:String) :Void {trace("set status: "+str);
		if (status == null)
			status = new RCText (40, h-16, str,
								{format:FontManager.getTextFormat("default", {color:0x666666}),
								 antiAliasType: flash.text.AntiAliasType.NORMAL});
		else
			status.text = str;
		this.addChild ( status );trace("fin");
	}
	function removeStatus () :Void {
/*		Fugu.safeRemove (this, status);
		status = null;*/
		if (status != null)
			status.text = "";
		menu.enable ("Save");
	}
	
	public function setEditable (editable:Bool) :Bool {
		return this.editable = editable;
	}
	
	
	function addRemoveBold () :Void {
/*		var index1 = input_description.textfield.selectionBeginIndex;
		var index2 = input_description.textfield.selectionEndIndex;
		var str = input_description.textfield.selectedText;
		
		if (str.indexOf ("<b>") == -1) {
			input_description.textfield.replaceText (index1, index2, "<b>" + str + "</b>");
			input_description.textfield.setSelection (index1, index2 + 7);
		}
		else {
			str = StringTools.replace (str, "<b>", "");
			str = StringTools.replace (str, "</b>", "");
			input_description.textfield.replaceText (index1, index2, str);
			input_description.textfield.setSelection (index1, index1 + str.length);
		}*/
	}
	
	
	// Clean mess
	override public function destroy () :Void {
		
	}
}
