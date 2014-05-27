package ;

import flash.text.TextFormat;
import flash.display.Sprite;
import flash.text.TextField;
/**
 * @author Adam
 */
class PauseScreen extends Sprite {

private static var pauseText:TextField;

public function new() {
	/*this.graphics.beginFill( 0x0000FF );
	this.graphics.drawRect( Global.MARGIN, 0, Global.GAME_WIDTH, Global.APPHEIGHT );
	this.graphics.endFill();*/
	
	pauseText = new TextField;
	pauseText.text = '------PAUSED------';
	pauseText.setTextFormat( new TextFormat( 'Times New Roman', 26, 0xFFFF00, true ) );
	pauseText.x = 0;
	pauseText.width = Global.APPWIDTH;
	pauseText.autoSize = 'center';
	pauseText.y = Global.APPHEIGHT / 2 - pauseText.height;
	pauseText.selectable = false;
	addChild( pauseText );
}

}