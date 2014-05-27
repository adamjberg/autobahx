package ;

import flash.display.Sprite;

class Car extends Sprite {
	public function new():Void
	{
		super();

		this.graphics.beginFill( 0xFF0000 ); 
		this.graphics.drawRect( 0, 0, 20, 35 );
		this.graphics.endFill();
	}
}