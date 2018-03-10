/**
 * Created by rodrigo on 5/16/15.
 */
package com.rc.framework.ui.card {
import flash.geom.Point;

public interface CardViewDelegate {
    function onCardTouchBegan(card:CardView, point:Point):void;
    function onCardTouchMoved(card:CardView, point:Point):void;
    function onCardTouchEnded(card:CardView, point:Point):void;
}
}
