/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.deck.shuffle {
import com.rc.framework.cards.AbstractCard;

public interface IShuffleStrategy {
    function execute(cards:Vector.<AbstractCard>):void;
}
}
