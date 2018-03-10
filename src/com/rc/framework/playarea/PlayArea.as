/**
 * Created by rodrigo on 5/15/15.
 */
package com.rc.framework.playarea {
import com.rc.framework.cards.AbstractCard;
import com.rc.framework.deck.AbstractDeck;

public interface PlayArea {
    function set name(name:String):void;
    function set deckRef(deckRef:AbstractDeck):void;

    function addCard(card:AbstractCard, index:int = -1):void;
    function removeCard(card:AbstractCard):void;
    function removeCardAt(index:int):void;
    function getCardAt(index:int):AbstractCard;
    function getCards():Vector.<AbstractCard>;
    function clear():void;
}
}
