/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	/**
	 * @author 
	 */
	public class EIsoSortingMode {
		/**
		 * No automatic sorted, all objects use their provided <code>IsoDepth</code> for sorting
		 */
		public static const NO_SORTING:int = -1;
		/**
		 * Use 3d bounds for sorting - slowest
		 */
		public static const BOUNDS_3D:int = 1;
		/**
		 * Use 3d bounds optimised for mostly cube-shaped bounds - fast (may result in some misplacements)
		 */
		public static const BOUNDS_3D_FAST:int = 2;
		/**
		 * Uses 3d bounds for ALL cube-shaped bounds - fastest
		 */
		public static const BOUNDS_3D_CUBE:int = 3;
		/**
		 * Uses a custom, user provided method for sorting the objects
		 */
		public static const CUSTOM:int = 99;
	}

}