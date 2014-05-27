package ;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
/**
 * @author Adam
 */
class GameCompleteScreen extends Sprite {

public function new( timeSurvived:Float ) {
	var gameOverText:TextField = new TextField;
	var replayText:TextField = new TextField();
	var timeSurvivedText:TextField = new TextField();
	
	gameOverText.text = 'GAME OVER';
	gameOverText.setTextFormat( new TextFormat( Global.DEFAULT_FONT, 20, 0xFFFF00, true ) );
	gameOverText.selectable = false;
	gameOverText.width = Global.APPWIDTH;
	gameOverText.autoSize = 'center';
	gameOverText.y = Global.APPHEIGHT / 2 - 2 * gameOverText.height;
	
	trace( gameOverText.y );
	
	addChild( gameOverText );
	
	/*replayText.text = 'PRESS ENTER TO PLAY AGAIN';
	replayText.setTextFormat( new TextFormat( Global.DEFAULT_FONT, 20, 0xFFFF00, true ) );
	replayText.selectable = false;
	replayText.width = Global.APPWIDTH;
	replayText.autoSize = 'center';
	replayText.y = Global.APPHEIGHT / 2 - replayText.height;
	addChild( replayText );*/

	timeSurvivedText.text = 'You survived: ' + timeSurvived.toFixed( 2 ) + ' seconds!';
	timeSurvivedText.setTextFormat( new TextFormat( Global.DEFAULT_FONT, 20, 0xFFFF00, true ) );
	timeSurvivedText.selectable = false;
	timeSurvivedText.width = Global.APPWIDTH;
	timeSurvivedText.autoSize = 'center';
	timeSurvivedText.y = Global.APPHEIGHT / 2;
	addChild( timeSurvivedText );

}
}