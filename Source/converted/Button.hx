package ;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.describeType;
/**
 * @author Adam
 */
class Button extends SimpleButton {

private var buttonUp:Sprite;
private var buttonDown:Sprite;
private var textFormat:TextFormat;
private var buttonText:TextField;

public function new( text:String = '', x:Int = 0, y:Int = 0, width:Int = 200, height:Int = 50) {
	buttonUp = new Sprite();
	buttonUp.graphics.beginFill( 0x000080 );
	buttonUp.graphics.drawRoundRect( 0, 0, width, height, 50 );
	buttonUp.graphics.endFill();
	
	buttonText = new TextField;
	buttonText.selectable = false;
	buttonText.width = width;
	buttonText.text = text;
	buttonText.autoSize = 'center';
	textFormat = new TextFormat( 'Times New Roman', 24, 0xFFFF00, true );
	buttonText.setTextFormat( textFormat );
	buttonText.y += buttonUp.height / 2 - buttonText.height / 2;
	
	buttonUp.addChild( buttonText );
	
	super( buttonUp, buttonUp, buttonUp, buttonUp );
}
}