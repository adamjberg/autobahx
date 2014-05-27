package ;

import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.ui.Keyboard;

class PlayerCar extends FlxSprite {

private var _lives:Int = 10;
public var lives(getLives, setLives):Int;
 	private function getLives():Int {
	return _lives;
}

private var bottomY:Int;
private var ySpeed:Int;
private var xSpeed:Int;

public function new() {
	super();
	this.graphics.beginFill( 0xFFFFFF ); 
	this.graphics.drawRect( 0, 0, 20, 35 );
	this.graphics.endFill();
	super.x = Global.MARGIN + Global.GAME_WIDTH / 2 - width;
	super.y = Global.GAME_HEIGHT - height;
	ySpeed = 300;
	xSpeed = 250;
	_bounds = new Rectangle( x, y, width, height );
}

public function reset():Void
{
	if( _gas == 0 )
	_gas = 300;
	_lives = 10;
	super.x = Global.MARGIN + Global.GAME_WIDTH / 2 - width;
	super.y = Global.GAME_HEIGHT - height;
}

override public function update():Void
{
	if( movingUp ) {
	if( y > 0 ) {
		this.y -= ySpeed * dt;	
	}
	}
	if( movingDown ) {
	if( y + height < Global.GAME_HEIGHT )
		this.y += ySpeed * dt;
	}
	if( movingRight ) {
	if( x < Global.NUMLANES * Global.LANE_WIDTH - width + Global.MARGIN - Game.BORDER )
		this.x += xSpeed * dt;
	}
	if( movingLeft ) {
	if( x > Global.MARGIN )
		this.x -= xSpeed * dt;		
	}
	if( x < Global.MARGIN )
	this.x = Global.MARGIN;
	if( x > Global.NUMLANES * Global.LANE_WIDTH - width + Global.MARGIN - Game.BORDER )
	this.x = Global.MARGIN + Global.GAME_WIDTH - width - Game.BORDER;
}

public function loseLife():Void {
	_lives--;
}

}