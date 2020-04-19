package;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	private var bg:FlxSprite;
	private var camFollow:FlxObject;
	public static var wholeSize:FlxPoint = FlxPoint.get();

	var mapLoader:FlxOgmo3Loader;
	
	override public function create():Void
	{
		bg = new FlxSprite().loadGraphic(AssetPaths.hospital_ward_vector__png);
		bg.setGraphicSize(0, FlxG.height);
		bg.updateHitbox();
		bg.antialiasing = true;
		add(bg);
		
		wholeSize.set(bg.width, bg.height);

		camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);

		var flower:Flower = new Flower(1100, 350);
		add(flower);

		mapLoader = new FlxOgmo3Loader(AssetPaths.layout__ogmo, AssetPaths.layoutLevel__json);
		mapLoader.loadEntities(placeEntities, "entities");
		

		FlxG.camera.follow(camFollow);

		FlxG.mouse.load("assets/images/cursor_idle.png");

		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		var daName = entity.name;
		trace(daName);
		switch (daName)
		{
			case "water":
				FlxG.log.add('water');
				var water:Water = new Water(entity.x, entity.y);
				add(water);
			default:
				trace('lol');
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.watch.addMouse();

		if (FlxG.mouse.justPressed)
			FlxG.mouse.load("assets/images/cursor_grab.png");
		if (FlxG.mouse.justReleased)
			FlxG.mouse.load("assets/images/cursor_idle.png");
			

		var camSpeed:Float = 300;

		if (FlxG.mouse.screenX >= FlxG.width * 0.8 && camFollow.x < bg.width - (FlxG.width * 0.5))
		{
			camFollow.velocity.x = camSpeed;
		}
		else if (FlxG.mouse.screenX <= FlxG.width * 0.2 && camFollow.x > FlxG.width * 0.5)
		{
			camFollow.velocity.x = -camSpeed;
		}
		else
			camFollow.velocity.x = 0;
	}
}
