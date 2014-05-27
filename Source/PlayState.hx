package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;

/**
* Atari 2600 Breakout
* 
* @author Davey, Photon Storm
* @link http://www.photonstorm.com/archives/1290/video-of-me-coding-breakout-in-flixel-in-20-mins
*/
class PlayState extends FlxState
{
	private static inline var WALL_WIDTH:Int = 10;

	private static inline var BAT_SPEED:Int = 350;

	private var _car:FlxSprite;

	private var _walls:FlxGroup;
	private var _leftWall:FlxSprite;
	private var _rightWall:FlxSprite;
	private var _topWall:FlxSprite;
	private var _bottomWall:FlxSprite;

	override public function create():Void
	{
		FlxG.mouse.visible = false;

		_car = new FlxSprite(180, 220);
		_car.makeGraphic(10, 60, FlxColor.HOT_PINK);

		_walls = new FlxGroup();

		_leftWall = new FlxSprite(0, 0);
		_leftWall.makeGraphic(WALL_WIDTH, FlxG.height, FlxColor.GRAY);
		_leftWall.immovable = true;
		_walls.add(_leftWall);

		_rightWall = new FlxSprite(FlxG.width - WALL_WIDTH, 0);
		_rightWall.makeGraphic(WALL_WIDTH, FlxG.height, FlxColor.GRAY);
		_rightWall.immovable = true;
		_walls.add(_rightWall);

		_topWall = new FlxSprite(0, 0);
		_topWall.makeGraphic(FlxG.width, WALL_WIDTH, FlxColor.GRAY);
		_topWall.immovable = true;
		_walls.add(_topWall);

		_bottomWall = new FlxSprite(0, FlxG.height - WALL_WIDTH);
		_bottomWall.makeGraphic(FlxG.width, WALL_WIDTH, FlxColor.GRAY);
		_bottomWall.immovable = true;
		_walls.add(_bottomWall);

		add(_walls);
		add(_car);
	}

	override public function update():Void
	{
		super.update();

		#if !FLX_NO_TOUCH
		// Simple routine to move bat to x position of touch
		for (touch in FlxG.touches.list)
		{
			if (touch.pressed)
			{
				_car.x = touch.x;
			}
		}
		// Vertical long swipe up or down resets game state
		for (swipe in FlxG.swipes)
		{
			if (swipe.distance > 100)
			{
				if ((swipe.angle < 10 && swipe.angle > -10) || (swipe.angle > 170 || swipe.angle < -170))
				{
					FlxG.resetState();
				}
			}
		}
		#end

		if (FlxG.keys.anyPressed(["LEFT", "A"]) && _car.x > 10)
		{
			_car.velocity.x = - BAT_SPEED;
		}
		else if (FlxG.keys.anyPressed(["RIGHT", "D"]) && _car.x < 270)
		{
			_car.velocity.x = BAT_SPEED;
		} else
		{
			_car.velocity.x = 0;
		}

		if (FlxG.keys.justReleased.R)
		{
			FlxG.resetState();
		}

		FlxG.collide(_car, _walls);
	}
}