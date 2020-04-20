package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class Flower extends Interactable
{
    public var thirstiness:Float = 1.5;
    public function new(x:Float, y:Float) {
        super(x, y);

        objType = 'flower';

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.flowerSpritesheet__png, AssetPaths.flowerSpritesheet__xml);
        frames = tex;

        animation.addByPrefix('idle', 'flower idle', 24);
        animation.addByPrefix('thirsty', 'Symbol 1', 24);
        animation.play('idle');
        antialiasing = true;

        setGraphicSize(Std.int(width * 0.7));
        updateHitbox();
    }

    override function interactWithObject(teehee:DaObject) {
        super.interactWithObject(teehee);

        switch(teehee.objType)
        {
            case 'water':
                if (teehee.isFull)
                {
                    trace('FLOWER GOT WATER??');
                    thirstiness = 1.5;
                    teehee.isFull = false;
                }
            default:
                trace("no interaction for FLOWER and " + teehee);
        }

        trace('log flower');
    }

    var thristyCounter:Int = 0;
    override function update(elapsed:Float) {
        super.update(elapsed);

        FlxG.watch.addQuick('thirsty', thirstiness);

        thristyCounter++;

        if (thristyCounter >= 60 && thirstiness > 0)
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