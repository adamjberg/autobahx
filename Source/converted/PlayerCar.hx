package ;

import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
/**
 * @author Adam
 */
class PlayerCar extends Sprite {

private var _lives:Int = 10;
public var lives(getLives, setLives):Int;
 	private function getLives():Int {
	return _lives;
}

private var movingUp:Bool = false;
private var movingDown:Bool = false;
private var movingLeft:Bool = false;
private var movingRight:Bool = false;
private var bottomY:Int;
private var ySpeed:Int;
private var xSpeed:Int;

private var _gas:Int = 0;
private function setGas( value:Int ):Void {
	_gas = value;
}

public var gas(getGas, setGas):Int;
 	private function getGas():Int {
	return _gas;
}

private var _bounds:Rectangle;
public var bounds(getBounds, setBounds):Rectangle;
 	private function getBounds():Rectangle {
	return _bounds;
}

private var _money:Int = 1000;
private function setMoney( value:Int ):Void {
	_money = value;
}
public var money(getMoney, setMoney):Int;
 	private function getMoney():Int {
	return _money;
}

public function new() {
	this.graphics.beginFill( 0xFFFFFF ); 
	this.graphics.drawRect( 0, 0, 20, 35 );
	this.graphics.endFill();
	super.x = Global.MARGIN + Global.GAME_WIDTH / 2 - width;
	super.y = Global.GAME_HEIGHT - height;
	ySpeed = 300;
	xSpeed = 250;
	_bounds = new Rectangle( x, y, width, height );
}

public var color(null, setColor):UInt;
 	private function setColor( color:UInt ):Void{
	this.graphics.beginFill( color ); 
	this.graphics.drawRect( 0, 0, 20, 35 );
	this.graphics.endFill();
}

public function reset():Void
{
	if( _gas == 0 )
	_gas = 300;
	_lives = 10;
	super.x = Global.MARGIN + Global.GAME_WIDTH / 2 - width;
	super.y = Global.GAME_HEIGHT - height;
}

public function step( dt:Float ):Void
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

public function speedAdjust():Float {
	if( y > 0 && y < Global.GAME_HEIGHT / 2 )
	return 2 - ( 3 / Global.GAME_HEIGHT ) * y;
	if( y < Global.GAME_HEIGHT )
	return 1 - ( 3 / Global.GAME_HEIGHT ) * y;
	return 1;
}

public function loseLife():Void {
	_lives--;
}

public function keyDown( keyCode:Int ):Void {
	if( keyCode == Keyboard.RIGHT )
	movingRight = true;
	if( keyCode == Keyboard.LEFT )
	movingLeft = true;
	if( keyCode == Keyboard.UP )
	movingUp = true;
	if( keyCode == Keyboard.DOWN )
	movingDown = true;
}

public function keyUp( keyCode:Int ):Void {
	if( keyCode == Keyboard.RIGHT )
	movingRight = false;
	if( keyCode == Keyboard.LEFT )
	movingLeft = false;
	if( keyCode == Keyboard.UP )
	movingUp = false;
	if( keyCode == Keyboard.DOWN )
	movingDown = false;
}

override public var y(null, setY):Float;
 	private function setY( value:Float ):Void {
	super.y = value;
	bottomY = y + height;
	_bounds.y = y;
}

override public var x(null, setX):Float;
 	private function setX( value:Float ):Void {
	super.x = value;
	_bounds.x = x;
}

}