/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.resources.core {
	/**
	 * An <code>IResourceConsumer</code> holds a reference to the 
	 * resource not allowing it to be garbage collected when its cache 
	 * policy is EResourceCachePolicy.VOLATILE and is informed of any changes
	 * made to the resource
	 * 
	 * <strong>Each consumer may ONLY hold one reference to each resource</strong>
	 * @author 
	 */
	public interface IResourceConsumer {
		/**
		 * Informs the user that the resource's status or data has changed
		 */
		function $OnResourceChanged(r:IResource):void;
	}
}