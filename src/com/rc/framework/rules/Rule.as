/**
 * Created by Rodrigo Collavo on 2/13/15.
 */
package com.rc.framework.rules {
public class Rule {
    private var _id:String;
    private var _event:String;
    private var _qty:uint;
    private var _counter:uint;

    public function Rule(id:String, qty:int, event:String) {
        _id = id;
        if(qty == 0)
            throw new Error("Rule " + id + " is not valid. qty: " + qty.toString());
        _qty = qty;
        _event = event;
    }

    public function get id():String {
        return _id;
    }

    public function get event():String {
        return _event;
    }

    public function increment(value:int = 1):Boolean {
        _counter += value;
        if(_qty == _counter)
            return true;
        return false;
    }
}
}
