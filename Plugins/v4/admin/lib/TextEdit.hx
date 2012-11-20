//
//  TextEdit
//
//  Created by Baluta Cristian on 2008-12-15.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin;



class TextEdit extends RCView {
	
	var textfield :RCTextInput;
	var status :RCText;
	var but_save :RCButton;
	var but_bold :RCButton;
	public var text (getText, setText) :String;
	dynamic public function onSave () :Void {}
	
	
	public function new (x, y, w, h, str:String, format) {
		super(x, y);
		
		this.addChild ( new RCRectangle (0, 0, w, h, [null, 0x888888]) );
		
		textfield = new RCTextInput (0, 0, str, {html:false, format:format, w:w, h:h-20});
		textfield.onFocus = removeStatus;
		textfield.selectable = false;
		this.addChild ( textfield );
		
		// add save button
		but_save = new RCButton (0, h-17, new SkinButtonText (">Save", Config.COLORS_BUTTON_ADMIN));
		but_save.onClick = writeData;
		this.addChild ( but_save );
		
		//
		but_bold = new RCButton (w-20, h-17, new SkinButtonText (">B", Config.COLORS_BUTTON_ADMIN));
		but_bold.onClick = addRemoveBold;
		this.addChild ( but_bold );
	}
	
	function writeData () :Void {
		onSave();
	}
	
	
	public function getText() :String {
		return textfield.text;
	}
	public function setText (text:String) :String {
		return textfield.text = text;
	}
	public function writeComplete (str:String) :Void {
		status = new RCText (50, this.height-20, str, {format:FontManager.getTextFormat("regular", {color:0xFF3300})});
		this.addChild ( status );
	}
	function removeStatus () :Void {
		Fugu.safeRemove (this, status);
		status = null;
	}
	
	
	function addRemoveBold () :Void {
		var index1 = textfield.textfield.selectionBeginIndex;
		var index2 = textfield.textfield.selectionEndIndex;
		var str = textfield.textfield.selectedText;
		
		if (str.indexOf ("<b>") == -1) {
			textfield.textfield.replaceText (index1, index2, "<b>" + str + "</b>");
			textfield.textfield.setSelection (index1, index2 + 7);
		}
		else {
			str = StringTools.replace (str, "<b>", "");
			str = StringTools.replace (str, "</b>", "");
			textfield.textfield.replaceText (index1, index2, str);
			textfield.textfield.setSelection (index1, index1 + str.length);
		}
	}
	
	
	// Clean mess
	public function destroy () :Void {
		
	}
}
