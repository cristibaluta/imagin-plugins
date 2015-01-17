//
//  Comments
//
//  Created by Baluta Cristian on 2009-01-10.
//  Copyright (c) 2009 http://imagin.ro. All rights reserved.
//
package im;



import im.lib.InputForm;


class CommentsViewController extends RCView {
	
	var URL :String;
	var h :Int;
	var data :Comments;
	var commentsScrollView :RCScrollView;
	var textView :RCTextView;
	
	var separator :RCRectangle;
	var form :RCGroup<InputForm>;
	var butClose :RCButton;
	var butSend :RCButton;
	var confirmation :RCTextView;
	var send_mail :CustomPageView;
	
	// xml settings
	var _background_color :Null<Int>;
	var _color_highlighted :Null<Int>;
	var _text_color :Null<Int>;
	
	dynamic public function onClose() :Void {}
	dynamic public function onUpdate() :Void {}
	
	
	public function new (h:Int, URL:String) {
		super();
		this.URL = URL;
		this.h = h;
		
		config();
		init();
	}
	
	function config () {	
		_background_color = IMPreferences.hexColorForKey ("color_background_timeline");
		_text_color = IMPreferences.hexColorForKey ("color_text");
		_color_highlighted = IMPreferences.hexColorForKey ("color_highlighted");
	}
	function init () {
		this.addChild ( separator = new RCRectangle (520, 0, 1, h, 0x000000) );
		
		// Add formular
		form = new RCGroup<InputForm> (550, 0, null, 14, constructInputForm);
		form.add ([	RCLocalization.list.name + ":",
					RCLocalization.list.email + ":",
					RCLocalization.list.website + ":",
					RCLocalization.list.comment + ":"
				]);
		
		// Autofill the form
		var author :String = RCUserDefaults.stringForKey ("author");
		var email :String = RCUserDefaults.stringForKey ("email");
		var website :String = RCUserDefaults.stringForKey ("website");
		
		if (author != null) form.get( 0 ).setText( author );
		if (email != null) form.get( 1 ).setText( email );
		if (website != null) form.get( 2 ).setText( website );
		
		// Add send button
		butSend = constructButton (550, 280, RCLocalization.list.send);
		butSend.onClick = write;
		
		// Add close button
		butClose = constructButton (550 + butSend.width + 10, 280, RCLocalization.list.close);
		butClose.onClick = onCloseHandler;
		
		//Fugu.safeAdd (this, [form, butClose, butSend]);
		Fugu.safeAdd ( this, [form, butClose, butSend] );
		
		// Create the data model
		data = new Comments( URL );
		data.onReadComplete = onReadComplete;
		data.onWriteComplete = onWriteComplete;
		
		read();
	}
	
	function read () {
		data.read();
	}
	function onReadComplete () {
		commentsScrollView = new RCScrollView (0, 0, 500, h);
		this.addChild ( commentsScrollView );
		
		textView = new RCTextView (0, 0, 500, h, data.toString(), RCFontManager.getFont());
		commentsScrollView.contentView = textView;
	}
	
	
	
	/**
	 *	Add a new comment into the xml
	 */
	function write () :Void {
		
		// Create a new comment line object
		var comment = new Comment();
			comment.author = form.get( 0 ).getText();
			comment.email = form.get( 1 ).getText();
			comment.website = form.get( 2 ).getText();
			comment.comment = form.get( 3 ).getText();
			comment.data = Date.now().toString();
		
		//
		if (confirmation == null) {
			var format = (IMPreferences.stringForKey("font_type_menu", string) == "default")
			? RCFontManager.getFont("default")
			: RCFontManager.getFont("regular", {size: IMPreferences.stringForKey("font_size_menu", integer)});
			
			confirmation = new RCTextView (550, 300, null, null, "", format);
		}
		this.addChild ( confirmation );
		
		
		if (comment.isValid()) {
			confirmation.text = RCLocalization.list.comment_sending;
			data.write( comment );
		}
		else {
			confirmation.text = RCLocalization.list.comment_error;
		}
	}
	
	function onWriteComplete () :Void {
		
		confirmation.text = RCLocalization.list.comment_sent;
		
		// Remind the user, email, and website
		RCUserDefaults.set ("author", form.get( 0 ).getText());
		RCUserDefaults.set ("email", form.get( 1 ).getText());
		RCUserDefaults.set ("website", form.get( 2 ).getText());
		form.get( 3 ).setText ("");
		
		
		//parseComments();
		
		// text.y = 20 - text.height + h;
	}
	
	function onCommentsError () :Void {
		confirmation.text = RCLocalization.list.comment_error;
	}
	
	
	function onCloseHandler() :Void {
		onClose();
	}
	
	/**
	 *	Returns the number of comments
	 */
	public function getNrOfComments () :Int {
		return data.length;
	}
	
	
	public function resizeHandler (h:Int) :Void {
		this.h = h;
	}
	
	
	/**
	 *  Utilities
	 */
	function constructButton (x, y, label:String) :RCButton {
		var s = new SkinRoundedButtonWithText (label, [_background_color, _background_color, _text_color, _color_highlighted]);
		var b = new RCButton (x, y, s);
		return b;
	}
	
	function constructInputForm (params:Dynamic) :InputForm {
		// in this case, params is a string
		var f = new InputForm (0, 0, 280, params == (RCLocalization.list.comment+":") ? 106 : 16, params);
		return f;
	}
	
	
	public function destroy () :Void {
		Fugu.safeDestroy ([commentsScrollView, data, form]);
		commentsScrollView = null;
		form = null;
		data = null;
	}
	
	
	// Don't do anything, this is a plugin
	public static function main () {
		Type.resolveClass("");// Hack to include the class definitions in the generated code
	}
	
}
