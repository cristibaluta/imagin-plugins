//
//  RCRectangle
//
//  Created by Baluta Cristian on 2011-07-29.
//  Copyright (c) 2011 ralcr.com. All rights reserved.
//

extern class RCRectangle extends RCView {
	
	public var roundness :Null<Int>;// Rounded corners radius
	
	public function new (x:Float, y:Float, w:Float, h:Float, ?color:Dynamic, ?alpha:Float=1.0, ?r:Null<Int>) :Void {}
	public function redraw() :Void {}
}
