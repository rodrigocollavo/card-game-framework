/**
 * Created by Rodrigo Collavo on 2/3/15.
 */
package com.rc.framework {
import com.rc.common.ui.LayoutTools;

import starling.utils.AssetManager;

public class GameInstance {
    private static var _instance:GameInstance;
    private var _assetManager:AssetManager;
    private var _layoutTools:LayoutTools;
    private var _board:AbstractBoard;

    public static function get instance():GameInstance {
        if(_instance == null)
            _instance = new GameInstance();

        return _instance;
    }

    public function get assetManager():AssetManager {
        return _assetManager;
    }

    public function set assetManager(value:AssetManager):void {
        _assetManager = value;
    }

    public function get board():AbstractBoard {
        return _board;
    }

    public function set board(value:AbstractBoard):void {
        _board = value;
    }

    public function get layoutTools():com.rc.common.ui.LayoutTools {
        return _layoutTools;
    }

    public function set layoutTools(value:LayoutTools):void {
        _layoutTools = value;
    }
}
}
