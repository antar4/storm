package storm.resources.core {
	
	 /**
	 * Basic IResource interface for use with ResourceManager
	 * @author 
	 */
	public interface IResource {
		/**
		 * A unique id among the same resource type
		 */
		function get Id():String;
		
		/**
		 * Unloads and disposes the resource
		 */
		function Unload():void;
		
		/**
		 * The status of the resource, @see EResourceStatus
		 */
		function get Status():int;
		
		/**
		 * Adds a consumer for this resource
		 * A consumer may ONLY be added ONCE
		 */
		function AddConsumer(consumer:IResourceConsumer):void;
		
		/**
		 * Removes a consumer from the resource
		 */
		function RemoveConsumer(consumer:IResourceConsumer):void;
		
		/**
		 * Request to refresh the data of the specified consumer
		 * calls <code>IResourceConsumer.$OnResourceChanged</code>
		 * @return true if the consumer was registered with the resource 
		 * and the refresh succeded
		 */
		function RefreshConsumer(consumer:IResourceConsumer):Boolean;
		
		/**
		 * Returns a list with ALL active consumers this resource has
		 */
		function get Consumers():Vector.<IResourceConsumer>;
	}
}