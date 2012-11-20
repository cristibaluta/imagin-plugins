package admin;


class Licence {
	
	static var read :RCHttp;
	dynamic public static function onLicensed():Void {}
	dynamic public static function onNotLicensed():Void {}
	
	
	public static function init () :Void {
		#if flash
		var domain = flash.external.ExternalInterface.call ("eval", "document.domain");//document.location.href
		#elseif js
		var domain = HXAddress.getBaseURL();
		#end
		trace("domain: "+domain);
		
		read = new RCHttp ("");
		read.onComplete = completeHandler;
		read.onError = errorHandler;
		read.call ("http://imagin.ro/services/licence.php", {domain : domain});
	}
	
	static function completeHandler () :Void {
		//trace("licence: "+read.result);
		if (read.result == "0")
			onNotLicensed();
		else
			onLicensed();
	}
	
	static function errorHandler () :Void {
		trace("licence error: "+read.result);
		// If the license wasn't verifyed assume by default that is licensed
		onLicensed();
	}
}
