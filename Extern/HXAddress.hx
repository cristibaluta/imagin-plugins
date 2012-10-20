/**
 * SWFAddress 2.4: Deep linking for Flash and Ajax <http://www.asual.com/swfaddress/>
 *
 * SWFAddress is (c) 2006-2009 Rostislav Hristov and contributors
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 *
 */

typedef HXAddressSignalListener = Array<String>->Void;

extern class HXAddress {

	public static var init :HXAddressSignal;
	public static var change :HXAddressSignal;
	public static var externalChange :HXAddressSignal;
	public static var internalChange :HXAddressSignal;
	
	
	public static function back () :Void;
	public static function forward () :Void;
    public static function up () :Void;
	public static function go (delta:Int) :Void;
	public static function href (url:String, ?target:String) :Void;
	public static function popup (url:String, ?name:String, ?options:String, ?handler:String) :Void;
	public static function getBaseURL () :String;
	public static function getStrict () :Bool;
	public static function setStrict (strict:Bool) :Void;
	public static function getHistory () :Bool;
	public static function setHistory (history:Bool) :Void;
	public static function getTracker () :String;
	public static function setTracker (tracker:String) :Void;
	public static function getTitle () :String;
	public static function setTitle (title:String) :Void;
	public static function getStatus () :String;
	public static function setStatus (status:String) :Void;
	public static function resetStatus () :Void;
	public static function getValue () :String;
	public static function setValue (value:String) :Void;
	public static function getPath () :String;
	public static function getPathNames () :Array<String>;
	public static function getQueryString () :String;
	public static function getParameter (param:String) :String;
	public static function getParameterNames () :Array<String>;
}



extern class HXAddressSignal {
	
	public function new () :Void {}
	public function add (listener:HXAddressSignalListener) :Void {}
	public function remove (listener:HXAddressSignalListener) :Void {}
	public function removeAll () :Void {}
	public function dispatch (args:Array<String>) :Void {}
}
