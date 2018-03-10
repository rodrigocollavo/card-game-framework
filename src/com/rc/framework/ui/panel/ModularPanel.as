/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.ui.panel {
import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.Color;

public class ModularPanel extends Sprite {
    public static const EVENT_READY:String = "ready";
    public static const EVENT_ENDED:String = "ended";
    protected var _blocker:Quad;
    protected var _content:Sprite;
    private var _canDismiss:Boolean;
    private var _disposeOnHide:Boolean;

    public function ModularPanel() {

    }
    public function create(content:Sprite):void {
        createBlocker();
        _content = content;
        //Extend this class to create content
    }

    public function show():void {
        addChild(_blocker);
        addChild(_content);
        runTweenShow();
    }

    public function hide(dispose:Boolean = false):void {
        _disposeOnHide = dispose;
        runTweenHide();
    }

    protected function onHideAnimationEnded():void {
        removeChild(_blocker);
        removeChild(_content);
        if(_disposeOnHide)
            removeFromParent(true);
    }

    protected function runTweenShow():void {
        //Extend this class to create different behaviors
    }

    protected function runTweenHide():void {
        //Extend this class to create different behaviors
    }

    private function createBlocker():void {
        var stage:Stage = Starling.current.stage;
        _blocker = new Quad(stage.stageWidth, stage.stageHeight, Color.argb(0, 0, 0, 0));
        _blocker.touchable = true;
        _blocker.alpha = 0;
        _blocker.addEventListener(TouchEvent.TOUCH, function onBlockerTouched(e:TouchEvent):void {
            if(!_canDismiss)
                return;
            var touch:Touch = e.getTouch(_blocker, TouchPhase.BEGAN);
            if(touch != null)
                hide();
        });
    }

    public function set canDismiss(value:Boolean):void {
        _canDismiss = value;
    }
}
}
