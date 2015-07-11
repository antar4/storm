/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.core.operation {
	/**
	 * This operation allows multiple operations be chained and executed in order
	 * @author 
	 */
	public class CompoundOperation extends AsyncOperation {
		//{ ------------------------ Constructors -------------------------------------------
		public function CompoundOperation(id:String) {
			fOperations = new Vector.<IOperation>();
			super(id);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Adds an operation 
		 */
		public function AddOperation(operation:IOperation):void {
			fOperations.push(operation);
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fOperations:Vector.<IOperation>;
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