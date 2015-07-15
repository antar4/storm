/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	/**
	 * @author 
	 */
	public class EIsoInteractiveEvents {
		public static const ROLLOVER:int = 1;
		public static const ROLLOUT:int = 2;
		public static const PRESS:int = 3;
		public static const RELEASE:int = 4;
		public static const LONG_PRESS:int = 5;
		/**
		 * When the player has pressed for the initial time to begin recording a long press
		 */
		public static const LONG_PRESS_START:int = 6;
	}

}