/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.filters.FragmentFilter;
	/**
	 * @author 
	 */
	public class IsoDisplayObject {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoDisplayObject(id:String, d:DisplayObject, offsetX:int, offsetY:int, includeInTouch:Boolean) {
			fId = id;
			DO = d;
			fOffsetX = offsetX;
			fOffsetY = offsetY;
			IncludeInBounds = includeInTouch;
			DO.touchable = false;
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		internal function hitTest(p:Point):Boolean {
			if (!IncludeInBounds) return false;
			// starling uses local coords
			H_P.setTo(p.x - DO.x, p.y - DO.y);
			return DO.hitTest(H_P, false) != null;
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @private */
		public final function get Bounds():Rectangle {
			return DO.bounds;
			H_R.setTo(fOffsetX, fOffsetY, DO.bounds.width, DO.bounds.height);
			return H_R;
		}
		public function get b():Rectangle {
			return DO.bounds;
		}
		public final function get visible():Boolean {
			return DO.visible;
		}
		public final function set visible(v:Boolean):void {
			DO.visible = v;
		}
		public function get filter():FragmentFilter {
			return DO.filter;
		}
		public function set filter(v:FragmentFilter):void {
			DO.filter = v;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		private var fId:String;
		/** @private */
		internal var DO:DisplayObject;
		/** @private */
		internal var fOffsetX:int;
		/** @private */
		internal var fOffsetY:int;
		/** @private */
		internal var IncludeInBounds:Boolean;
		protected static const H_P:Point = new Point();
		protected static const H_R:Rectangle = new Rectangle();
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