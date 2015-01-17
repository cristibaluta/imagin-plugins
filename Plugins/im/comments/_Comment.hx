//
//  Comment
//
//  Created by Baluta Cristian on 2011-04-06.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

class Comment {
	
	public var author :String;
	public var email :String;
	public var website :String;
	public var data :String;
	public var comment :String;
	
	
	public function new () {}
	
	
	/**
	 *  Create a comment ready to display
	 */
	public function toString() :String {
		
		var result = "<span class='author'><a href='" + website + "' target='_blank'>" + author + "</a> ";
			result += localizeDate ( RCDateTools.decodeDate ( data ) ) + " ";
			result += RCDateTools.decodeTime ( data ) + "</span>\n";
			result += comment;
		return result;
	}
	
	/**
	 *  Create a Xml comment line
	 */
	public function toXml() :Xml {
		
		var result = Xml.parse ("<comment>" + Xml.createCData( comment ).toString() + "</comment>");
			result.firstElement().set ("author", author == "" ? "John Doe" : author);
			result.firstElement().set ("email", RCStringTools.encodeEmail ( email ));
			result.firstElement().set ("website", website);
			result.firstElement().set ("data", data);
		return result;
	}
	
	/**
	 *  
	 */
	inline function localizeDate (str:String) :String {
		var arr = str.split(" ");
			arr[0] = RCLocalization.get ( arr[0] );
			arr[2] = RCLocalization.get ( arr[2] );
		return arr.join(" ");
	}
	
	
	public function isValid () :Bool {
		return (author == "" || comment == "" || !RCStringTools.validateEmail( email ));
	}
}
