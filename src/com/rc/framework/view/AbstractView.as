/**
 * Created by Rodrigo Collavo on 2/3/15.
 */
package com.rc.framework.view {
import com.rc.framework.GameInstance;

import flash.filesystem.File;
import flash.geom.Point;

import starling.display.Button;
import starling.display.Sprite;
import starling.errors.AbstractClassError;
import starling.errors.AbstractMethodError;
import starling.utils.AssetManager;

public class AbstractView extends Sprite {
    public static const ANIMATION_HIDE_FADE:int = 1;
    public static const ANIMATION_SLIDE_LEFT:int = 2;
    public static const ANIMATION_SLIDE_RIGHT:int = 3;
    public static const EVENT_LOADING_COMPLETED:String = "loading completed";
    protected var _assetManager:AssetManager;

    public function AbstractView() {
        _assetManager = GameInstance.instance.assetManager;
    }

    public function loadAssets(group:String):void {
        _assetManager.enqueue(File.applicationDirectory.resolvePath(group));
        _assetManager.loadQueue(onProgress);
    }

    private function onProgress(n:Number):void
    {
        if (n == 1)
            dispatchEventWith(EVENT_LOADING_COMPLETED);
    }

    public function build():void {
        throw new AbstractMethodError();
    }

    public function show():void {
        throw new AbstractMethodError();
    }

    public function hide(animation:int, destroy:Boolean) {
    }

    protected function createButton(name:String, position:Point = null) {
        var start:Button = new Button(_assetManager.getTexture(name));
        addChild(start);

        if(position) {
            start.x = position.x;
            start.y = position.y;
        }
    }
}
}
