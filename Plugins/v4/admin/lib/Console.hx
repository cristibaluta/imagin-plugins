//
//  Console
//
//  Created by Baluta Cristian on 2009-07-05.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package admin.lib;




class Console extends RCView {
	
	var output :RCTextView;
	var tmp :String;
	var inp :RCView;
	var input_background :RCRectangle;
	var input :RCTextInput;
	var but :RCButton;
	var request :RCHttp;
	
	var sequence :Array<String>;
	var inputs :Dynamic;
	
	dynamic public function onLogin () :Void {}
	
	
	public function new (){
		super();
		
		tmp = "";
		// Add output textfield
		output = new RCText (0, 0, null, null, "", RCFontManager.getFont("default", {color : 0x333333}));
		this.addChild ( output );
		
		// Add input field
		inp = new RCView (0, 0);
		
		input_background = new RCRectangle (0, 0, 300, 16, 0xefefef);
		inp.addChild ( input_background );
		//
		input = new RCTextInput (30, 0, "",
								{format: FontManager.getTextFormat("default", {color : 0x000000}),
							 	 w: 270, h:20, antiAliasType: flash.text.AntiAliasType.NORMAL}
								);
		input.textfield.multiline = false;
		input.onEnter = executeAction;
		inp.addChild ( input );
		
		// Add send button
		var s = new SkinAdminButtonWithText ("Send", Config.COLORS_BUTTON_ADMIN1);
		but = new RCButton (1, 2, s);
		but.onClick = executeAction;
		inp.addChild ( but );
		
		this.addChild ( inp );
		
		setOutput ("Welcome to IMAGIN Admin Panel !");
		if (RCUserDefaults.get ("last_login") != null)
			setOutput ("Last login on " + RCUserDefaults.get ("last_login"));
			RCUserDefaults.set ("last_login", Date.now().toString());
			setOutput ("");
	}
	
	/**
	 *	Console commands
	 */
	public function login () :Void {
		
		sequence = ["username", "password"];
		inputs = {};
		
		setOutput ("Enter login username:");
		input.textfield.setSelection (0, input.textfield.length);
	}
	
	
	function executeAction () : Void {
		
		var key = sequence.shift();
		Reflect.setField (inputs, key, getLastInput());
		
		// Do we have more commands to execute?
		if (sequence.length == 0)
			doLogin();
		else {
			switch (sequence[0]) {
				case "password" :
				setOutput (" <font color='#999999'>" + getLastInput() + "</font>", false);
				setOutput ("Enter login password:");
				input.textfield.setSelection (0, input.textfield.length);
				
			}
		}
	}
	
	function doLogin () : Void {
		
		setOutput ("Loging in... Please wait !");
		
		request = new RCHttp ("");
		request.call ("checkPassword.php", {	username : Reflect.field (inputs, "username"),
											password : Reflect.field (inputs, "password")
										});
		request.onComplete = loginOK;
		request.onError = loginWrong;
	}
	
	public function doLogout () : Void {
		
	}
	
	
	function loginOK () :Void {
		if (request.result == "1") {
			setOutput ("Login successfully !");
			setOutput ("");
			onLogin();
		}
	}
	
	function loginWrong () :Void {
		setOutput ("<font color='#ff3300'>" + request.result + "</font>");
		setOutput ("");
		login();
	}
	
	
	public function getLastInput () :String {
		return input.text;
	}
	
	public function get (key) :String {
		return Reflect.field (inputs, key);
	}
	
	public function setOutput (str:String, newline:Bool=true) :Void {
		if (newline)
		tmp += "\n> ";
		tmp += str;
		output.text = tmp;
		inp.y = Math.round ( output.height + 15 );
	}
	
	
	public function destroy () :Void {
		
	}
}