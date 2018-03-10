/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.ui.panel {
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;

public class FadeModularPanel extends ModularPanel {

    public override function create(content:Sprite):void {
        super.create(content);
    }

    protected override function runTweenShow():void {
        _content.alpha = 0;
        var tween:Tween = new Tween(_content, 0.3, Transitions.LINEAR);
        tween.fadeTo(1.0);
        tween.onComplete = function() {
            dispatchEventWith(EVENT_READY);
        }
        Starling.juggler.add(tween);
    }

    protected override function runTweenHide():void {
        var tween:Tween = new Tween(_content, 0.3, Transitions.LINEAR);
        tween.fadeTo(0);
        tween.onComplete = function() {
            dispatchEventWith(EVENT_ENDED);
            onHideAnimationEnded();
        }
        Starling.juggler.add(tween);
    }
}
}
