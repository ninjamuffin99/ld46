package;

import flixel.graphics.frames.FlxAtlasFrames;

class Spoon extends Draggable
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.soupspoon__png, AssetPaths.soupspoon__xml);
        frames = tex;

        animation.addByPrefix('empty', 'spoon');
        animation.addByPrefix('full', 'full');
        animation.play('empty');
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