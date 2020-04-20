package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class TitleState extends FlxState
{
    override function create() {
        var bg:FlxSprite = new FlxSprite();
        bg.loadGraphic(AssetPaths.titleScreen__png);
        bg.setGraphicSize(FlxG.width);
        bg.updateHitbox();
        add(bg);

        var icokw:FlxSprite = new FlxSprite();
        icokw.loadGraphic(AssetPaths.ico_kw__png);
        add(icokw);

        var titleTex = FlxAtlasFrames.fromSparrow(AssetPaths.hospice_title__png, AssetPaths.hospice_title__xml);
        var p1:FlxSprite = new FlxSprite();
        p1.frames = titleTex;
        p1.animation.addByPrefix('idle', 'menu_title', 24);
        p1.animation.play('idle');
        add(p1);

        p1.screenCenter();
        p1.setGraphicSize(Std.int(p1.width * 1.4));
        p1.updateHitbox();
        p1.y -= 100;

        var press1Tex = FlxAtlasFrames.fromSparrow(AssetPaths.press1__png, AssetPaths.press1__xml);
        var press1:FlxSprite = new FlxSprite();
        press1.frames = press1Tex;
        press1.animation.addByPrefix('idle', 'ui_press1', 24);
        press1.animation.play('idle');
        add(press1);
        press1.screenCenter();
        press1.y += 100;
        
        super.create();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ONE || FlxG.keys.justPressed.NUMPADONE)
            FlxG.switchState(new PlayState());
    }
}