/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.deck {
import com.rc.framework.cards.AbstractCard;
import com.rc.framework.deck.shuffle.IShuffleStrategy;
import com.rc.framework.deck.shuffle.RandomShuffleStrategy;

public class AbstractDeck {
    private static var shuffleStrategy:IShuffleStrategy = new RandomShuffleStrategy();
    protected var _cards:Vector.<AbstractCard>;
    protected  var _discardPile:Vector.<AbstractCard>;

    public function AbstractDeck() {
        _cards = new Vector.<AbstractCard>();
        _discardPile = new Vector.<AbstractCard>();
    }

    public static function shuffle(deck:Vector.<AbstractCard>):void {
        shuffleStrategy.execute(deck);
    }

    public function drawTopCard():AbstractCard {
        var card:AbstractCard = _cards.pop();
        if(!card)
            throw new Error("there aren't more cards to draw");
        discardCard(card);
        return card;

    }

    public function loadDeck(data:Object):void {
    }

    public function discardCard(card:AbstractCard):void {
        _discardPile.push(card);
    }

    public function getDiscardPile():Vector.<AbstractCard> {
        return _discardPile;
    }

    public function getDiscardTopCard():AbstractCard {
        if(_discardPile.length == 0)
            return null;
        var lastCard:AbstractCard = _discardPile[_discardPile.length - 1];
        return lastCard;
    }

    public function putDiscardPileBack(shuffleAll:Boolean):void {
        _cards = _cards.concat(_discardPile);
        _discardPile.slice(0);
        if(shuffleAll)
            shuffle(_cards);
    }
}
}
