/**
 * Created by Rodrigo Collavo on 2/24/15.
 */
package com.rc.framework.view.states {
import com.rc.framework.GameInstance;

import starling.events.EventDispatcher;
import starling.utils.AssetManager;

public class AbstractStateView extends EventDispatcher {
    protected var _assetManager:AssetManager;

    public function setup():void {
        if (!_assetManager)
            _assetManager = GameInstance.instance.assetManager;
    }
}
}
