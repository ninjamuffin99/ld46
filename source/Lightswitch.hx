package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Lightswitch extends Interactable
{
    public function new(x:Float, y:Float) {
        super(x, y);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.lightswitch__png, AssetPaths.lightswitch__xml);
        frames = tex;

        animation.addByPrefix('on', 'on');
        animation.addByPrefix('off', 'off');

        animation.play('on');

        objType = 'lightswitch';
    }

    override function clicked() {
        super.clicked();

        isOn = !isOn;

        if (isOn)
        {
            animation.play('on');
            PlayState.lightness = 0;
        }   
        else
        {
            PlayState.lightness = 0.95;
            animation.play('off');
        }
            
    }

}