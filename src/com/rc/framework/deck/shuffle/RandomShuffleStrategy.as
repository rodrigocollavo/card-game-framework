/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.deck.shuffle {
import com.rc.framework.cards.AbstractCard;

public class RandomShuffleStrategy implements IShuffleStrategy {
    public function execute(cards:Vector.<AbstractCard>):void {
        for(var i:int; i < cards.length; i++) {
            var removedCards:Vector.<AbstractCard> = cards.splice((int)(Math.random() % cards.length), 1);
            cards.push(removedCards[0]);
        }
    }
}
}
