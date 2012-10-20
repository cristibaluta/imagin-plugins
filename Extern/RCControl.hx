//
//  RCControl
//
//  Created by Baluta Cristian on 2008-03-23.
//  Copyright (c) 2008-2012 www.ralcr.com. 
//	This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
//

enum RCControlState {
	NORMAL;
	HIGHLIGHTED;// used when UIControl isHighlighted is set
	DISABLED;
	SELECTED;
}


extern class RCControl extends RCView {

#if nme
	// TODO
	public var touchDown :RCSignal<RCControl->Void>;// on all touch downs
	public var touchDownRepeat :RCSignal<RCControl->Void>;// on multiple touchdowns (tap count > 1)
	public var touchDragInside :RCSignal<RCControl->Void>;
	public var touchDragOutside :RCSignal<RCControl->Void>;
	public var touchDragEnter :RCSignal<RCControl->Void>;
	public var touchDragExit :RCSignal<RCControl->Void>;
	public var touchUpInside :RCSignal<RCControl->Void>;
	public var touchUpOutside :RCSignal<RCControl->Void>;
	public var touchCancel :RCSignal<RCControl->Void>;
#end
	public var click :EVMouse;// RCSignal that dispatches EVMouse: RCSignal<EVMouse->Void>
	public var press :EVMouse;
	public var release :EVMouse;
	public var over :EVMouse;
	public var out :EVMouse;

	public var editingDidBegin :RCSignal<RCControl->Void>;// RCTextInput
	public var editingChanged :RCSignal<RCControl->Void>;
	public var editingDidEnd :RCSignal<RCControl->Void>;
	public var editingDidEndOnExit :RCSignal<RCControl->Void>;// 'return key' ending editing
	
	
	public var enabled (getEnabled, setEnabled) :Bool;// default is YES. if NO, ignores mouse/touch events
	public var highlighted (getHighlighted, null) :Bool;// default is NO.
	public var selected (getSelected, null) :Bool;// default is NO
	
	dynamic public function onClick () :Void {}
	dynamic public function onPress () :Void {}
	dynamic public function onRelease () :Void {}
	dynamic public function onOver () :Void {}
	dynamic public function onOut () :Void {}
	
	
	public function new (x:Float, y:Float, w:Float, h:Float) :Void {}
	public function setState (state:RCControlState) :Void {}
	override public function destroy () :Void {}
}
