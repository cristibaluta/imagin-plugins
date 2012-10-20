//
//  RCPolygon
//
//  Created by Baluta Cristian on 2008-10-12.
//  Copyright (c) 2008 ralcr.com. 
//	This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
//

extern class RCPolygon extends RCView {
	
	public var points :Array<RCPoint>;
	
	
	public function new (x:Float, y:Float, points:Array<RCPoint>, color:Dynamic, ?alpha:Float=1.0) :Void {}
	
	public function redraw () :Void {}
}
