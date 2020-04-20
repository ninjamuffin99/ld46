package;

import flixel.FlxG;

class Clickable extends DaObject
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.mouse.overlaps(this) && FlxG.mouse.justPressed)
        {
            clicked();
        }
    }

    
}