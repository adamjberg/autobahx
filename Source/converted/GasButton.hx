package ;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;
/**
 * @author Adam
 */
class GasButton extends SimpleButton {
private var background:Sprite;
private var _gas:Int = 0;
private var _cost:Int = 0;

public function new( text:String = '', amount:Int = 0, cost:Int = 0 ):Void {
	_gas = amount;
	_cost = cost;
	var textField:TextField = new TextField();
	background = new Sprite();
	background.graphics.beginFill( 0xFFFFFF ); 
	background.graphics.drawRect( 0, 0, 40, 40 );
 	background.graphics.endFill();
	textField.text = text;
	textField.y = background.height - textField.textHeight;
	textField.selectable = false;
	background.addChild( textField );
	super( background, background, background, background );
}

public var gas(getGas, null):Int;
 	private function getGas():Int {
	return _gas;
}

public var cost(getCost, null):Int;
 	private function getCost():Int {
	return _cost;
}
}