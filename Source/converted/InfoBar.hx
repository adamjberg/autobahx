package ;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
/**
 * @author Adam
 */
class InfoBar extends Sprite {

private var _infoBar:TextField;
private var _textFormat:TextFormat;
private var gasBar:Sprite;
private static var _player:PlayerCar;

public function new( player:PlayerCar = null ) 
{
	_player = player;
	_textFormat = new TextFormat( 'Times New Roman', 15, 0xFFFF00, true, null, null, null, null, TextFormatAlign.CENTER );
	_infoBar = new TextField;
	_infoBar.x = Global.MARGIN;
	_infoBar.y = Global.GAME_HEIGHT - 1;
	_infoBar.width = Global.GAME_WIDTH;
	_infoBar.selectable = false;	
	addChild( _infoBar );
	gasBar = new Sprite();
	gasBar.graphics.beginFill( 0xFFFFFF );
	gasBar.graphics.drawRect( 0, 0, Global.GAME_WIDTH, 10 );
	gasBar.graphics.endFill();
	gasBar.x = Global.MARGIN;
	gasBar.y = _infoBar.y - 10;
	addChild( gasBar );
}

public function update():Void
{
	_infoBar.text = 'lives: ' + _player.lives;
	_infoBar.setTextFormat( _textFormat );
	gasBar.scaleX = _player.gas * 0.001;
}

public function setText( text:String ):Void {
	_infoBar.text = text;
	_infoBar.setTextFormat( _textFormat );
}

public var gas(null, setGas):Int;
 	private function setGas( value:Int ):Void {
	gasBar.scaleX = value * 0.001;
}
}