package ;

import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
/**
 * @author Adam
 */
class GameTitle extends TextField {

public function new() { 
this.text = 'Autobahx';
this.width = Global.APPWIDTH;
this.height = Global.APPHEIGHT;
this.wordWrap = true;
this.setTextFormat( new TextFormat( 'Times New Roman', 60, 0xFFFF00, true, false, false, null, null, TextFormatAlign.CENTER ) );
this.selectable = false;
this.filters =  [ new DropShadowFilter( 4, 45, 0xFFFFFF, 1, 1000, 4 ) ];
}
}