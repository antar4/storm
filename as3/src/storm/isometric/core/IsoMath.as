/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import flash.geom.Point;
	/**
	 * @author 
	 */
	public class IsoMath {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoMath() {
			
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		public static function ToIso(x:int, y:int, z:int, result:Point = null):Point {
			var sx:int = x - y;
			var sy:int = -z * 1.2247 + (x + y) * 0.5;		
			if (result == null) {
				result = new Point(sx, sy);
			} else {
				result.setTo(sx, sy);
			}
			return result;			
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		
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

		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}