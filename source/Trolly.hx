package;

class Trolly extends Draggable
{
    public function new(x:Float, y:Float) {
        super(x, y);

        loadGraphic(AssetPaths.troll__png);

        objType = 'trolly';

        yLocked = true;
    }
}