/**
 * Created by rodrigo on 5/15/15.
 */
package com.rc.framework.playarea {
import com.rc.framework.*;
import com.rc.framework.deck.AbstractDeck;

public class PlayAreaFactory {
    private static const PLAYAREA_QUEUE:String = "playarea_queue";
    private static const PLAYAREA_FIXED_POSITIONS:String = "playarea_fixed_positions";
    public static function build(type:String, name:String, deck:AbstractDeck, extraData:Object):PlayArea {
        var playArea:PlayArea;

        switch(type) {
            case PLAYAREA_QUEUE:
                playArea = new PlayAreaQueue();
                break;
            case PLAYAREA_FIXED_POSITIONS:
                playArea = new PlayAreaFixed(extraData.maxCards);
                break;
            default:
                throw new Error("Can't recognize playarea with type " + type);
        }

        playArea.name = name;
        playArea.deckRef = deck;
        return playArea;
    }
}
}
