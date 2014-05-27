package ;

import flash.display.Sprite;
import flash.text.TextField;
/**
 * @author Adam
 */
class UpgradeMenu extends Sprite {
private static var _player:PlayerCar;
private static var money:TextField;

public function new( player:PlayerCar ):Void
{
	_player = player;
	money = new TextField();
	money.text = player.money + ' dollars';
	money.textColor = 0xFFFF00;
	money.x = Global.MARGIN;
	addChild( money );
	addChild( new CarSelect( player ) );
	addChild( new GasUpgrade( player ) );
}

public static function update(  ):Void {
	money.text = _player.money + 'dollars';
}
}