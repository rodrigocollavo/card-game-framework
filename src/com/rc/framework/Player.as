/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework {
public class Player {
    private var _lives:int;
    private var _energy:int;
    private var _imageBig:String;
    private var _imageIcon:String;

    public function get lives():int {
        return _lives;
    }

    public function set lives(value:int):void {
        _lives = value;
    }

    public function get energy():int {
        return _energy;
    }

    public function set energy(value:int):void {
        _energy = value;
    }

    public function get imageBig():String {
        return _imageBig;
    }

    public function set imageBig(value:String):void {
        _imageBig = value;
    }

    public function get imageIcon():String {
        return _imageIcon;
    }

    public function set imageIcon(value:String):void {
        _imageIcon = value;
    }
}
}
