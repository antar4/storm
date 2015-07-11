/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.core.operation {
	import storm.core.error.NotImplementedError;
	/**
	 * Basic implementation of the <code>IOperation</code> interface
	 * @author 
	 */
	public class Operation implements IOperation {
		//{ ------------------------ Constructors -------------------------------------------
		public function Operation(id:String) {
			fId = id;
			Init();
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		protected function Init():void {
			
		}		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/** @inheritDoc */
		public function Execute():Boolean {
			throw new NotImplementedError("AsyncOperation.Execute is NOT implemented, Override in subclass");
		}
		/** @inheritDoc */
		public function dispose():void {}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @inheritDoc */
		public function get Id():String {
			return fId;
		}

		/** @inheritDoc */
		public function get Status():int {
			return fStatus;
		}
		/** @private */
		public function set Status(v:int):void {
			if (fStatus == v) return;
			fStatus = v;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fId:String;
		/** @private */
		protected var fStatus:int;
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