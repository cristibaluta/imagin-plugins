interface IMMediaViewerInterface {
	
	public var view :RCView;
	public var percentLoaded :Int;
	public var errorMessage :String;
	public var isLoaded :Bool;
	public var isTweening :Bool;
	public var isVideo (get, null) :Bool;
	//public var scale (null, setScale) :Float;
	
	public function get_isVideo () :Bool;
	public function startVideo () :Void;
	public function stopVideo () :Void;
	public function show () :Void;
	public function hide () :Void;
	public function destroy () :Void;
	
	dynamic public function onComplete () :Void;
	dynamic public function onProgress () :Void;
	dynamic public function onError () :Void;
	dynamic public function videoDidStartPlaying () :Void;
	dynamic public function videoDidFinishPlaying () :Void;
	
}
