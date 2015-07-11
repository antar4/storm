package storm.resources.core {
	import org.osflash.signals.ISignal;
	import storm.core.operation.IAsynOperation;
	
	 /**
	 * ...
	 * @author 
	 */
	public interface IExternalResource extends IResource {
		/**
		 * Instructs the resource to begin loading the resource from the specified url
		 * if the resource is already being loaded the current operation is returned
		 * @return returns an <code>IAsyncOperation</code>
		 */
		function Load():IAsynOperation;
		
		/**
		 * Instructs a resource to cancel loading or parsing, depending on its status
		 * @return	true if the resource is currently loading (Status = EResourceStatus.LOADING) 
		 * or is currently parsing (EResourceStatus.PARSING and can be cancelled. else false
		 */
		function Cancel():Boolean;		
		
		/**
		 * Dispatched when the resource is doing progress during loading or parsing
		 * distinguished from <code>status</code> @see EResourceStatus
		 * 
		 * Expected signature is <code>function(resource:IExternalResource, status:int, progress:Number):void</code> 
		 */
		function get OnProgress():ISignal;
		
		/**
		 * Dispatched when the resource has completed loading and parsing, failed or cancelled
		 * 
		* Expected signature is <code>function(resource:IExternalResource):void</code>  
		 */
		function get OnComplete():ISignal;
		
		/**
		 * Dispatched when the resource's <code>Status</code> is changed
		 * 
		 * Expected signature is <code>function(resource:IExternalResource, status:int):void</code> 
		 */
		function get OnStatusChanged():ISignal;
		
		/**
		 * Dispatched when the resource loading or parsing fails
		 * 
		 * Expected signature is <code>function(resource:IExternalResource, reason:String):void</code>
		 */
		function get OnError():ISignal;
		
		/**
		 * How this resource is being cached, @see EResourceCachePolicy
		 * @default EResourceCachePolicy.VOLATILE
		 */
		function get CachePolicy():int;	
		
		/**
		 * A number between 0 and 10 indicating the priority of this resource when loading
		 * Resources already being loaded even with lower priority will NOT be stopped
		 */
		function get Priority():int;
		
		/**
		 * The url from where the resource is being loaded
		 * If an id is not supplied is also used as id
		 */
		function get Url():String;
		

	}

}