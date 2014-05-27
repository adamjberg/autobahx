package ;

import flash.events.MouseEvent;
import flash.display.*;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.ui.Keyboard;
import flash.utils.Timer;
 
 
import flash.Error;

class Game extends Sprite {

private static inline var NUM_START_CARS:Int = 5;
private static inline var MAX_NUM_CARS:Int = 20;
private static inline var TIME_BETW_ADD_CARS:Int = 2000;
private static inline var SLOW_DOWN_SPEED:Int = 10;
private static inline var FPS:Int = 60;
public static inline var SPACE_BETW_CARS:Int = 10;
public static inline var BORDER:Int = 4;
 
private static var instance:Game = null;
//private static var foreground:Foreground = null;
private var player:PlayerCar;
private var compCars:Array;
private var timeSurvived:Float = 0;
private var addCarTimer:Timer;
private var infoBar:InfoBar;
private var background:Sprite;
private var border:Sprite;
private var logo:Sprite;
private var upgradeMenu:UpgradeMenu;
private var pauseScreen:PauseScreen;
private var startGameButton:Button;
private var gameCompleteScreen:GameCompleteScreen;
private var instructions:Instructions;
private var numCars:Int = 0;
private var frameCount:Int = 0;

private var isPaused:Bool = false;
private var isGameOver:Bool = true;
private var classicMode:Bool = false;

private var musicChannel : SoundChannel;
private var bgMusic : Sound;
 
public function new() {
if(instance != null)
	throw new Error("Only one Singleton instance should be initiated");

startMenu();
}

public function startMenu():Void {
logo = new Logo();
addChild( logo );

border = new Sprite;
border.graphics.beginFill( 0x000080 );
border.graphics.drawRect( Global.APPWIDTH / 2 - BORDER, 0, Global.GAME_WIDTH + BORDER * 2, Global.APPHEIGHT );
border.graphics.endFill();
addChild( border );

background = new Sprite();
background.graphics.beginFill( 0 );
background.graphics.drawRect( Global.APPWIDTH / 2, BORDER, Global.GAME_WIDTH - BORDER, Global.APPHEIGHT - BORDER * 2 );
background.graphics.endFill();
addChild( background );

// Create the player
player = new PlayerCar();
player.visible = false;
addChild( player );

compCars = new Array();

for( var i:Int = 0; i < MAX_NUM_CARS; i++ ) {
	compCars[ i ] = new CompCar( classicMode );
	addChild( compCars[ i ] );
}

numCars = NUM_START_CARS;

instructions = new Instructions();
addChild( instructions );

infoBar = new InfoBar( player );
infoBar.visible = false;
addChild( infoBar );

addCarTimer = new Timer( TIME_BETW_ADD_CARS );

pauseScreen = new PauseScreen();
pauseScreen.x = Global.MARGIN / 2;

startGameButton = new Button( 'CLASSIC' );
startGameButton.x = Global.GAME_WIDTH / 2 - startGameButton.width / 2;
startGameButton.y = instructions.y + instructions.height + 100; 
addChild( startGameButton );
startGameButton.addEventListener( MouseEvent.MOUSE_UP, start, false, 0, true );
upgrade();
}

public function upgrade():Void
{
upgradeMenu = new UpgradeMenu( player );
addChild( upgradeMenu );
}

public function resetGame():Void {	
}
 
public static function getInstance():Game {
if (instance == null)
	instance = new Game();
 
return instance;
}

public function playMusic():Void
{
musicChannel = bgMusic.play();
musicChannel.addEventListener( Event.SOUND_COMPLETE, loopMusic, false, 0, true );
}

public function loopMusic( e:Event ):Void
{
if (musicChannel != null) {
musicChannel.removeEventListener( Event.SOUND_COMPLETE, loopMusic );
playMusic();
}
}
 	
public function tracer( event:MouseEvent ):Void 
{
trace( 'x: ' + event.target.x + ' y: ' + event.target.y );
infoBar.setText( 'x: ' + event.target.x + ' y: ' + event.target.y );
}

// Initialize instance variables for game
public function start( event:Event = null ) : Void { 	
infoBar.visible = true;
player.visible = true;
player.reset();

if( gameCompleteScreen && isGameOver ) {
	removeChild( gameCompleteScreen );
}

if( pauseScreen && isPaused ) {
	removeChild( pauseScreen );
	isPaused = false;
}

isGameOver = false;

for( var i:Int = 0; i < MAX_NUM_CARS; i++ ) {
	var compCar:CompCar = compCars[ i ];
	compCar.addEventListener( MouseEvent.CLICK, tracer );
	if( i < NUM_START_CARS )
	{
	compCar.spawn();
	compCar.enable();
	numCars = i;
	}
	else
	compCar.disable();
}

addCarTimer.start();
addCarTimer.addEventListener( TimerEvent.TIMER, addCar, false, 0, true );

timeSurvived = 0;

addEventListener( GameControlEvent.GAME_OVER, gameOver, false, 0, true );
addEventListener( GameControlEvent.TOGGLE_PAUSE, togglePause, false, 0, true );
}

// update functions that need to be updated
public function update():Void
{
if( !isPaused && !isGameOver)
{
	if( player.gas > 0 )
	player.gas--;
	else
	dispatchEvent( new GameControlEvent( GameControlEvent.GAME_OVER, {} ) );
	infoBar.update();
}
}

// Handle game logic and update display
public function step( deltaTime:Float = 1 ) : Void 
{
frameCount++;
if( frameCount % 10 == 0 )
{
	frameCount = 0;
	update();
}
if( isPaused || isGameOver )
	return;
timeSurvived += 1 / FPS;
if( player.gas > 0 )
	player.step( deltaTime );
	
//move computer player and then check for collisions.
for( var i:Int = 0; i < numCars; i++ ) 
{
	var Car1:CompCar = compCars[ i ];
	Car1.step( deltaTime );
	if( !isPaused && !isGameOver ) {
	if( player.hitTestObject( Car1 ) )
	{
		player.loseLife();
		//isCrash = true;
		//crashCoordinates.add( new Point ( compCars.get(i).getX() - compCars.get(i).getWidth(), compCars.get(i).getY() ) );
		if( player.lives <= 0 )
		{
		dispatchEvent( new GameControlEvent( GameControlEvent.GAME_OVER, {} ) );
		}
		Car1.spawn();
	}
	}
	for( var j:Int = 0; j < numCars ; j++ ) 
	{
	var Car2:CompCar = compCars[ j ];
	if( i != j )
	{
		if( Car1.hitTestObject( Car2 ) )
		Car1.spawn();
		
		if( Car1.bottomBounds.intersects( Car2.bounds ) )
		{
		if( classicMode )
			Car1.spawn();
		else 
		 {
			// If a lane change is not possible the car needs to slow down
			if( Car2.y <= Car1.y + Car1.height + SPACE_BETW_CARS ) {
				Car2.speed = Car1.speed;
			}
			else if( Car2.speed < Car1.speed )
				Car2.speed += SLOW_DOWN_SPEED;
		 }
		}
	}
	}
}
}

public function checkOpenLanes( currentCar:CompCar ):Int {
var leftLaneOccupied:Bool = false;
var rightLaneOccupied:Bool = false;

for( var i:Int = 0; i < compCars.length; i++ ){
	var compCar:CompCar = compCars[ i ];
	if( compCar.lane == currentCar.lane + 1 )
	rightLaneOccupied = true;
	if( compCar.lane == currentCar.lane - 1 )
	leftLaneOccupied = true;
}
if( leftLaneOccupied && rightLaneOccupied )
	return Global.BOTH_LANES_OCCUPIED;
else if( leftLaneOccupied )
	return Global.LEFT_LANE_OCCUPIED;
else if( rightLaneOccupied )
	return Global.RIGHT_LANE_OCCUPIED;
return Global.NO_LANES_OCCUPIED;
}

public function addCar( event:TimerEvent):Void {
if( numCars < MAX_NUM_CARS )
{
	compCars[ numCars ].enable();
	numCars++;
}
else {
	for( var i:Int = 0; i < compCars.length; i++ )
	{
	var compCar:CompCar = compCars[ i ];
	compCar.increaseSpeed();
	}
}

if( numCars == MAX_NUM_CARS - 15 ) {
	addCarTimer.delay = 3000;
}
else if( numCars == MAX_NUM_CARS - 10 ) {
	addCarTimer.delay = 3500;
}
else if( numCars == MAX_NUM_CARS - 5 ) {
	addCarTimer.delay = 4000;
}
else if( numCars == MAX_NUM_CARS ) {
	addCarTimer.delay = 5000;
}
}

public function togglePause( event:GameControlEvent ):Void {
isPaused = !isPaused;
if( isPaused ) {
	addChild( pauseScreen );
	addCarTimer.stop();
}
else {
	if( pauseScreen )
	removeChild( pauseScreen );
	addCarTimer.start();
}
}

public function gameOver( event:GameControlEvent ):Void {
addCarTimer.stop();
addCarTimer.removeEventListener( TimerEvent.TIMER, addCar );
for( var i:Int = 0; i < compCars.length; i++ ) {
	var compCar:CompCar = compCars[ i ];
	compCar.disable();
}
infoBar.visible = false;
player.visible = false;
removeEventListener( GameControlEvent.GAME_OVER, gameOver );
removeEventListener( GameControlEvent.TOGGLE_PAUSE, togglePause );

gameCompleteScreen = new GameCompleteScreen( timeSurvived );
gameCompleteScreen.x = Global.MARGIN / 2;
addChild( gameCompleteScreen );

isGameOver = true;
addEventListener( GameControlEvent.GAME_START, start, false, 0, true );
}
 
// Handle keyboard input
public function keyDown(keyCode : Int) : Void {
if( player )
	player.keyDown( keyCode );
}

public function keyUp( keyCode:Int ):Void{
if( keyCode == Keyboard.SPACE ) {
	dispatchEvent( new GameControlEvent( GameControlEvent.TOGGLE_PAUSE, {} ) ); 
}

if( keyCode == Keyboard.ENTER && isGameOver ) {
	dispatchEvent( new GameControlEvent( GameControlEvent.GAME_START, {} ) );
	removeEventListener( GameControlEvent.GAME_START, start );
}

if( keyCode == Keyboard.Q ) {
	classicMode = false;
}

if( player )
	player.keyUp( keyCode );
}
}