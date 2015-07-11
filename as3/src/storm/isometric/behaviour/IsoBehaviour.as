/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.behaviour {
	import storm.isometric.core.IsoEntity;
	/**
	 * Basic implementation of the IIsoBehaviour interface
	 * @author 
	 */
	public class IsoBehaviour implements IIsoBehaviour {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoBehaviour(owner:IsoEntity, updateMode:int = EBehaviourUpdateMode.TICK) {
			fOwner = owner;
			fUpdateMode = updateMode;
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/** @inheritDoc */
		public function Exec():void {
			// do nothing
		}
		
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @inheritDoc */
		public function get Owner():IsoEntity {
			return fOwner;
		}
		/** @inheritDoc */
		public function get UpdateMode():int {
			
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fOwner:IsoEntity;
		/** @private */
		protected var fUpdateMode:int;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Static -------------------------------------------------

		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}