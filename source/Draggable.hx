package;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.FlxG;

class Draggable extends DaObject
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        // call this after the update?
        FlxMouseEventManager.add(this, dragShit);
    }

    private var mouseOffset:FlxPoint = FlxPoint.get();
    
    private var pressDown:Bool = false;
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (mousePressing && FlxG.mouse.x >= 0 && FlxG.mouse.x <= PlayState.wholeSize.x && FlxG.mouse.y >= 0 && FlxG.mouse.y <= PlayState.wholeSize.y)
        {
            this.x = FlxG.mouse.x - mouseOffset.x;
            this.y = FlxG.mouse.y - mouseOffset.y;
            isGrabbed = true;
        }
            

        if (FlxG.mouse.justReleased)
        {
            pressDown = false;
            mousePressing = false;
        }

        antialiasing = true;
    }

    override function interactWithObject(teehee:DaObject) {
        super.interactWithObject(teehee);
        isGrabbed = false;
    }

    private function dragShit(_)
    {
        mousePressing = true;
        mouseOffset.set(FlxG.mouse.x - this.x, FlxG.mouse.y - this.y);
    }

    private function onDown(_)
    {
        pressDown = true;
    }
}