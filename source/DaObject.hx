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

    public function interactWithObject(daOtherObject:String):Void
    {
        trace('JUST INTERACTED WITH: ' + daOtherObject);

        trace('this did interact!' + FlxG.random.int(0, 10));
    }
}