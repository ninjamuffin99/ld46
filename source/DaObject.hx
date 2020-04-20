package;

import flixel.FlxG;
import flixel.FlxSprite;

class DaObject extends FlxSprite
{
    public var isGrabbed:Bool = false;
    public var objType:String = 'nothin';
    public var isFull:Bool = true;
    public var mousePressing:Bool = false;
    public function new(x:Float, y:Float)
    {
        super(x, y);
        antialiasing = true;
    }

    public function interactWithObject(daOtherObject:DaObject):Void
    {
    }
}