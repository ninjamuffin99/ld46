package;

import flixel.FlxG;
import flixel.FlxSprite;

class DaObject extends FlxSprite
{
    public var isGrabbed:Bool = false;
    public function new(x:Float, y:Float)
    {
        super(x, y);
    }

    public function interactWithObject():Void
    {
        trace('this did interact!' + FlxG.random.int(0, 10));
    }
}