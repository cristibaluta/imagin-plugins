
@:expose interface ViewerInterface {

public var view :RCView;
public var previewsLimits :RCRect;

// Xml properties
public var alignmentPhotos :String;
public var transition :String;
public var transitionOnClick :String;
public var sort :String;
public var speed :Float;
public var pause :Float;
public var enableBackground :Bool;
public var colorBackgroundUnderPhoto :Null<Int>;
public var enableShadow :Bool;
public var scaleMode :String;
public var colorLink :Int;
public var alignmentTitle :String;
public var scrollDirection :String;
public var autostopSlideshow :Bool;
public var slideshowIsRunning :Bool;

public var tick :RCSignal<Int->Int->Void>;
public var timerComplete :RCSignal<Void->Void>;
public var slideCycleFinished :RCSignal<Void->Void>;

public function initWithFile (?file:String) :Void;
public function startSlideshow () :Void;
public function stopSlideshow () :Void;
public function pauseSlideshow () :Void;
public function switchPhotos (current:IMMediaViewerInterface, next:IMMediaViewerInterface, mouseActioned:Bool) :Void;
public function resize (limits:RCRect) :Void;
public function arrangePhoto (photoView:IMMediaViewerInterface) :Void;
public function destroy () :Void;

}
