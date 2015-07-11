/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.core.diagnostics {
	import flash.utils.Dictionary;
	/**
	 * @author 
	 */
	public class ObjectRegistry {
		//{ ------------------------ Constructors -------------------------------------------
		public function ObjectRegistry() {
			
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Register an object to the registry via a weak reference
		 */
		public static function Register(o:Object):void {
			INSTANCES[o] = true;
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Static -------------------------------------------------
		/** @private */
		protected static const INSTANCES:Dictionary = new Dictionary(true);
		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}