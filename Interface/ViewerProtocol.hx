// PhotosViewController should implement this and assign to the corresponding signals

interface ViewerProtocol {
	
	public function tick (currentCount:Int, maxCount:Int) :Void;
	public function slideCycleFinished () :Void;
	public function timerComplete () :Void;
	
}
