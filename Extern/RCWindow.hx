
#if (flash || nme)
	import flash.display.MovieClip;
	import flash.display.Stage;
#elseif js
	import js.Dom;
#end


extern class RCWindow extends RCView {
	
	public static function sharedWindow (?id:String) :RCWindow {}
	
	
#if (flash || nme)
	public var target :MovieClip;
	public var stage :Stage;
#elseif js
	public var target :HtmlDom;
	public var stage :HtmlDom;
#end
	
	public function fullscreen () :Void {}
	public function normal () :Void {}
	public function isFullScreen () :Bool {}
	public function supportsFullScreen () :Bool {}
	
}
