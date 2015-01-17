//
//  Slider
//
//  Created by Baluta Cristian on 2009-02-28.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package video;


class Slider extends RCView {
	
	var background :RCRectangle;
	var loader :RCRectangle;
	var indeterminateProgress :IndeterminateProgressBar;
	var slider :RCEllipse;
	var _value :Float;// progress bar (between 0...100)
	
	public var loaded (null, setLoaded) :Float;
	public var value (getValue, setValue) :Float;
	
	
	public function new (x, y, w, h:Int, color:Int){
		super (x, y, w, h);
		
		background = new RCRectangle (0, 0, w, h, 0xFFFFFF, 0.9, 6);
		//background.addEventListener (EVMouse.MOUSE_DOWN, onBackgroundPress);
		
		loader = new RCRectangle (2, 2, 2, 2, color, 0.8);
		loader.layer.mouseEnabled = false;
		loader.layer.mouseChildren = false;
		
		slider = new RCEllipse (0, 0, h, h, color);
		//slider.useHandCursor = true;
		//slider.mouseEnabled = true;
		//slider.buttonMode = true;
		//slider.addEventListener (EVMouse.MOUSE_DOWN, onSliderPress);
		
		this.addChild ( background );
		this.addChild ( loader );
		this.addChild ( slider );
	}
	
	
	/**
	 *	Functions to move the slider
	 */
	function onSliderPress (e:EVMouse) :Void {
/*		slider.startDrag (false, new flash.geom.Rectangle (0, 0, background.width - slider.width, 0));
		RCWindow.target.addEventListener (EVMouse.MOUSE_UP, onSliderRelease);
		RCWindow.target.addEventListener (EVMouse.MOUSE_MOVE, onSliderMove);
		this.dispatchEvent ( new SliderEvent (SliderEvent.PRESS, _value) );*/
	}
	
	function onSliderRelease (e:EVMouse) :Void {
		//slider.stopDrag();
/*		RCWindow.target.removeEventListener (EVMouse.MOUSE_UP, onSliderRelease);
		RCWindow.target.removeEventListener (EVMouse.MOUSE_MOVE, onSliderMove);
		this.dispatchEvent ( new SliderEvent (SliderEvent.RELEASE, _value) );*/
	}
	
	function onSliderMove (e:EVMouse) :Void {
		// Get the percent of the slider
		_value = Zeta.lineEquation (0, 100, slider.x, 0, background.width - slider.width);
		//this.dispatchEvent ( new SliderEvent (SliderEvent.ON_MOVE, _value) );
	}
	
	function onBackgroundPress (e:EVMouse) :Void {
		//this.dispatchEvent ( new SliderEvent (SliderEvent.PRESS, _value) );
		slider.x = Math.round (this.mouseX - slider.width/2);
		onSliderMove ( null );
		//RCWindow.target.addEventListener (EVMouse.MOUSE_UP, onSliderRelease);
	}
	
	
	function getValue () :Float {
		return _value;
	}
	
	function setValue (v:Float) :Float {
		_value = v;
		slider.x = Zeta.lineEquationInt (0, background.width - slider.width, v, 0, 100);
		return v;
	}
	
	function setLoaded (v:Float) :Float {
		loader.width = Zeta.lineEquationInt (0, background.width - 4, v, 0, 100);
		return v;
	}
	
	public function setW (w:Int) :Int {
		background.size.width = w;
		size.width = w;
		
		if (indeterminateProgress != null)
			indeterminateProgress.setW( w );
			
		loader.width = w - 4;
		setValue ( _value );
		return w;
	}
	
	public function addIndeterminateProgress() {
		indeterminateProgress = new IndeterminateProgressBar( 0, 0, RCWindow.sharedWindow().width-20, 6, MainVideo.COLOR, 0.4, 6);
		this.addChildAt ( indeterminateProgress, 1 );
		
/*		if (this.contains ( slider ))
			this.removeChild ( slider );*/
	}
	
	public function startProgress () {
		if (indeterminateProgress != null)
			indeterminateProgress.startProgress();
	}
	
	public function stopProgress () {
		if (indeterminateProgress != null)
			indeterminateProgress.stopProgress();
	}
	
	
	override public function destroy () :Void {
		//slider.removeEventListener (EVMouse.DOWN, onSliderPress);
		stopProgress();
	}
}
