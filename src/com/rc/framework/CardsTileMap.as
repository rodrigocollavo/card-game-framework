/**
 * Created by Rodrigo Collavo on 2/23/15.
 */
package com.rc.framework {
import com.rc.framework.cards.AbstractCard;

import flash.utils.Dictionary;

public class CardsTileMap {
    private var _currentPositionX:int;
    private var _currentPositionY:int;
    private var _cards:Dictionary;

    public function CardsTileMap() {
        _cards = new Dictionary();
    }

    public function setCardAt(card:AbstractCard, x:int, y:int):void {
        var xCards:Dictionary = _cards[x.toString()];
        if(!xCards) {
            xCards = new Dictionary();
            _cards[x.toString()] = xCards;
        }
        if(xCards[y.toString()] != null) {
            throw new Error("setting CardsTileMap card twice: " + x.toString() + ", " + y.toString());
        }
        xCards[y.toString()] = card;
    }

    public function getCardAt(x:int, y:int):AbstractCard {
        var xCards:Dictionary = _cards[x.toString()];
        if(!xCards)
            return null;

        return xCards[y.toString()];
    }

    public function getCurrentCard():AbstractCard {
        return getCardAt(_currentPositionX, _currentPositionY);
    }

    public function advanceUp():void {
        _currentPositionY++;
    }

    public function advanceDown():void {
        _currentPositionY--;
    }

    public function advanceLeft():void {
        _currentPositionX--;
    }

    public function advanceRight():void {
        _currentPositionX++;
    }

    public function get x():int {
        return _currentPositionX;
    }

    public function get y():int {
        return _currentPositionY;
    }
}
}
