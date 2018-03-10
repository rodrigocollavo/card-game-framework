/**
 * Created by Rodrigo Collavo on 2/11/15.
 */
package com.rc.framework.statemachine.states {
import com.rc.framework.AbstractBoard;

import starling.display.Sprite;
import starling.errors.AbstractMethodError;

public class AbstractState {
    protected var _board:AbstractBoard;
    protected var _view:Sprite;
    private var _stateName:String;

    public function setBoard(b:AbstractBoard):void {
        _board = b;
    }

    public function doStart():void {
        throw new AbstractMethodError();
    }

    public function doFinish():void {
        throw new AbstractMethodError();
    }

    public function set stateName(value:String):void {
        _stateName = value;
    }
}
}
