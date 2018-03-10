/**
 * Created by Rodrigo Collavo on 2/13/15.
 */
package com.rc.framework.rules {
import starling.events.EventDispatcher;

public class GameRules extends EventDispatcher{
    private var _rules:Vector.<Rule>;

    public function GameRules() {
        _rules = new Vector.<Rule>();
    }
    public function addRule(id:String, qty:int, event:String):void {
        _rules.push(new Rule(id, qty, event));
    }

    public function gameEvent(id:String, qty:int = 1):void {
        for each(var rule:Rule in _rules) {
            if(id == rule.id && rule.increment(qty)) {
                dispatchEventWith(rule.event);
            }
        }
    }
}
}
