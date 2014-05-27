package ;

import flash.display.Sprite;
import flash.geom.Rectangle;

class CompCar extends Sprite {

private static inline var MAX_SPEED:Int = 450;
private static inline var MIN_SPEED:Int = 300;
private static inline var SPEED_INCREASE:Int = 5;
private static inline var LANE_CHANGE_SPEED:Int = 100;
private static inline var AFTER_LANE_CHANGE_SPEED:Int = 300;

private static inline var CAR_WIDTH:Int = 20;
private static inline var CAR_LENGTH:Int = 35;

private var maxSpeed:Int = MAX_SPEED;
private var minSpeed:Int = MIN_SPEED;

private var _lane:Int;
private var ySpeed:Int;
private var xSpeed:Int;
private var _bounds:Rectangle = null;
private var _bottomBounds:Rectangle = null;
private var classicMode:Bool = false;

public function new( classicMode:Bool = true )
{
	this.classicMode = classicMode;
	
	if( classicMode ){
	this.graphics.beginFill( 0xFFFFFF ); 
	this.graphics.drawRect( x, y, CAR_WIDTH, CAR_LENGTH );
	this.graphics.endFill();
	}
	else {
	this.graphics.beginFill( 0x00FF00 ); 
	this.graphics.drawRect( x, y, CAR_WIDTH, CAR_LENGTH );
	this.graphics.endFill();
	}
	
	_bounds = new Rectangle( 0, 0, width, height );
	
	if( classicMode )
	{
	_bottomBounds = new Rectangle();
	_bottomBounds.height = height * .25;
	_bottomBounds.width = width;
	}
	else
	{
	_bottomBounds = new Rectangle();
	_bottomBounds.height = height * 4;
	_bottomBounds.width = width;
	}
	
	enable();
	cacheAsBitmap = true;
	spawn();		
}

public function enable():Void
{
	this.visible = true;
}

public function disable():Void
{
	this.visible = false;
	this.x = -50;
	this.y = -50;
}

public function step( dt:Float ):Void {
	y += ySpeed * dt;
	if( y > Global.APPHEIGHT || y < -600 )
	spawn();
	//if ( y < -300 && !classicMode )
	//spawn( false );
	if( !classicMode && xSpeed != 0 )	{
	x += xSpeed * dt;
	ySpeed -= 5;
	if( xSpeed > 0 ){
		//Lane change right
		if( x > ( _lane + 1 ) * Global.LANE_WIDTH + Global.MARGIN ) {
		_lane++;
		setLane( _lane );
		xSpeed = 0;
		ySpeed -= AFTER_LANE_CHANGE_SPEED;
		}
	}
	else {
		// Lane change left
		if( x < ( _lane - 1 ) * Global.LANE_WIDTH + Global.MARGIN ) {
		_lane--;
		setLane( _lane );
		xSpeed = 0;
		ySpeed -= AFTER_LANE_CHANGE_SPEED;
		}
	}
	}
}

public function spawn( top:Bool = true ):Void {
	setLane( Math.floor( Math.random() * Global.NUMLANES) );
	if( top )
	y =  -Math.floor( Math.random() * 300) - 300;
	if( !top )
	y = Math.floor( Math.random() * 300) + Global.GAME_HEIGHT;
	ySpeed = Math.floor( ( Math.random() * ( maxSpeed - minSpeed ) ) + minSpeed );
	xSpeed = 0;
	
	if( !classicMode ) {
	this.graphics.beginFill( 0x00FF00 ); 
	this.graphics.drawRect( 0, 0, CAR_WIDTH, CAR_LENGTH );
	this.graphics.endFill();
	}
	
}

public function increaseSpeed():Void {
	minSpeed += SPEED_INCREASE;
	maxSpeed += SPEED_INCREASE;
}

// Attempt make a lane change if the lane is open
// returns false if a lane change isn't possible
public function changeLane( lanesOccupied:Int ):Bool {
	// Only change the xSpeed if the car isn't already
	// changing lanes
	if( xSpeed == 0 ) {
	// Lane change right 50% of the time, but not if the car is in the farthest right lane
	if( lanesOccupied == Global.BOTH_LANES_OCCUPIED )
		return false;
	if( _lane == 0 && lanesOccupied != Global.RIGHT_LANE_OCCUPIED && Math.floor( Math.random() * 3 ) == 0 )
		xSpeed = LANE_CHANGE_SPEED;
	else if( _lane != Global.NUMLANES - 1 && Math.floor( Math.random() * 3 ) == 0 && lanesOccupied != Global.RIGHT_LANE_OCCUPIED)  {
		xSpeed = LANE_CHANGE_SPEED;
	}
	else if( lanesOccupied != Global.LEFT_LANE_OCCUPIED && lane != 0 && Math.floor( Math.random() * 3 ) == 0 ) {
		xSpeed = -LANE_CHANGE_SPEED;
	}
	else
		return false;
	this.graphics.beginFill( 0xFF0000 ); 
	this.graphics.drawRect( 0, 0, CAR_WIDTH, CAR_LENGTH );
	this.graphics.endFill();
	return true;
	}
	return false;
}

public function cancelLaneChange():Void {
	if( xSpeed > 0 )
	{
	setLane( _lane );
	}
	else if( xSpeed < 0 )
	{
	setLane( _lane );
	}
	
}

public var lane(getLane, setLane):Int;
 	private function getLane():Int {
	return _lane;
}

override public var y(null, setY):Float;
 	private function setY( value:Float ):Void {
	super.y = value;
	_bounds.y = y;
	_bottomBounds.y = y;
}

override public var x(null, setX):Float;
 	private function setX( value:Float ):Void {
	super.x = value;
	_bounds.x = x;
	_bottomBounds.x = x;
}

private function setSpeed( value:Int ):Void {
	ySpeed = value;
}

public var speed(getSpeed, setSpeed):Int;
 	private function getSpeed():Int {
	return ySpeed;
}

public function setLane( lan:Int ):Void {
	if(lan > 0 && lan < Global.NUMLANES )
	{
	_lane = lan;
	x = ( ( _lane * Global.LANE_WIDTH ) + Global.MARGIN + ( ( Global.LANE_WIDTH - width ) / 2 ) );
	}
}

public var bottomBounds(getBottomBounds, setBottomBounds):Rectangle;
 	private function getBottomBounds():Rectangle {
	return _bottomBounds;
}

public var bounds(getBounds, setBounds):Rectangle;
 	private function getBounds():Rectangle {
	return _bounds;
}
}