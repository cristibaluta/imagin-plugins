//
//  RCSize
//
//  Created by Cristi Baluta on 2011-03-10.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class RCSize {
	
	public var width :Null<Float>;
	public var height :Null<Float>;
	
	
	public function new (?w:Null<Float>, ?h:Null<Float>) :Void {}
	public function copy () :RCSize {}
}
