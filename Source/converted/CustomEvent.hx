package ;

 
import flash.events.Event;
 
class CustomEvent extends Event
{
public static inline var LOGO_CLICKED : String = "click";
public static inline var GAME_OVER : String = "game over";
 
public var params : Object;
 
public function new(type : String, params : Object,
		bubbles : Bool = false, cancelable : Bool = false)
{
	super(type, bubbles, cancelable);
	this.params = params;
}
 
public override function clone() : Event {
	return new CustomEvent(type, this.params, bubbles, cancelable);
}
 
public override function toString() : String {
	return formatToString("CustomEvent", "params", "type",
			  "bubbles", "cancelable");
}
}