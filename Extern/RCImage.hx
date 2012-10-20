//
//  RCImage
//
//  Created by Baluta Cristian on 2011-07-29.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class RCImage {
	
	public var isLoaded :Bool;
	public var percentLoaded :Int;
	public var errorMessage :String;
	
	dynamic public function onComplete () :Void {}
	dynamic public function onProgress () :Void {}
	dynamic public function onError () :Void {}
	
	
	public function new (x:Float, y:Float, URL:String) :Void {}
	public function copy () :RCImage {}
	public function destroy() :Void {}
}
