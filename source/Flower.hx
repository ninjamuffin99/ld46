package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class Flower extends FlxSprite
{
    public function new(x:Float, y:Float) {
        super(x, y);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.flowerSpritesheet__png, AssetPaths.flowerSpritesheet__xml);
        frames = tex;

        animation.addByPrefix('idle', 'flower idle', 24);
        animation.play('idle');
        antialiasing = true;

        setGraphicSize(Std.int(width * 0.3));
        updateHitbox();
    }
}