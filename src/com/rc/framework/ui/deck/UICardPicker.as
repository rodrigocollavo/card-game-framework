/**
 * Created by Rodrigo Collavo on 1/28/15.
 */
package com.rc.framework.ui.deck {
import com.rc.framework.deck.AbstractDeck;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class UICardPicker extends Sprite {
    public static const EVENT_DRAW:String = "draw";
    public static const SWIPE_X_DISTANCE:int = 10;
    private var _deck:AbstractDeck;
    private var _container:Sprite;
    private var _DeckSp:Image;
    private var _cardSp:Image;
    private var _cardOriginX:int;
    private var _prevCardX:int;
    private var _trackedTouchId:int = -1;

    public function UICardPicker(deck:AbstractDeck, deckImage:Image, cardImage:Image) {
        var stage = Starling.current.stage;
        _deck = deck;
        _DeckSp = deckImage;
        _DeckSp.x = stage.stageWidth/2;
        _DeckSp.y = stage.stageHeight/2;
        _DeckSp.touchable = false;
        _cardSp = cardImage;
        _cardSp.x = stage.stageWidth/2;
        _cardSp.y = stage.stageHeight/2;

        _container = new Sprite();
        _container.addChild(_DeckSp);
        _container.addChild(_cardSp);
        _container.touchable = true;
        _cardOriginX = _cardSp.x;
    }

    public function show() {
        addChild(_container);
        Starling.current.stage.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    public function hide() {
        removeChild(_container);
        Starling.current.removeEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(e:TouchEvent):void {
        if(_trackedTouchId == -1) {
            var touch:Touch = e.getTouch(_cardSp, TouchPhase.BEGAN);
            if (!touch) touch = e.getTouch(_cardSp, TouchPhase.MOVED);
            if (touch && touchBegan(touch, e)) {
                _trackedTouchId = touch.id;
            }
        }
        else {
            touch = e.getTouch(_cardSp, null, _trackedTouchId);
            if (touch) {
                if (touch.phase == TouchPhase.MOVED) {
                    touchMoved(touch, e);
                }
                else if (touch.phase == TouchPhase.ENDED) {
                    _trackedTouchId = -1;
                    touchEnded(touch, e);
                }
            }
        }
    }

    private function touchBegan(touch:Touch, e:TouchEvent):Boolean {
        return touch.getLocation(_cardSp) != null;
    }

    private function touchMoved(touch:Touch, e:TouchEvent):void {
        _prevCardX = _cardSp.x;
        _cardSp.x = Math.max(_cardOriginX, touch.getLocation(_cardSp.parent).x);
    }

    private function touchEnded(touch:Touch, e:TouchEvent):void {
        if(_cardSp.x - _prevCardX > SWIPE_X_DISTANCE || (_cardSp.x + _cardSp.width) > Starling.current.stage.stageWidth) {
            var tween:Tween = new Tween(_cardSp, 0.3, Transitions.EASE_OUT);
            tween.moveTo(Starling.current.stage.stageWidth + _cardSp.width, _cardSp.y);
            tween.onComplete = function onTweenCompleted():void {
                dispatchEventWith(EVENT_DRAW);
            };
            Starling.juggler.add(tween);

        }
        else {
            var tween:Tween = new Tween(_cardSp, 0.3, Transitions.EASE_OUT);
            tween.moveTo(_cardOriginX, _cardSp.y);
            Starling.juggler.add(tween);
        }
    }
}
}
