package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
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

	public static var lightness:Float = 0;
	private var blackShit:FlxSprite;

	private var flat:FlxSprite;

	private var trolly:Trolly;
	
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

		trolly = new Trolly(0, 0);
		grpObjects.add(trolly);

		var flower:Flower = new Flower(1100, 350);
		grpObjects.add(flower);

		mapLoader = new FlxOgmo3Loader(AssetPaths.layout__ogmo, AssetPaths.layoutLevel__json);
		mapLoader.loadEntities(placeEntities, "entities");
		

		FlxG.camera.follow(camFollow);

		FlxG.mouse.load("assets/images/cursor_idle.png");

		blackShit = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackShit.scrollFactor.set();
		add(blackShit);
		blackShit.active = false;

		add(flat);

		FlxG.worldBounds.set(0, 0, bg.width, bg.height);

		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		var daName = entity.name;
		trace(daName);
		switch (daName)
		{
			case 'spoon':
				var spoon:Spoon = new Spoon(entity.x, entity.y);
				grpObjects.add(spoon);
				spoon.objType = daName;
			case 'soup':
				var soup:Soup = new Soup(entity.x, entity.y);
				grpObjects.add(soup);
				soup.objType = daName;
			case "troll":
				trolly.setPosition(entity.x, entity.y);
			case 'faucet':
				var faucet:Faucet = new Faucet(entity.x, entity.y);
				grpObjects.add(faucet);
			case 'flatline':
				var tex = FlxAtlasFrames.fromSparrow(AssetPaths.flatline__png, AssetPaths.flatline__xml);

				flat = new FlxSprite(entity.x, entity.y);
				flat.frames = tex;
				flat.animation.addByPrefix('flat', 'flatline', 24);
				flat.animation.play('flat');
				
			case "water":
				FlxG.log.add('water');
				var water:Water = new Water(entity.x, entity.y);
				grpObjects.add(water);
			case 'patient':
				var patient:Patient = new Patient(entity.x, entity.y);
				grpObjects.add(patient);
			case 'lightswitch':
				var light:Lightswitch = new Lightswitch(entity.x, entity.y);
				grpObjects.add(light);
			default:
				trace('lol');
		}
	}

	private var justInteracted:Bool = false;
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		blackShit.alpha = PlayState.lightness;


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

							FlxG.log.add('interacted?');
						}
						
					});
				}
			});
		}
		
		grpObjects.forEach(function(obj:DaObject)
		{
			grpObjects.forEach(function(obj2:DaObject)
				{
					if (FlxG.overlap(obj, obj2))
					{
						if (obj.objType == 'soup' && obj2.objType == 'spoon' && !obj2.isFull)
						{
							obj2.isFull = true;
						}

						if (obj.objType == 'water' && obj2.objType == DaObject.FAUCET && obj2.isOn)
						{
							obj.isFull = true;
						}

						if (obj2.objType == 'trolly')
						{
							FlxG.watch.addQuick('troll', obj2.getPosition());

							if (!obj.mousePressing && obj.followsTrolly)
								obj.x = obj2.x - obj.trollyOffset.x;
							if (obj.mousePressing)
							{
								obj.trollyOffset.set(obj2.x - obj.x, obj2.x - obj.x);
							}
						}
					}
				});

			if (obj.objType == 'trolly')
			{
				if (obj.x > 1666)
					obj.x = 1666;
				if (obj.x < 450)
					obj.x = 450;
			}

			if (obj.mousePressing)
			{
				if (obj.objType == 'trolly')
				{
					// blah lmao
				}
				else
				{
					grpObjects.members.remove(obj);
					grpObjects.members.push(obj);
				}
				
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
