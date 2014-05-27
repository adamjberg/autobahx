package ;

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
/**
 * @author Adam
 */
class Instructions extends TextField {

public function new() {
	this.text = 'Instructions:\nUse the arrow keys to \navoid oncoming traffic\nPress space to pause';
	this.setTextFormat( new TextFormat( Global.DEFAULT_FONT, 18, 0x000000, true, null, null, null, null, TextFormatAlign.CENTER ) );
	this.selectable = false;
	
	this.width = Global.GAME_WIDTH;
	this.x = 0;
	this.y = Global.APPHEIGHT / 2 - this.height / 2;
}
}