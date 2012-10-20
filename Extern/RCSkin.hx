//
//  RCSkin - A collection of organized views that will get displayed in a RCControl
//
//  Created by Baluta Cristian on 2008-07-03.
//  Copyright (c) 2008-2012 ralcr.com. 
//	This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
//

typedef RCSkinElements = {
	var background :RCView;
	var label :RCView;
	var image :RCView;
	var otherView :RCView;
	var colors :RCSkinColors;
}
typedef RCSkinColors = {
	var background :Null<Int>;
	var label :Null<Int>;
	var image :Null<Int>;
	var otherView :Null<Int>;
}

extern class RCSkin {
	
	// NORMAL / HIGHLIGHTED / DISABLED / SELECTED / HIT_AREA
	public var normal :RCSkinElements;
	public var highlighted :RCSkinElements;
	public var disabled :RCSkinElements;
	public var selected :RCSkinElements;
	public var hit :RCView;
	
	
	public function new (?colors : Array<Null<Int>>) :Void {}
	public function destroy() :Void {}
}
