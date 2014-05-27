package ;

import flash.display.Sprite;
/**
 * @author Adam
 */
class Car extends Sprite {
private var _color:UInt;
public function new( color:UInt ):Void
{
	this._color = color;
	this.graphics.beginFill( color ); 
	this.graphics.drawRect( 0, 0, 20, 35 );
	this.graphics.endFill();
}
public var color(getColor, null):UInt;
 	private function getColor():UInt{
	return _color;
}
}