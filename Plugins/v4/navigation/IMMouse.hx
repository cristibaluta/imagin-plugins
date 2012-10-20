//
//  Mouse
//
//  Created by Baluta Cristian on 2008-09-14.
//  Copyright (c) 2008-2012 http://imagin.ro. All rights reserved.
//

#if (flash || nme)
	import flash.display.DisplayObjectContainer;
	import flash.events.EVMouse;
#elseif js
	import js.Dom;
	private typedef DisplayObjectContainer = HtmlDom;
	private typedef EVMouse = Event;
#end

private enum Position {
	left;
	middle;
	right;
	outside;
	over;
}

class IMMouse {
	
	var _parent :DisplayObjectContainer;
	var _target :DisplayObjectContainer;
	var _over	:DisplayObjectContainer;
	
	var _last_position :Position;
	var _interval :haxe.Timer;
	var _is_idle :Bool;
	var _is_over :Bool; // mouse is over the "over" object
	var _w :Int; // set the middle width area
	
	inline static var IDLE_TIME :Int = 3000;
	inline static var MIDDLE_W :Int = 200;
	
	
	/**
	 * Custom events
	 */
	dynamic public function onOver () :Void {}
	dynamic public function onOut () :Void {}
	dynamic public function onLeft () :Void {}
	dynamic public function onMiddle () :Void {}
	dynamic public function onMiddleOut () :Void {}
	dynamic public function onRight () :Void {}
	dynamic public function onClick () :Void {}
	dynamic public function onDoubleClick () :Void {}
	dynamic public function onClickLeft () :Void {}
	dynamic public function onClickMiddle () :Void {}
	dynamic public function onClickRight () :Void {}
	dynamic public function onIdle () :Void {}
	dynamic public function onResume () :Void {}
	
	
	public function new (	parent:DisplayObjectContainer,
							target:DisplayObjectContainer,
							?target_over:DisplayObjectContainer)
	{
		
		_w = MIDDLE_W;
		_parent = parent;
		_target = target;
		_over = (target_over == null) ? target : target_over;//use a different area to attach EVMouses
		_is_idle = false;
		
		//_target.buttonMode = true;
		//_over.buttonMode = true;
		//_parent.doubleClickEnabled = true;
		
		#if (flash || nme)
			if (_parent != RCWindow.target)
				_parent.mouseEnabled = true;
			if (_over != RCWindow.target)
				_over.mouseEnabled = true;
		#end
		
		resume();
	}
	
	
	/**
	 * Start listening for mouse actions
	 */
	public function resume () :Void {
		
		_interval = new haxe.Timer ( IDLE_TIME );
		
		#if (flash || nme)
			_over.addEventListener (EVMouse.OVER, mouseOverHandler);
			_over.addEventListener (EVMouse.OUT, mouseOutHandler);
			_over.addEventListener (EVMouse.CLICK, clickHandler);
		#elseif js
			_over.onmouseover = mouseOverHandler;
			_over.onmouseout = mouseOutHandler;
			_over.onclick = clickHandler;
		#end
	}
	
	
	/**
	 * Hold all mouse actions
	 */
	public function hold () :Void {
		
		_interval.stop();
		_interval = null;
		
		#if (flash || nme)
			_over.removeEventListener (EVMouse.OVER, mouseOverHandler);
			_over.removeEventListener (EVMouse.OUT, mouseOutHandler);
			_over.removeEventListener (EVMouse.CLICK, clickHandler);
		#elseif js
			_over.onmouseover = null;
			_over.onmouseout = null;
			_over.onclick = null;
		#end
	}
	
	
	/**
	 * Handlers
	 */
	function mouseOverHandler (e:EVMouse) :Void {
		_last_position = over;
		onOver();
		
		#if (flash || nme)
			_parent.addEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
			_parent.addEventListener (EVMouse.DOUBLE_CLICK, doubleClickHandler);
		#elseif js
			_over.onmousemove = mouseMoveHandler;
			_over.ondblclick = doubleClickHandler;
		#end
	}
	function mouseOutHandler (e:EVMouse) :Void {
		
		#if (flash || nme)
			_parent.removeEventListener (EVMouse.MOUSE_MOVE, mouseMoveHandler);
			_parent.removeEventListener (EVMouse.DOUBLE_CLICK, doubleClickHandler);
		#elseif js
			_over.onmousemove = null;
			_over.ondblclick = null;
		#end
		
		onOut();
	}
	
	function mouseMoveHandler (e:EVMouse) :Void {
		// for each mousemove reset the counter for going idle
		_interval.stop();
		_interval = new haxe.Timer ( IDLE_TIME );
		_interval.run = goIdle;
		
		if (_is_idle) resumeIdle();
		
		var position = getPosition(e);
		
		if (_last_position == middle && position != middle)
			onMiddleOut();
		if (_last_position != position) {
			_last_position = position;
			dispatchPosition ( position );
		}
	}
	
	function clickHandler (e:EVMouse) :Void {
		switch ( getPosition(e) ) {
			case left:		onClickLeft();		onClick();
			case right:		onClickRight();		onClick();
			case middle:	onClickMiddle();	onClick();
			
			case outside:	return;
			case over:		return;
		}
	}
	
	function doubleClickHandler (e:EVMouse) :Void {
		onDoubleClick();
	}
	
	function dispatchPosition (position:Position) {
		switch ( position ) {
			case left:		onLeft();
			case middle:	onMiddle();
			case right:		onRight();
			case outside:	mouseOutHandler ( null );
			case over:		null;
		}
	}
	
	
	/**
	 * Force to dispatch events even if mouse is not moving
	 * Usefull if your content was moved but not the mouse
	 */
	public function refresh () :Void {
		mouseMoveHandler ( null );
	}
	
	
	public function setMiddleWidth (w:Int) {
		_w = w;
	}
	
	
	/**
	 * Returns the position of the mouse to the target
	 */
	function getPosition (e:EVMouse) :Position {
		#if (flash || nme)
			if (_parent.mouseX > _target.x && _parent.mouseX < _target.x + _target.width &&
				_parent.mouseY > _target.y && _parent.mouseY < _target.y + _target.height)
			{
				var realX = _parent.mouseX - _target.x;
				
				if (realX < (_target.width - _w) / 2)				return left;
				else if (realX > (_target.width - _w) / 2 + _w)		return right;
				else												return middle;
			}
		#elseif js
			if (e.clientX > _target.offsetLeft && e.clientX < _target.offsetLeft + _target.offsetWidth &&
				e.clientY > _target.offsetTop && e.clientY < _target.offsetTop + _target.offsetHeight)
			{
				var realX = e.clientX - _target.offsetLeft;
				
				if (realX < (_target.offsetWidth - _w) / 2)				return left;
				else if (realX > (_target.offsetWidth - _w) / 2 + _w)	return right;
				else													return middle;
			}
		#end
		return outside;
	}
	
	function goIdle () :Void {
		_interval.stop();
		_is_idle = true;
		onIdle();
	}
	
	function resumeIdle () :Void {
		_is_idle = false;
		onResume();
	}
	
	
	
	public function destroy() :Void {
		hold();
		mouseOutHandler ( null );
	}
}
