/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework {
import starling.events.EventDispatcher;

/*
Control specific turn events, like midnight every X turns
 */
public class TurnController extends EventDispatcher {
    public static const EVENT_FINISHED:String = "finished";
    private var _currentTurn:int;
    private var _totalTurns:int;
    private var _events:Vector.<Object>;

    public function TurnController(turns:int = int.MAX_VALUE) {
        _currentTurn = 1;
        _totalTurns = turns;
        _events = new Vector.<Object>();
    }

    public function addEvent(name:String, turn:int, listener:Function = null):void {
        _events.push({
            n: name,
            t: turn,
            l: listener
        });
    }
    public function advanceTurn():void {
        _currentTurn++;
        trace("new turn " + _currentTurn.toString());
        if(_totalTurns != int.MAX_VALUE)
            checkEvents();
    }

    private function checkEvents():void {
        for each(var event:Object in _events) {
            if(event.t == _currentTurn) {
                dispatchEventWith(event.name);
                if(event.l && event.l is Function)
                    event.l();
                _events.splice(_events.indexOf(event), 1);
            }
        }
    }

    public function get currentTurn():int {
        return _currentTurn;
    }
}
}
