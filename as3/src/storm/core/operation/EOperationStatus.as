/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.core.operation {
	/**
	 * @author 
	 */
	public final class EOperationStatus {
		/**
		 * Not Available
		 */
		public static const NA:int = 0;
		/**
		 * The operation is idle
		 */
		public static const IDLE:int = 1;
		/**
		 * The operation is currently in progress
		 */
		public static const IN_PROGRESS:int = 100;
		/**
		 * The operation has failed
		 */
		public static const FAILED:int = 250;
		/**
		 * The operation has been cancelled
		 */
		public static const CANCELLED:int = 254;
		/**
		 * The operation has completed
		 */
		public static const COMPLETE:int = 255;
		/**
		 * Returns the name of the operation status
		 */
		public static function ToString(status:int):String {
			switch (status) {
				case NA:return "N/A";
				case IDLE: return "Idle";
				case IN_PROGRESS: return "In Progress";
				case FAILED: return "Failed";
				case CANCELLED: return "Cancelled";
				case COMPLETE: return "Complete";
			}
			return "Unknonw Status";
		}
	}
}