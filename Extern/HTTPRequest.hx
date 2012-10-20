//
//  HTTPRequest
//
//  Created by Baluta Cristian on 2011-07-29.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class HTTPRequest {
	
	public var result :String; // Returned data or error message
	public var status :Int; //
	public var percentLoaded :Int;
	
	dynamic public function onOpen () :Void {}
	dynamic public function onComplete () :Void {}
	dynamic public function onError () :Void {}
	dynamic public function onProgress () :Void {}
	dynamic public function onStatus () :Void {}
	
	
	public function new (?scripts_path:String) :Void {}
	public function readFile (file:String) :Void {}
	public function readDirectory (directory:String) :Void {}
	public function call (script:String, variables_list:Dynamic, ?method:String="POST") :Void {}
	public function destroy () :Void {}
}
