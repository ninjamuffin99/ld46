package;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.graphics.frames.FlxAtlasFrames;

class Water extends Draggable
{
    public var isFull:Bool = true;
    public function new(x:Float, y:Float)
    {
        super(x, y);

        objType = 'water';

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.water__png, AssetPaths.water__xml);
        frames = tex;

        animation.addByPrefix('empty', "empty glass", 24);
        animation.addByPrefix('full', 'full glass', 24);

        animation.play('full');

    }

    override function interactWithObject(teehee:String) {
        super.interactWithObject(teehee);

        switch (teehee)
        {
            case 'flower':
                isFull = false;
            default:
                trace('no interaction between WATER and ' + teehee);
        }

        trace('water?');
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (isFull)
        {
            animation.play('full');
        }
        else
            animation.play('empty');
    }
}