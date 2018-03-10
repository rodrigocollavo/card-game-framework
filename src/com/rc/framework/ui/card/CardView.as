/**
 * Created by rodrigo on 5/16/15.
 */
package com.rc.framework.ui.card {
import flash.geom.Point;

import starling.display.DisplayObject;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class CardView extends Sprite {
    private var _content:DisplayObject;
    private var _initialMoveLocation:Point;
    private var _trackedTouchId:int = -1;
    private var _moved:Boolean;
    private var _delegate:CardViewDelegate;

    public function CardView(content:DisplayObject) {
        _content = content;
        addChild(_content);
    }

    public function enable():void {
        _content.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    public function disable():void {
        _content.removeEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(event:TouchEvent):void
    {
        if (_trackedTouchId == -1)
        {
            var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
            if (!touch) touch = event.getTouch(this, TouchPhase.MOVED);

            if (touch && touchesBegan(touch, event))
                _trackedTouchId = touch.id;
        }
        else
        {
            touch = event.getTouch(this, null, _trackedTouchId);
            if (touch)
            {
                if (touch.phase == TouchPhase.MOVED)
                {
                    touchesMoved(touch, event);
                }
                else if (touch.phase == TouchPhase.ENDED)
                {
                    _trackedTouchId = -1;
                    touchesEnded(touch, event);
                }
            }
        }
    }

    private function touchesBegan(touch:Touch, event:TouchEvent):Boolean
    {
        _moved = false;
        _initialMoveLocation = touch.getLocation(this);
        if(_delegate)
            _delegate.onCardTouchBegan(this, new Point(touch.globalX, touch.globalY));
        return true;
    }

    private function touchesMoved(touch:Touch, event:TouchEvent):void
    {
        _moved = true;
        var pt:Point = touch.getLocation(this);
        _content.x = pt.x - _initialMoveLocation.x;
        _content.y = pt.y - _initialMoveLocation.y;
        if(_delegate)
            _delegate.onCardTouchMoved(this, new Point(touch.globalX, touch.globalY));
        trace("touches moved ", pt.x, pt.y, pt.x - _initialMoveLocation.x, pt.y - _initialMoveLocation.y);
    }

    private function touchesEnded(touch:Touch, event:TouchEvent):void
    {
        var pt:Point = touch.getLocation(this);
        if(_moved) {
            _moved = false;
//            x += pt.x - _initialMoveLocation.x;
//            y += pt.y - _initialMoveLocation.y;
            _content.x = 0;
            _content.y = 0;
            _initialMoveLocation = null;
        }
        if(_delegate)
            _delegate.onCardTouchEnded(this, new Point(touch.globalX, touch.globalY));
        trace("touched ended");
    }

    public function set delegate(value:CardViewDelegate):void {
        _delegate = value;
    }
}
}
