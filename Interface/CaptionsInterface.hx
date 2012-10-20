//
//  CaptionsInterface
//
//  Created by Baluta Cristian on 2009-08-16.
//  Copyright (c) 2012 http://ralcr.com. All rights reserved.
//
interface CaptionsInterface {

public var view :RCView;

public function show (photo:Photo) :Void;
public function remove (photo:Photo) :Void;
public function resize (w:Int, h:Int) :Void;
public function destroy () :Void;

}
