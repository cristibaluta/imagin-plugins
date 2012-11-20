//
//  New File
//
//  Created by Baluta Cristian on 2008-07-02.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin.lib;




class TemplateDialog extends RCView {
	
	var path : String;
	var background :RCRectangle;
	var menu :RCGroupButtons<RCButton>;// Action buttons
	var message :RCTextView;
	
	dynamic public function onComplete () : Void;
	dynamic public function onCancel () : Void;
	dynamic public function onError () : Void;
	
	
	public function new (x, y, w, h, path:String, message:String) {
		super(x, y);
		
		this.path = path;
		this.w = w;
		this.h = h;
		
		background = new RCRectangle (0, 0, w, h, 0x333333);
		this.addChild ( background );
		
		// Add description message
		this.addChild ( new RCTextView (10, 3, w-15, null, message, RCFontManager.getFont("default", {color:0xffffff})) );
		
		init();
	}
	
	function init () {
		
	}
	
	function constructButton (label:String) :RCButton {
		var s = new SkinAdminButtonWithText (label, Config.COLORS_BUTTON_ADMIN1);
		var b = new RCButton (0, 0, s);
		return b;
	}
	
	
	function cancel () :Void {
		onCancel();
	}
	
	
	
	/**
	 *	Add confirmaton messages
	 */
	function addMessage (str:String) :Void {
		if (message == null)
			message =  new RCTextView (10, h - 40, w-15, null, str, RCFontManager.getFont("default", {color:0x666666}));
		else
			message.text = str;
		this.addChild ( message );
	}
}
