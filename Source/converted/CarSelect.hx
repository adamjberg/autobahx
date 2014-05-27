package ;

import flash.display.Sprite;
import flash.events.MouseEvent;
/**
 * @author Adam
 */
class CarSelect extends Sprite {
private var Cars:Array;
private var _player:PlayerCar;

public function new( player:PlayerCar ):Void
{
	_player = player;
	Cars = new Array();
	Cars[ 0 ] = new Car( 0xFFFFFF );
	Cars[ 1 ] = new Car( 0xFF0000 );
	Cars[ 2 ] = new Car( 0xFF5A00 );
	Cars[ 3 ] = new Car( 0xFFFF00 );
	Cars[ 4 ] = new Car( 0x00FF00 );
	Cars[ 5 ] = new Car( 0x0000FF )
	Cars[ 6 ] = new Car( 0x880088 );
	//Cars[ 0 ] = new Car( 0xFFFFFF );
	for( var i:Int = 0; i < Cars.length; i++)
	{
	var SPACE_BETW_CARS:Int = 30;
	Cars[ i ].x = ( i * SPACE_BETW_CARS );
	Cars[ i ].addEventListener( MouseEvent.CLICK, changeColor );
	addChild( Cars[ i ] );
	}
	y = 350;
	x = Global.GAME_WIDTH * 0.5 - width * 0.5;
}

public function changeColor( event:MouseEvent ):Void
{
	_player.color = event.target.color;
}
}