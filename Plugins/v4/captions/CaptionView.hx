//
//  Caption line
//
//  Created by Baluta Cristian on 2009-01-23.
//  Copyright (c) 2009 http://imagin.ro. All rights reserved.
//
package v4.captions;


class CaptionView extends RCView {
	
	var req :IMURLRequest;
	var background :RCRectangle;
	//var text :RCTextView;
	var butFacebook :RCButton;
	var butTwitter :RCButton;
	var butGoogleEarth :RCButton;
	
	// Xml settings
	var alignment :String;
	var enableCaption :Bool;
	var enableExif :Bool;
	var enableSocial :Bool;
	
	
	public function new () {
		
		super (90, 60);
		
		// xml settings
		alignment = Preferences.stringForKey ("frame_caption");
		enableCaption = Preferences.boolForKey ("enable_captions");
		enableSocial = Preferences.boolForKey ("enable_social");
		enableExif = Preferences.boolForKey ("enable_exif");
		
		var socialHtml = '
			
			<!-- <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script> -->

			<!-- <iframe src="//www.facebook.com/plugins/like.php?href&amp;send=false&amp;layout=button_count&amp;width=450&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:21px;" allowTransparency="true"></iframe>
			-->
			<!-- <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script> -->
		
			<div id="fb-root"><fb:like send="false" layout="button_count" width="450" show_faces="false"></fb:like></div>
			<div class="google-share-button"><g:plusone size="medium"></g:plusone></div>
			<a href="http://twitter.com/share" class="twitter-share-button" data-count="horizontal">Tweet</a>
		';
		
/*		layer.innerHTML = '
			
			<div>
			    <a id="gp-share-10173142" class="gp-share" title="share link to this question on Google+">share [g+]</a>
			    <a id="fb-share-10173142" class="fb-share" title="share link to this question on Facebook">share [fb]</a>
			    <a id="twitter-share-10173142" class="twitter-share" title="share link to this question on Twitter">share [tw]</a>    
			</div>
			
			';*/
			  		
/*			<script>
					$.getJSON("http://urls.api.twitter.com/1/urls/count.json?url=http%3A%2F%2F500px.com%2Fphoto%2F5349668&callback=?", function(data) { 
						if ((data.count != 0) && (data.count != undefined) && (data.count != null)) {
							$("#twbutton").addClass('hascount');			
							$("#twbutton").append('  <span class="count">'+data.count+'</span>');
						}				
					});
		
				$.getJSON("https://graph.facebook.com/http%3A%2F%2F500px.com%2Fphoto%2F5349668&callback=?", function(data) {
					if ((data.shares != 0) && (data.shares != undefined) && (data.shares != null)) {
						$("#fbbutton").addClass('hascount');	
						$("#fbbutton").append('  <span class="count">'+data.shares+'</span>');
					}				
				});

			</script>
	
		
			<!-- FB -->
			<a class="button" id="fbbutton" onclick="fbpopup('http://www.facebook.com/sharer.php?u=http%3A%2F%2F500px.com%2Fphoto%2F5349668'); return false;">
				&nbsp;</a>&nbsp;
	
		  		
			<!-- TW -->
			<a class="button" id="twbutton" onClick="twpopup('http://twitter.com/intent/tweet?text=Photo &ldquo;softness&rdquo; by Karen  Abramyan  %23500px&url=http%3A%2F%2F500px.com%2Fphoto%2F5349668'); return false;">
				&nbsp;</a>&nbsp;
	
	
			<!-- SU -->
			<a class="button" id="subutton" href="http://www.stumbleupon.com/submit?url=http%3A%2F%2F500px.com%2Fphoto%2F5349668&title=softness&rdquo; by Karen  Abramyan" target="_sushare">&nbsp;</a>&nbsp;
			*/
/*			function twpopup(popwhat) {
						window.open( popwhat, "twshare", "height=400,width=550,resizable=1,toolbar=0,menubar=0,status=0,location=0" ) 
					}
					function fbpopup(popwhat) {
						window.open( popwhat, "fbshare", "height=380,width=660,resizable=0,toolbar=0,menubar=0,status=0,location=0,scrollbars=0" ) 
					}*/
			
/*		var elem = js.Lib.document.createElement("fb:like");
			//elem.attr("href", "");
			<fb:like send="false" layout="button_count" width="450" show_faces="false"></fb:like>
		layer.appendChild(elem);*/
		//untyped FB.XFBML.parse( layer );
		//untyped gapi.plusone.render( layer );
		//untyped js.Lib.document.getElementById("twitter-share-button").render();
		//untyped twttr.widgets.load();
		
		
		var s = new SkinButtonWithImage (Config.THEME_PATH+"LogoFacebook.png");
		butFacebook = new RCButton (0, 0, s);
		//butFacebook.onRelease = callback (HXAddress.popup, "http://www.facebook.com/sharer.php?u="+js.Lib.window.location.href, "fb_im_popup", "", "");
		butFacebook.onRelease = function() {
			HXAddress.popup ("http://www.facebook.com/sharer.php?u="+js.Lib.window.location.href, "fb_im_popup", "", "");
		}
		addChild ( butFacebook );
		
		var s = new SkinButtonWithImage (Config.THEME_PATH+"LogoTwitter.png");
		butTwitter = new RCButton (20, 0, s);
		butTwitter.onRelease = callback (HXAddress.href, "http://twitter.com", "_blank");
		addChild ( butTwitter );
		
		
	}
	
	function instantiateCaptions () {
		trace("ready");
	}
	
	
	
	public function initWithURL (URL:String) {
		
		// Read the caption from IPTC metadata
		req = new IMURLRequest ( Config.API_DIR );
		req.onComplete = parseFileInfo;
		req.onError = errorHandler;
		req.loadExif ( URL );
		
	}
	
	
	function parseFileInfo () :Void {
		trace(req.exif);
		layer.innerHTML = req.exif.toString();
		/*
		var description :String = Reflect.field (req.result, "description");
		var city :String = Reflect.field (req.result, "city");
		var location :String = Reflect.field (req.result, "location");
		var geodata :String = Reflect.field (req.result, "geodata");
		var parameters :String = Reflect.field (req.result, "parameters");
		
		var str = "";
		
		if (_enable_caption && description != null && description != "")
			str += description;
		//
		if (_enable_caption && city != null && city != "")
			str += (str != "" ? " " : "") + "(" + city + ")";
		//
		if (_enable_exif && parameters != null && parameters != "")
			str += (str != "" ? "\n" : "") + parameters;
		//
		if (str == "") return;
		
		
		// Add the description
		text = new RCTextView (10, 4, size.width-40, null, str, RCFontManager.getFont("regular", {leading:0}));
		background = new RCRectangle (0, 0, size.width, text.height + 10, 0x000000, 0.75);
		
		this.addChild ( background );
		this.addChild ( text );
		
		
		if (location.indexOf ("http://") == 0) {
			// We have link to flickr (theoreticaly)
			link = constructButton();
			link.onClick = callback (goto, location);
			this.addChild ( link );
		}
		else if (geodata != "" && geodata != "+" && geodata != null) {
			// We have geodata coordinates in photo exif
			var google_maps_link = "http://maps.google.com/maps?q=" + geodata;
			link = constructButton();
			link.onClick = callback (goto, google_maps_link);
			this.addChild ( link );
		}
		else if (location != "" && location != null) {
			// We have Wikimapia longitude and latitude
			var wikimapia_link = "http://wikimapia.org/#" + location + "&z=16&l=0&m=a&v=2";
			link = constructButton();
			link.onClick = callback (goto, wikimapia_link);
			this.addChild ( link );
		}
		
		align2 (_photo, _direction, _h);
		show();*/
	}
	
/*	function constructButton () :RCButton {
		var s = new SkinButtonWithLinkage ("Earth", [null, null, null, null]);
		var b = new RCButton (_w - 20, 3, s);
		return b;
	}*/
	
	function errorHandler() :Void {
		trace(req.exif);
	}
	
	function goto (URL:String) :Void {
		//HXAddress.href (URL, "_blank");
	}
	
	
/*	function getW () :Int {
		return _w;
	}
	function setW (w:Int) :Int {
		_w = w;
		if (background != null) {
			background.width = _w;
			text.w = _w - 40;
		}
		if (link != null)
			link.x = _w - 20;
		return _w;
	}*/
	
	
	override public function destroy () :Void {
		req.destroy();
		req = null;
		super.destroy();
	}
}
