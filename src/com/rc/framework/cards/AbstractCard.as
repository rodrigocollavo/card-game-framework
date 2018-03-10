/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework.cards {
import starling.errors.AbstractClassError;

public class AbstractCard {
    protected var _properties:Object;
    protected var _name:String;
    protected var _image:String;

    public function getType():uint {
        throw new AbstractClassError();
    }

    public function create(data:Object):void {
        _properties = data.properties;
        _name = data.name;
        _image = data.image;
    }
    public function getName():String {
        return _name;
    }

    public function getProperties():Object {
        return _properties
    }

    public function getImage():String {
        return _image;
    }
}
}
