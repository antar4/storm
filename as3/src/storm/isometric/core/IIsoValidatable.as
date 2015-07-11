package storm.isometric.core {
	
	 /**
	 * ...
	 * @author 
	 */
	public interface IIsoValidatable {
		function Invalidate(... rest:Array):void;
		function Validate():void;
		function get IsInvalid():Boolean;
	}

}