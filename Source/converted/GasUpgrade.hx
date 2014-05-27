package ;

import flash.display.Sprite;
import flash.events.MouseEvent;
/**
 * @author Adam
 */
class GasUpgrade extends Sprite{
private var _player:PlayerCar;

public function new( player:PlayerCar ):Void
{
	var gasUpgrades:Array;
	_player = player;
	gasUpgrades = new Array();
	gasUpgrades[ 0 ] = new GasButton( '1 Gallon', 100, 100 );
	gasUpgrades[ 1 ] = new GasButton( '2 Gallon', 200, 200 );
	gasUpgrades[ 2 ] = new GasButton( '3 Gallon', 300, 300 );
	
	gasUpgrades[ 0 ].x = 20;
	gasUpgrades[ 0 ].y = 150;
	gasUpgrades[ 1 ].x = 80;
	gasUpgrades[ 1 ].y = 150;
	gasUpgrades[ 2 ].x = 140;
	gasUpgrades[ 2 ].y = 150;
	
	gasUpgrades[ 0 ].addEventListener( MouseEvent.CLICK, addGas );
	gasUpgrades[ 1 ].addEventListener( MouseEvent.CLICK, addGas );
	gasUpgrades[ 2 ].addEventListener( MouseEvent.CLICK, addGas );
	
	for( var i:Int = 0; i < gasUpgrades.length; i++ )
	{
	addChild( gasUpgrades[ i ] );
	}
}

private function addGas( event:MouseEvent ):Void {
	if( _player.money >= event.target.cost )
	{
	_player.gas += event.target.gas;
	_player.money -= event.target.cost;
	UpgradeMenu.update();
	}
}
}