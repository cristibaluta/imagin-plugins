//
//  RCRect
//
//  Created by Baluta Cristian on 2011-11-12.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class RCRect {
	
	public var origin :RCPoint;
	public var size :RCSize;
	
	public function new (x:Float, y:Float, w:Float, h:Float) :Void {}
	public function copy () :RCRect {}
}
