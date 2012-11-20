//
//  Main
//
//  Created by Baluta Cristian on 2008-03-21.
//  Copyright (c) 2012 www.ralcr.com. All rights reserved.
//

package v4.admin;


class AdminController {
	
	//static var header : RCRectangle;
	//static var menu : RCGroupButtons<RCButton>;
	//static var login : Login;
	//static var logout : Logout;
	
	
/*	static function doLogin () :Void {
		addHeader();
		login = new Login (3, 50);
		login.onLogin = init;
		RCWindow.addChild ( login );
		//init();
	}*/
	
/*	static function init () :Void {
		
		Fugu.safeDestroy ( login );
		login = null;
		
		// Add menu
		menu = new RCGroupButtons<RCButton>(200, 22, 20, null, constructButton);
		menu.add ( ["Galleries", "Preferences", "Comments", "RSS", "Migration Assist", "WWW"] );
		menu.addEventListener (GroupEvent.CLICK, clickHandler);
		RCWindow.addChild ( menu );
		
		clickHandler ( new GroupEvent (GroupEvent.CLICK, "Galleries") );
	}*/
	
/*	static function constructButton (label:String) :RCButton {
		var s = new SkinAdminButtonWithText (label, [null, null, 0xffffff, 0xff3300]);
		var b = new RCButton (0, 0, s);
		return b;
	}*/
	
	/**
	 *	Analyze what button was clicked
	 */
/*	static function clickHandler (e:GroupEvent) :Void {
		
		var label = e.label;
		menu.select ( label );
		
		switch (label) {
			case "Galleries": page = new Galleries (3, 50);
			case "Preferences": Fugu.safeDestroy ( page );
			case "Comments": Fugu.safeDestroy ( page );
			case "RSS": Fugu.safeDestroy ( page );
			case "WWW": HXAddress.href ("http://cristi.imagin.ro/", "_blank");
		}
		RCWindow.addChild ( page );
	}*/
	
	
	
	// Don't do anything, plugins are instantiated from the master software when needed.
	public static function main(){
		Type.resolveClass("");// Hack to include the class definitions in the generated code
	}
	
}
