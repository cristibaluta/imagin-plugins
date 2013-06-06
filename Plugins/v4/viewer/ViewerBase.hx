package v4.viewer;


@:keep class ViewerBase extends RCView {
	
	// Settings initialized from the Logic Controller
	public var view :RCView;
	var limits :RCRect;
	public var previewsLimits :RCRect;// The limits of the previews scroll view, you can start animating the photobackground from this position
	// Xml settings
	public var alignmentPhotos :String;// This will align the photos inside framePhotos
	public var transition :String;
	public var transitionOnClick :String;
	public var sort :String;
	public var speed :Float;
	public var pause :Float;
	public var enableBackground :Bool;
	public var colorBackgroundUnderPhoto :Null<Int>;
	public var enableShadow :Bool;
	public var scaleMode :String;// none, fill, fit
	public var colorLink :Int;
	public var alignmentTitle :String;
	public var scrollDirection :String;
	public var autostopSlideshow :Bool;
	public var slideshowIsRunning :Bool;
	
	public var tick :RCSignal<Int->Int->Void>;
	public var slideCycleFinished :RCSignal<Void->Void>;
	public var timerComplete :RCSignal<Void->Void>;
	
	
	// After instantiation you should fill the properties from outside
	public function new (x, y) {
		trace("new viewerbase");
		super (x, y);
		
		view = this;// Required by the interface
		
		tick = new RCSignal<Int->Int->Void>();
		slideCycleFinished = new RCSignal<Void->Void>();
		timerComplete = new RCSignal<Void->Void>();
	}
	
	public function resize (limits:RCRect) :Void {
		
		this.limits = limits;
		
		set_width ( limits.size.width );
		set_height ( limits.size.height );
	}
	
	override public function destroy () :Void {
		
		tick.destroy();
		slideCycleFinished.destroy();
		timerComplete.destroy();
		
		super.destroy();
	}
	
	
	
	public function toString2 () :String {
		var c = "ViewerBase ";//super.toString();
		return [c+" -> limits: "+limits,
				"transition: "+transition,
				"transitionOnClick: "+transitionOnClick,
				"sort: "+sort,
				"speed: "+speed,
				"pause: "+pause,
				"enableBackground: "+enableBackground,
				"colorBackgroundUnderPhoto: "+colorBackgroundUnderPhoto,
				"enableShadow: "+enableShadow,
				"scaleMode: "+scaleMode,
				"colorLink: "+colorLink,
				"alignmentTitle: "+alignmentTitle,
				"scrollDirection: "+scrollDirection,
				"autostopSlideshow: "+autostopSlideshow,
				"slideshowIsRunning: "+slideshowIsRunning].join("\n");
	}
}
