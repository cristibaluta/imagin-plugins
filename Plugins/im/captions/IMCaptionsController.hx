//
//  Display description under each photo
//
//  Created by Baluta Cristian on 2008-12-26.
//  Copyright (c) 2008-2012 http://imagin.ro. All rights reserved.
//
package im.captions;


class IMCaptionsController extends RCView implements IMCaptionsInterface {
	
	var path :String;
	var alignment :String;
	var captionView :CaptionView;
	public var view :RCView;
	
	
	public function new (path:String) {
		
		super (0, 0);
		
		this.view = this;
		this.path = path;
		this.alignment = IMPreferences.stringForKey ("frame_caption");
		
		captionView = new CaptionView();
		show ( null );
	}
	
	
	/**
	 *	Add a new caption
	 */
	public function show (photo:IMPhoto) :Void {
		
		if (photo == null) return;
		
		this.addChild ( captionView );
		captionView.initWithURL ( photo.photoURL );
	}
	
	/**
	 *	Remove an existing caption from the display list, but keep it loaded
	 */
	public function remove (photo:IMPhoto) :Void {
		Fugu.safeRemove ( captionView );
	}
	
	
	public function resize (w:Int, h:Int) :Void {
		
/*		this.w = Math.round ( photo.width );
		this.x = photo.x;// Alignment on x is always to the x of the photo
		text.x = switch (_align) {
			case "r":	Math.round (background.width - 40 - text.width); // right
			case "m":	Math.round ((background.width - 40 - text.width) / 2); // middle
			default :	10;// left
		}
		
		this.y = switch (_align.split(",")[1].toLowerCase()) {
			case "ti": photo.y;// top inside
			case "to": photo.y - this.height;// top outside
			case "bi": photo.y + photo.height - this.height;// bottom inside
			case "bo": photo.y + photo.height;// BO - bottom outside
			case "b" : photo.y + photo.height;// BO - bottom outside
			default	 : Std.parseInt ( _align.split(",")[1] );
		}
		
		if (this.y > h - this.height && direction == "horizontal")
			this.y = h - this.height - 18;*/
	}
	
	
	override public function destroy () :Void {
		
		captionView.destroy();
		captionView = null;
		super.destroy();
	}
	
	
	// Don't do anything, this is a plugin
	public static function main () {
		Type.resolveClass("");// Hack to include the class definitions in the generated code
	}
	
}
