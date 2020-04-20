package;

class Soup extends Draggable
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic(AssetPaths.soup__png);
    }
}