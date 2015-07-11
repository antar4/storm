/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.behaviour {
	import storm.isometric.core.IsoEntity;
	/**
	 * A behaviour for IsoEntity is executed based on its type
	 * @author 
	 */
	public interface IIsoBehaviour {
		/**
		 * Execution of the actual code
		 */
		function Exec():void;
		/**
		 * The entity that this behaviour is applied to
		 */
		function get Owner():IsoEntity;
		/**
		 * Indicates the mode for executing this behaviour
		 * @see EBehaviourUpdateMode
		 */
		function get UpdateMode():int;
	}

}