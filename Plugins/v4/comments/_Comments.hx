//
//  Comments
//
//  Created by Cristi Baluta on 2011-02-28.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//
class Comments {
	
	var read_req :RCHttp;
	var write_req :RCHttp;
	var xml :Xml;
	var lines :Array<Comment>;
	var URL :String;
	public var length (getLength, null) :Int;
	
	dynamic public function onUpdate() :Void {}
	dynamic public function onWriteComplete() :Void {}
	dynamic public function onWriteError() :Void {}
	dynamic public function onReadComplete() :Void {}
	dynamic public function onReadError() :Void {}
	
	
	public function new ( URL ) {
		this.URL = URL;
		lines = new Array<Comment>();
	}
	
	
	/**
	 *  Request the existing comments from server
	 */
	public function read () :Void {
		read_req = new RCHttp( null );
		read_req.onComplete = parseComments;
		read_req.onError = createNewXml;
		read_req.readFile ( URL + Config.RND() );
	}
	
	function parseComments() :Void {
		
		// Keep a copy of the original xml
		if (xml == null)
		 	xml = Xml.parse ( read_req.result );
/*		: Xml.parse ( xml.toString() );*/
		
		// Extract comments from the xml
		var fast = new haxe.xml.Fast( xml.firstElement() );
		
		// Iterate comments
		if (fast.hasNode.comment)
			for (c in fast.nodes.comment) {
				var comment = new Comment();
					comment.author = c.att.author;
					comment.email = c.att.email;
					comment.website = c.att.website;
					comment.data = c.att.data;
					comment.comment = c.innerData;
					
				lines.push ( comment );
			}
		
		onUpdate();
	}
	function createNewXml () :Void {
		read_req.result = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><root></root>";
		parseComments();
	}
	
	
	
	/**
	 *	Add a new comment into the xml
	 */
	public function write (comment:Comment) :Void {
		
		xml.firstElement().addChild ( comment.toXml() );
		
		var url2 = URL.split( Config.API_DIR ).pop();
			url2 = Config.PHOTOS_PATH + url2.split( Config.PHOTOS_PATH ).pop();
		
		// Send the data to server
		write_req = new RCHttp ( Config.API_DIR );
		write_req.onComplete = onWriteCompleteHandler;
		write_req.onError = onWriteErrorHandler;
		write_req.call ("filesystem/writeComment.php", {path : url2, raw_data : xml.toString()});
	}
	function onWriteCompleteHandler () :Void {
		onWriteComplete();
	}
	function onWriteErrorHandler () :Void {
		onWriteError();
	}
	
	
	
	function getLength () :Int {
		return lines.length;
	}
	
	
	/**
	 *  Return the comments as a string ready to display in a TextView
	 */
	public function toString () :String {
		return lines.join("\n\n");
	}
	
	
	/**
	 *  Stop any request prematurely
	 */
	public function destroy () :Void {
		Fugu.safeDestroy ([read_req, write_req]);
		read_req = null;
		write_req = null;
	}
}
