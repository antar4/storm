/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.resources.core {
	/**
	 * @author 
	 */
	public class EResourceStatus {
		/**
		 * Not available
		 */
		public static const NA:int = 0
		
		/**
		 * The resource is being loaded
		 */
		public static const LOADING:int = 1;
		
		/**
		 * The resource has completed loading and is being parsed
		 */
		public static const PARSING:int = 10;
		
		/**
		 * The resource has failed to load
		 */
		public static const FAILED_LOAD:int = 250;
		
		/**
		 * The resource has been properly loaded but failed to parse
		 */
		public static const FAILED_PARSING:int = 251;
		
		/**
		 * The resource has succesfully been loaded and parsed
		 */
		public static const COMPLETE:int = 255;
	}

}