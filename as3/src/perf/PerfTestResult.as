/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package perf {
	/**
	 * @author 
	 */
	public class PerfTestResult {
		//{ ------------------------ Constructors -------------------------------------------
		public function PerfTestResult(time:int, mem:int) {
			Time = time;
			Mem = mem;
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		public function toString():String {
			return Time.toString();
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		public var Time:int;
		public var Mem:int;
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		
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