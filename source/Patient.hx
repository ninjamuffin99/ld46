package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Patient extends Interactable
{

    private var isDead:Bool = false;
    public var thirstiness:Float = 1.1;
    public var hungry:Float = 1;
    public function new(x:Float, y:Float)
    {
        super(x, y);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.patient__png, AssetPaths.patient__xml);
        frames = tex;

        animation.addByPrefix('idle', 'idle', 24);
        animation.addByPrefix('dying', 'dying', 24);
        animation.addByPrefix('dead', 'dead', 24);

        animation.play('idle');
    }

    var thristCounter:Int = 0;
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (thirstiness >= 5 || hungry <= 0)
        {
            isDead = true;
        }

        thristCounter++;

        if (thristCounter >= 60 && thirstiness > 0)
        {
            thristCounter = 0;
            thirstiness -= 0.05;
            hungry -= 0.08;
        }
        if (isDead)
        {
            animation.play('dead');
        }
        else
        {
            if (thirstiness >= 0.9)
            {
                animation.play('idle');
            }
            else if (thirstiness >= 0.4)
            {
                animation.play('dying');
            }
        }
        
    }

    override function interactWithObject(daOtherObject:DaObject) {
        super.interactWithObject(daOtherObject);

        switch (daOtherObject.objType)
        {
            case 'water':
                daOtherObject.isFull = false;
                thirstiness += 1;
            case 'spoon':
                if (daOtherObject.isFull)
                {
                    hungry += 0.7;
                    daOtherObject.isFull = false;
                }
        }
    }
}