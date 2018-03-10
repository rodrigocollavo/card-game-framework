/**
 * Created by Rodrigo Collavo on 3/22/15.
 */
package com.rc.common.ui {
import starling.core.Starling;
import starling.display.Button;
import starling.display.DisplayObjectContainer;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.utils.AssetManager;
import starling.utils.formatString;

public class LayoutTools {
    public const BUTTON:String = "BT";
    public static const STRETCH_NONE:int = 0;
    public static const STRETCH_VIEW_ALL:int = 1;
    public static const STRETCH_FILL_ALL:int = 2;
    private var _assetManager:AssetManager;
    private var _layoutXMLs:AbstractLayouts;

    public function LayoutTools(am:AssetManager, layoutXMLs:AbstractLayouts) {
        _assetManager = am;
        _layoutXMLs = layoutXMLs;

        if(_assetManager == null)
            throw new Error("AssetManager is null");
    }

    public function loadLayout(layoutName:String, listener:Object, stretchType:int = STRETCH_NONE, parent:Sprite = null):Sprite {
        if (parent == null)
            parent = new Sprite();

        var xml:XML = _layoutXMLs.getXML(layoutName);
        var layoutWidth:Number = parseFloat(xml.attribute("width"));
        var layoutHeight:Number = parseFloat(xml.attribute("height"));

        var scaleFactor:Number = getScaleFactor(layoutWidth, layoutHeight, stretchType);

        for (var i:int = 0; i < xml.children().length(); i++) {
            var child:XML = xml.children()[i];

            var isVisible:Boolean = (child.attribute("visible") != "NO");

            if(isVisible) {
                var x:Number = parseFloat(child.attribute("x"));
                var y:Number = parseFloat(child.attribute("y"));
                var width:Number = parseFloat(child.attribute("width"));
                var height:Number = parseFloat(child.attribute("height"));
                var name:String = child.attribute("name");
                var splitName:Array = name.split(":");

                var newObj:*;
    //            if (splitName[splitName.length - 1].indexOf("anchor") == 0) {
    //                var anchor:Array = [];
    //                anchor = splitName[splitName.length - 1].split("-");
    //                anchor.splice(0, 1);
    //                subObject.anchor = anchor;
    //            }

                if (splitName.length > 1) {
                    if (splitName[0] == BUTTON) {
                        newObj = createButton(splitName[2], splitName[1], listener);
                    }
    //                else if (splitName[0] == Layout.SCALE_BUTTON) {
    //                    subObject.type = Layout.SCALE_BUTTON;
    //                    subObject.data = splitName[1];
    //                    subObject.name = splitName[2];
    //                }
    //                else if (splitName[0] == Layout.CLASS) {
    //                    subObject.type = Layout.CLASS;
    //                    subObject.name = splitName[1];
    //                }
    //                else if (splitName[0] == Layout.TEXT) {
    //                    subObject.type = Layout.TEXT;
    //                    subObject.name = splitName[1];
    //                }
    //                else {
    //                    subObject.type = Layout.IMAGE;
    //                    subObject.name = splitName[0];
    //                }
                }
                else {
                    var img:Image = new Image(_assetManager.getTexture(splitName[0]));
                    img.touchable = false;
                    newObj = img;
                }

                if(newObj == null)
                    throw new Error(formatString("Can't create object '%s' for layout '%s'", name, layoutName));
                newObj.x = layoutWidth * scaleFactor * x;
                newObj.y = layoutHeight * scaleFactor * y;
                if(newObj.width != width || newObj.height != height)
                    trace("Warning: image doesn't fit layout specifications");
                parent.addChild(newObj);
            }
        }

        return parent;
    }

    public function createButton(name:String, methodName:String, listener:Object):Button {
        var texture:Texture = _assetManager.getTexture(name);
        var button:Button = new Button(texture, "");
        button.touchable = true;

        var f:Function = listener[methodName] as Function;
        button.addEventListener(Event.TRIGGERED, f);

        return button;
    }

    private function getScaleFactor(layoutW:Number, layoutH:Number, stretchType:int):Number {
        var scaleFactor:Number = 1.0;
        var width:Number = Starling.current.stage.stageWidth;
        var height:Number = Starling.current.stage.stageHeight;

        var fX:Number = width / layoutW;
        var fY:Number = height / layoutH;
        switch (stretchType) {
            case STRETCH_FILL_ALL:
                break;
            case STRETCH_VIEW_ALL:
                    scaleFactor = Math.min(fX, fY);
                break;
        }

        return scaleFactor;
    }
}
}
