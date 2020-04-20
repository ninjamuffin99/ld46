package;

import flixel.FlxG;
import flixel.FlxSprite;

class DaObject extends FlxSprite
{
    public var isGrabbed:Bool = false;
    public var objType:String = 'nothin';
    public function new(x:Float, y:Float)
    {
        super(x, y);
    }

    public function interactWithObject(daOtherObject:DaObject):Void
    {
    }
}