/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.resources.core {
	/**
	 * @author 
	 */
	public class EResourceCachePolicy {
		
		/**
		 * The resource is not cached at all. As soon as it is loaded and dispatched
		 * it is disposed
		 */
		public static const NO_CACHE:int = 1;

		/**
		 * The resource persists for as long as there are references to it. 
		 * After that it will disposed when the interal garbage collector runs (within 5 seconds)
		 */
		public static const VOLATILE:int = 2;
		
		/**
		 * The resource persist through the entire session unless explicitly requested to be disposed
		 */
		public static const PERSISTENT:int = 3;
	}

}