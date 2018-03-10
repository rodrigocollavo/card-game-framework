/**
 * Created by rodrigo on 5/15/15.
 */
package com.rc.framework.playarea {
import com.rc.framework.cards.AbstractCard;
import com.rc.framework.deck.AbstractDeck;
import com.rc.framework.playarea.PlayArea;

public class PlayAreaQueue implements PlayArea {
    private var _name:String;
    private var _deckRef:AbstractDeck;
    private var _cards:Vector.<AbstractCard> = new Vector.<AbstractCard>();

    public function set name(value:String):void {
        _name = value;
    }

    public function set deckRef(deck:AbstractDeck):void {
        _deckRef = deck;
    }

    public function addCard(card:AbstractCard, index:int = -1):void {
        _cards.push(card);
    }

    public function removeCard(card:AbstractCard):void {
        var index:int = _cards.indexOf(card);
        if(index >=0)
            _cards.splice(index, 1);
    }

    public function removeCardAt(index:int):void {
        if(index < _cards.length)
            _cards.splice(index, 1);
    }

    public function getCardAt(index:int):AbstractCard {
        if(index < _cards.length)
            return _cards[index];
        return null;
    }

    public function getCards():Vector.<AbstractCard> {
        return _cards;
    }

    public function clear():void {
        _cards.splice(0, _cards.length);
    }
}
}
