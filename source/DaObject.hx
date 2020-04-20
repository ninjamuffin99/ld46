package;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;

class DaObject extends FlxSprite
{
    public var isGrabbed:Bool = false;
    public var objType:String = 'nothin';
    public var isFull:Bool = true;
    public var isOn:Bool = false;
    public var mousePressing:Bool = false;
    public var followsTrolly:Bool = false;

    public var trollyOffset:FlxPoint = FlxPoint.get();

    public static inline var FAUCET:String = 'faucet';
    public function new(x:Float, y:Float)
    {
        super(x, y);
        antialiasing = true;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.mouse.overlaps(this) && FlxG.mouse.justPressed)
        {
            clicked();
        }
    }

    public function interactWithObject(daOtherObject:DaObject):Void
    {
    }

    public function clicked() {
        
    }
}