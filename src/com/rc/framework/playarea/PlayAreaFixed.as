/**
 * Created by rodrigo on 5/15/15.
 */
package com.rc.framework.playarea {
import com.rc.framework.cards.AbstractCard;
import com.rc.framework.deck.AbstractDeck;

import starling.utils.formatString;

public class PlayAreaFixed implements PlayArea {
    private var _name:String;
    private var _deckRef:AbstractDeck;
    private var _cards:Vector.<Object> = new Vector.<Object>();
    private var _maxCards:int;

    public function PlayAreaFixed(maxCards:int) {
        _maxCards = maxCards;
        for(var i:int=0; i < maxCards; i++) {
            _cards.push({
                card: null
            });
        }
    }

    public function set name(name:String):void {
        _name = name;
    }

    public function set deckRef(deckRef:AbstractDeck):void {
        _deckRef = deckRef;
    }

    public function addCard(card:AbstractCard, index:int = -1):void {
        if(index < 0 || index >= _maxCards) {
            throw new Error(formatString("wrong index '%d', value has to be between (0, %d)", index, _maxCards));
        }
        if(_cards[index].card != null) {
            trace("replacing card name %d", (_cards[index].card as AbstractCard).getName());
        }
        _cards[index].card = card;
    }

    public function removeCard(card:AbstractCard):void {
        for each(var obj:Object in _cards) {
            if(obj.card === card) {
                obj.card = null;
                return;
            }
        }
    }

    public function removeCardAt(index:int):void {
        if(index < 0 || index >= _maxCards) {
            throw new Error(formatString("wrong index '%d', value has to be between (0, %d)", index, _maxCards));
        }
        _cards[index].card = null;
    }

    public function getCardAt(index:int):AbstractCard {
        if(index < 0 || index >= _maxCards) {
            throw new Error(formatString("wrong index '%d', value has to be between (0, %d)", index, _maxCards));
        }
        return _cards[index].card;
    }

    public function getCards():Vector.<AbstractCard> {
        var returnCards:Vector.<AbstractCard> = new Vector.<AbstractCard>();
        for each(var obj:Object in _cards) {
            if(obj.card != null) {
                returnCards.push(obj.card);
            }
        }
        return returnCards;
    }

    public function clear():void {
        for each(var obj:Object in _cards) {
            obj.card = null;
        }
    }
}
}
