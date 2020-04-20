package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class Flower extends Interactable
{
    public var thirstiness:Float = 1;
    public function new(x:Float, y:Float) {
        super(x, y);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.flowerSpritesheet__png, AssetPaths.flowerSpritesheet__xml);
        frames = tex;

        animation.addByPrefix('idle', 'flower idle', 24);
        animation.addByPrefix('thirsty', 'Symbol 1', 24);
        animation.play('idle');
        antialiasing = true;

        setGraphicSize(Std.int(width * 0.7));
        updateHitbox();
    }

    override function interactWithObject() {
        super.interactWithObject();

        trace('log flower');
    }

    var thristyCounter:Int = 0;
    override function update(elapsed:Float) {
        super.update(elapsed);

        thristyCounter++;

        if (thristyCounter >= 60)
        {
            thristyCounter = 0;
            thirstiness -= 0.05;
        }

        if (thirstiness >= 0.9)
        {
            animation.play('idle');
        }
        else if (thirstiness >= 0.4)
        {
            animation.play('thirsty');
        }
    }
}