package storm.core.operation {
	import flash.utils.ByteArray;
	import org.osflash.signals.ISignal;
	
	 /**
	 * An asyncronous operation
	 * @author 
	 */
	public interface IAsynOperation extends IOperation {
		/**
		 * Dispatched when the operation is progressing
		 * 
		 * Expected signature is <code>function(operation:IAsyncOperation, progress:Number):void</code> 
		 */
		function get OnProgress():ISignal;
		
		/**
		 * Dispatched when the operation has completed its work
		 * 
		* Expected signature is <code>function(operation:IAsyncOperation):void</code>  
		 */
		function get OnComplete():ISignal;
		
		/**
		 * Dispatched when the operation's <code>Status</code> is changed
		 * 
		 * Expected signature is <code>function(operation:IAsyncOperation, status:int):void</code> 
		 */
		function get OnStatusChanged():ISignal;
		
		/**
		 * Dispatched when the operation fails
		 * 
		 * Expected signature is <code>function(operation:IAsyncOperation, reason:String):void</code>
		 */
		function get OnError():ISignal;
		
		/**
		 * Instructs an operation to cancel its work
		 * @return	true if the operation is currently executing (Status = EOperationStatus.IN_PROGRESS) and can be cancelled. else false
		 */
		function Cancel():Boolean;
		
		/**
		 * Returns the progress of the operation (0.0 - 1.0)
		 * <strong>Failed operations have a value of -1.0</strong>
		 */
		function get Progress():Number;
		
		/**
		 * The raw data received from the load operation
		 */
		function get RawData():ByteArray;		
	}
}