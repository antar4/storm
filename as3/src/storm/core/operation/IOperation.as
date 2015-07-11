package storm.core.operation {
	import org.osflash.signals.ISignal;
	
	 /**
	 * @author Nicolas Siatras
	 * This interface
	 */
	public interface IOperation {
		/**
		 * Instructs the operation to execute
		 * @return true if the operation can be executed, false if the operation cannot
		 */
		function Execute():Boolean;
		
		/**
		 * The Id of the operation
		 */
		function get Id():String;
		
		/**
		 * The status of the operation
		 * @see EOperationStatus
		 */
		function get Status():int;
		
		/**
		 * Disposes any resources associated with the operation
		 */
		function dispose():void;
	}
}