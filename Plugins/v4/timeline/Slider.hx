//
//  TimelineSlider
//
//  Created by Baluta Cristian on 2008-12-23.
//  Copyright (c) 2008 http://imagin.ro. All rights reserved.
//
package v4.timeline;


class Slider extends RCView {
	
	var normalState :RCView;
	var expandedState :RCView;
	var arrowState :RCView;
	//var labelText :RCTextView;
	var color :Int;
	var label :String;
	inline static var MIN_W :Int = 16;


	public function new (color:Int) {
		super (0, 0);
		this.label = ">";
		this.color = color;
		//this.mouseEnabled = false;
		//this.mouseChildren = false;
	}
	
	function addNormalState() {
		if (normalState != null) return;
			normalState = new RCView (0, 0);
			//normalState.mouseEnabled = false;
		var c1 = new RCRectangle(-3,-3,6,6,color);//RCEllipse (-3,-3, 6, 6, color);
			//c1.mouseEnabled = false;
			normalState.addChild ( c1 );
	}
	
	function addExpandedState() {
		
		if (expandedState != null) return;
			expandedState = new RCView (0, 0);
			//expandedState.mouseEnabled = false;
			
/*		var color_text = color > 0x999999 ? 0x000000 : 0xFFFFFF;
		var format = RCFontManager.getFont("default", {color:color_text, leading:4});
		labelText = new RCTextView (0, 0, null, null, label, format);
		labelText.x = Math.round ( -labelText.width/2 + 2);
		labelText.y = Math.round ( -labelText.height/2 + 4);*/
		//labelText.mouseEnabled = false;
		
/*		var c1 = new RCEllipse (-MIN_W/2, -MIN_W/2, MIN_W+4, MIN_W+4, 0xFFFFFF);
		var c2 = new RCEllipse (-MIN_W/2+2, -MIN_W/2+2, MIN_W, MIN_W, color);*/
			//c1.mouseEnabled = false;
			//c2.mouseEnabled = false;
			
/*		expandedState.addChild ( c1 );
		expandedState.addChild ( c2 );
		expandedState.addChild ( labelText );*/
	}
	
	function addArrowState() {
		if (arrowState != null) return;
			arrowState = new RCView (0, 0);
			//arrowState.mouseEnabled = false;
		var points = [ new RCPoint(0,0), new RCPoint(6,0), new RCPoint(3,3) ];
		var c1 = new RCPolygon (-3,-3, points, color);
			//c1.mouseEnabled = false;
			arrowState.addChild ( c1 );
	}
	
	
	public function setLabel (label:String) :String {
/*		if (labelText != null) {
			labelText.text = label;
			labelText.x = Math.round ( -labelText.width/2 + 2);
			labelText.y = Math.round ( -labelText.height/2 + 4);
		}*/
		return label;
	}
	
	public function expand () :Void {
		Fugu.safeRemove ( [normalState, arrowState] );
		addExpandedState();
		this.addChild ( expandedState );
	}
	public function normal () :Void {
		Fugu.safeRemove ( [expandedState, arrowState] );
		addNormalState();
		this.addChild ( normalState );
	}
	public function arrow () :Void {
		Fugu.safeRemove ( [normalState, expandedState] );
		addArrowState();
		this.addChild ( arrowState );
	}
	
	
	override public function destroy () :Void {
/*		Fugu.safeDestroy ( labelText );
		labelText = null;*/
		super.destroy();
	}
}
