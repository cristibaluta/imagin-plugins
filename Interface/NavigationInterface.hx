
interface NavigationInterface {

public var view :RCView;

public function init () :Void;
public function resume () :Void;
public function hold () :Void;
public function resize (limits:RCRect) :Void;
public function destroy () :Void;

}
