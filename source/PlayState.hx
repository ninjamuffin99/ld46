package;

import flixel.group.FlxGroup.FlxTypedGroup;
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

	private var grpObjects:FlxTypedGroup<DaObject>;
	
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

		grpObjects = new FlxTypedGroup<DaObject>();
		add(grpObjects);

		var flower:Flower = new Flower(1100, 350);
		grpObjects.add(flower);

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
				grpObjects.add(water);
			case 'patient':
				var patient:Patient = new Patient(entity.x, entity.y);
				grpObjects.add(patient);
			default:
				trace('lol');
		}
	}

	private var justInteracted:Bool = false;
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.watch.addMouse();

		justInteracted = false;

		if (FlxG.mouse.justPressed)
			FlxG.mouse.load("assets/images/cursor_grab.png");
		if (FlxG.mouse.justReleased)
		{
			FlxG.mouse.load("assets/images/cursor_idle.png");

			grpObjects.forEach(function(obj:DaObject)
			{
				if (obj.isGrabbed)
				{
					FlxG.overlap(obj, grpObjects, function(obj1, obj2)
					{
						if (!justInteracted)
						{
							obj.interactWithObject(obj2);
							obj2.interactWithObject(obj);
							justInteracted = true;
						}
						
					});
				}
			});
		}
		
		grpObjects.forEach(function(obj:DaObject)
		{
			if (obj.mousePressing)
			{
				grpObjects.members.remove(obj);
				grpObjects.members.push(obj);
			}
		});
			

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
