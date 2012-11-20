//
//  MainVideo
//
//  Created by Baluta Cristian on 2009-02-28.
//  Copyright (c) 2009 http://ralcr.com. All rights reserved.
//
package v4.video;

//import flash.events.Event;
//import flash.external.ExternalInterface;

class VideoController extends RCView {
	
/*	inline public static var URL :String = RCWindow.sharedWindow().target.loaderInfo.parameters.url;
	public static var FILE :String = RCWindow.sharedWindow().target.loaderInfo.parameters.file;
	inline public static var COLOR :Int = Std.parseInt ( "0x" + RCWindow.sharedWindow().target.loaderInfo.parameters.color );
	inline public static var AUTOSTART :Bool = RCWindow.sharedWindow().target.loaderInfo.parameters.autostart == "true";
	
	dynamic public function videoDidFinishPlaying () :Void {}*/
	
	
	/**
	 * Start the Application
	 */
	static function main () {
		
/*#if desktop
		// connect to System
		var cnx = swhx.Connection.desktopConnect();
			cnx.MainDesktop.show.call ( [800, 500] );
			//cnx.MainDesktop.fullscreen.call ( [] );
#else
		haxe.Firebug.redirectTraces();
#end
		
		// Scena should be initialized before anything
		RCWindow.sharedWindow();
		RCUserDefaults.init("imaginVideo");
		
		
		// Init the font
		RCFontManager.init();
		
		var fnt = new RCFont();
			fnt.font = new fonts.UrbanR().fontName;
			fnt.size = 8;
			fnt.color = 0xFFFFFF;
			fnt.letterSpacing = 0;
			fnt.leading = 0;
			fnt.align = "left";
			fnt.font = new fonts.UrbanR().fontName;
			
			
		RCFontManager.registerFont("default", fnt);
		
		RCWindow.sharedWindow().addChild ( new MainVideo() );*/
	}
	
	
	
/*	var over :Bool;
	var media :RCVideo;// RCVideo, RCRtmp, YouTube
	var slider :Slider;
	var volume :Slider;
	var butPlay :RCButton;
	var butPause :RCButton;
	var ratio :Float;*/
	
	
/*	public function new () {
		super(0,0);
		
		ratio = RCWindow.sharedWindow().width / RCWindow.sharedWindow().height;
		over = false;
		
		RCNotificationCenter.addObserver ("resize", onResize);
		RCNotificationCenter.addObserver ("fullscreen", onFullScreen);
		//RCWindow.stage.addEventListener (EVMouse.MOVE, onMouseMoveHandler);
		//RCWindow.stage.addEventListener (Event.MOUSE_LEAVE, onLeaveRCWindowHandler);
		
		// External API
		ExternalInterface.addCallback ("startVideo", startVideo);
		ExternalInterface.addCallback ("pauseVideo", pauseVideo);
		ExternalInterface.addCallback ("resumeVideo", resumeVideo);
		ExternalInterface.addCallback ("destroy", destroy);
		
		// Start the URL passed as an argument
		startVideo ( URL, FILE );
	}
	
	public function startVideo (URL:String, ?file:String=null) {
		
		// Destroy any previous instance of the player
		destroy();
		
		// Check if URL was passed
		if (URL == "" || URL == null) return;
		
		// Analyze the URL
		var parts = URL.split("/");
		var lastPart = parts.pop();
		FILE = file;
		
		// Add the progress slider
		slider = new Slider (10, RCWindow.sharedWindow().height-10, RCWindow.sharedWindow().width - 20, 6, COLOR);
		slider.addEventListener (SliderEvent.RELEASE, onSliderReleased);
		slider.addEventListener (SliderEvent.ON_MOVE, onSliderMoving);
		
		// Add volume
		volume = new Slider (RCWindow.sharedWindow().width - 110, RCWindow.sharedWindow().height-10, 100, 6, COLOR);
		volume.addEventListener (SliderEvent.ON_MOVE, onVolumeMoving);
		volume.addEventListener (SliderEvent.RELEASE, onVolumeReleased);
		
		// Rtmp
		if (URL.indexOf("rtmp://") == 0) {
			media = new RCRtmp (0, 0, URL, RCWindow.sharedWindow().width, RCWindow.sharedWindow().height);
			media.onBufferEmpty = onBufferEmpty;
			media.onBufferFull = onBufferFull;
			slider.addIndeterminateProgress();
			slider.startProgress();
		}
		
		// Flv
		else if (lastPart.indexOf(".") != -1)
			media = new RCVideo (0, 0, URL, RCWindow.sharedWindow().width, RCWindow.sharedWindow().height);
		
		// YouTube
		else 
			media = new YouTube (0, 0, URL, RCWindow.sharedWindow().width, RCWindow.sharedWindow().height);
		
		media.onInit = onInit;
		media.onLoadingProgress = onLoadingProgress;
		media.onPlayingProgress = onPlayingProgress;
		media.videoDidFinishPlaying = videoDidFinishPlayingHandler;
		media.layer.mouseChildren = false;
		media.layer.doubleClickEnabled = true;
		media.layer.addEventListener (EVMouse.DOUBLE_CLICK, onMediaDoubleClickHandler);
		media.init();
		
		this.addChild ( media );
		this.addChild ( slider );
		
	}
	
	function onInit () :Void {
		
		var vol :Null<Float> = RCUserDefaults.intForKey ("volume");
		if (vol == null)
			vol = 80;
		
		//onVolumeMoving ( new SliderEvent(SliderEvent.ON_MOVE, vol) );
		volume.value = vol;
		
		//if ( AUTOSTART )
			media.startVideo ( (FILE != "" && FILE != null) ? FILE : null );
	}
	
	public function pauseVideo () {
		if (media != null)
			media.pauseVideo();
	}
	
	public function resumeVideo () {
		if (media != null)
			media.resumeVideo();
	}
	
	override public function destroy(){
		if (media != null) {
			media.destroy();
			slider.destroy();
			volume.destroy();
			media.removeFromSuperView();
			slider.removeFromSuperView();
			volume.removeFromSuperView();
			media = null;
			slider = null;
			volume = null;
		}
		super.destroy();
	}
	
	
	function onLoadingProgress () :Void {
		if (slider != null)
			slider.loaded = Zeta.lineEquationInt (0, 100, media.percentLoaded, 0, 100);
	}
	
	function onPlayingProgress () :Void {
		if (slider != null)
			slider.value = Zeta.lineEquation (0, 100, media.time, 0, media.duration);
	}
	
	function onBufferEmpty () :Void {
		slider.visible = true;
		slider.startProgress();
	}
	
	function onBufferFull () :Void {
		slider.visible = false;
		slider.stopProgress();
	}
	
	function onMediaDoubleClickHandler (e:EVMouse) :Void {
		if (RCWindow.sharedWindow().isFullScreen())
			RCWindow.sharedWindow().normal();
		else
			RCWindow.sharedWindow().fullscreen();
	}
	
	function videoDidFinishPlayingHandler () :Void {
		videoDidFinishPlaying();
	}
	
	
	
	function onSliderReleased () :Void {
		media.stopSeeking();
	}
	
	function onSliderMoving () :Void {
		//media.seekTo ( e.value );
	}
	
	
	function onVolumeReleased () :Void {
		//RCUserDefaults.set ("volume", e.value);
	}
	
	function onVolumeMoving () :Void {
		volume.loaded = e.value;
		media.volume = e.value / 100;
	}
	
	
	
	function onMouseMoveHandler (e:EVMouse) :Void {
		if (!over && media != null) {
			over = true;
			this.addChild ( volume );
			slider.setW ( Math.round ( RCWindow.sharedWindow().width - 100 - 20 - 10) );
		}
	}
	
	function onLeaveRCWindowHandler (e:Event) :Void {
		if (over && media != null) {
			over = false;
			//if (this.contains(volume)) this.removeChild ( volume );
			slider.setW ( Math.round ( RCWindow.sharedWindow().width - 20) );
		}
	}
	
	function onFullScreen(){
		if (media != null) {
			if (RCWindow.sharedWindow().isFullScreen()) {
				media.height = RCWindow.sharedWindow().height;
				media.width = RCWindow.sharedWindow().width;// / ratio;
				media.x = RCWindow.sharedWindow().getCenterX ( media.width );
			}
			else {
				media.width = RCWindow.sharedWindow().width;
				media.height = RCWindow.sharedWindow().height;
				media.x = 0;
			}
		}
		
		slider.y = volume.y = RCWindow.sharedWindow().height - 10;
		volume.x = RCWindow.sharedWindow().width - 110;
		slider.setW ( Math.round (RCWindow.sharedWindow().width - 100 - 20 - 10) );
		this.addChild ( volume );
	}
	
	function onResize (w:Int, h:Int) :Void {
		
	}*/
}
