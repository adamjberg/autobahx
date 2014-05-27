package ;

import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.system.System;
import flash.text.TextField;
import flash.utils.getTimer;
/**
 * @author Adam
 */
[SWF(width="600", height="550", frameRate="60", backgroundColor="#FFFFFF")]
class Main extends Sprite {
  
  	//private var ui:UIComponent = new UIComponent();
 	private var game:Game;
private var deltaTime:Float;
private var lastTime:Float;
private var isGameOver:Bool = false;
private var lastMem:Float = 0;
private var diff:Float;
private var textField:TextField;

 public function new() : Void {
game = Game.getInstance();
//addChild(ui);
addChild(game);
textField = new TextField();
addChild( textField );
startGame();
 }
 
public function keyDown( event:KeyboardEvent ):Void {
game.keyDown( event.keyCode );
}

public function keyUp( event:KeyboardEvent ):Void{
game.keyUp( event.keyCode );
}

public function newGame():Void {
deltaTime = 0.0;
lastTime = getTimer();
}
 
public function startGame( ):Void {
stage.scaleMode = StageScaleMode.SHOW_ALL;

stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown, false, 0, true );
stage.addEventListener( KeyboardEvent.KEY_UP, keyUp, false, 0, true );

stage.addEventListener(Event.ENTER_FRAME, gameLoop, false, 0, true );
deltaTime = 0.0;
lastTime = getTimer();

game.dispatchEvent( new GameControlEvent( GameControlEvent.GAME_START, {} ) );
}

/*
 * Calculate the amount of time that has passed since
 * the last frame and step the game by that much time.
 */
public function gameLoop(event : Event) : Void {
deltaTime = getTimer() - lastTime;
lastTime += deltaTime;
game.step( deltaTime / 1000.0 );
diff = System.totalMemory - lastMem;
lastMem = System.totalMemory;
var i:Int = getTimer();
textField.text = deltaTime.toString();
//trace( 'total: ' + System.totalMemory + ' diff ' + diff  );
}

/*
 * End the game
 */
public function gameOver(event : Event) : Void {

isGameOver = true;
 
// Remove the game screen, and its listeners
//removeEventListener(CustomEvent.GAME_OVER, gameOver);
 
//ui.removeChild( game );
 
}
}