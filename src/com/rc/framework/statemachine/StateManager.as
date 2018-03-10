/**
 * Created by Rodrigo Collavo on 2/13/15.
 */
package com.rc.framework.statemachine {
import com.rc.framework.statemachine.states.AbstractState;

import starling.errors.AbstractMethodError;

public class StateManager {
    protected var _currentState:AbstractState;

    public function get currentState():AbstractState {
        return _currentState;
    }

    public function changeState(state:String):void {
        if(_currentState)
            _currentState.doFinish();

        createState(state);
        trace("new state: " + state);
        _currentState.doStart();
    }

    protected function createState(state:String):void {
        throw new AbstractMethodError();
    }
}
}
