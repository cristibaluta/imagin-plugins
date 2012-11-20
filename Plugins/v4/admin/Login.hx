//
//  Login
//
//  Created by Baluta Cristian on 2008-06-25.
//  Copyright (c) 2008 milc.ro. All rights reserved.
//
package admin;

import admin.lib.Console;


class Login extends RCView {
	
	var repeat :Int;
	var console :Console;
	
	dynamic public function onLogin () :Void {}
	
	
	public function new (x, y) {
		super(x, y);
		repeat = 0;
		
		console = new Console();
		console.onLogin = loginOk;
		console.login();
		this.addChild ( console );
		// autofill password
		//if (RCUserDefaults.get ("password") != null) input.text = RCUserDefaults.get ("password");
		
	}
	
	function loginOk(){
		//RCUserDefaults.set ("password", console.get("password"));
		Session.set ("admin", true);
		Session.set ("album", console.get("username"));// The username is the album name
		onLogin();
	}
	
	// clean mess
	override public function destroy () :Void {
		console.destroy();
		console = null;
	}
}
