package;

import flixel.graphics.frames.FlxAtlasFrames;

class Patient extends Interactable
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.patient__png, AssetPaths.patient__xml);
        frames = tex;

        animation.addByPrefix('idle', 'idle', 24);
        animation.addByPrefix('dying', 'dying', 24);

        animation.play('idle');
    }
}