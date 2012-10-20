//
//  RCPluginLoader
//
//  Created by Cristi Baluta on 2011-02-23.
//  Copyright (c) 2011 ralcr.com. 
//	This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
//

extern class JSPluginLoader {
	
	public var percentLoaded :Int;
	
	dynamic public function onProgress() :Void {}
	dynamic public function onComplete() :Void {}
	dynamic public function onError() :Void {}
	
	
	public function new (path:String) :Void;
	public function destroy () :Void;
	public static function exists (key:String) :Bool;
}
