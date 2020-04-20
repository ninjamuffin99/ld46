package;

import flixel.graphics.frames.FlxAtlasFrames;

class Faucet extends Interactable
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.faucet__png, AssetPaths.faucet__xml);
        frames = tex;

        animation.addByPrefix('off', 'no water');
        animation.addByPrefix('on', 'water time', 24, false);

        animation.play('off');

        objType = DaObject.FAUCET;

        updateHitbox();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (animation.curAnim.name == 'on')
        {
            if (animation.curAnim.finished)
            {
                animation.play('on', true, false, 2);
            }
        }
    }

    override public function clicked() {
        super.clicked();

        isOn = !isOn;

        if (isOn)
        {
            animation.play('on');
        }
        else
        {
            animation.play('off');
        }
    }
}