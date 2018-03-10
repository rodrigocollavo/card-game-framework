/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.ui.panel {
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;

public class RightModularPanel extends ModularPanel {

    public override function create(content:Sprite):void {
        super.create(content);
    }

    protected override function runTweenShow():void {
        _content.x = Starling.current.stage.stageWidth;
        var tween:Tween = new Tween(_content, 0.3, Transitions.LINEAR);
        tween.moveTo(Starling.current.stage.stageWidth -_content.width, 0);
        tween.onComplete = function() {
            dispatchEventWith(EVENT_READY);
        }
        Starling.juggler.add(tween);
    }

    protected override function runTweenHide():void {
        var tween:Tween = new Tween(_content, 0.3, Transitions.LINEAR);
        tween.moveTo(Starling.current.stage.stageWidth -_content.width, 0);
        tween.onComplete = function() {
            dispatchEventWith(EVENT_ENDED);
            onHideAnimationEnded();
        }
        Starling.juggler.add(tween);
    }
}
}
