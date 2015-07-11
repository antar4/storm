/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import flash.geom.Point;
	import starling.display.Graphics;
	import starling.display.Shape;
	/**
	 * @author 
	 */
	public class IsoPoint {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoPoint(_x:int, _y:int, _z:int) {
			fX = _x;
			fX2 = _x / 2;
			fY = _y
			fY2 = _y / 2;
			fZ = _z;
			fZ2 = _z / 2;
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		public function toString():String {
			return "x=" + fX + " y=" + fY + " z=" + fZ;
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Converts the points to an isometric x, y 2d coordinate
		 * @return
		 */
		public function ToIso(p:Point = null):Point {
			var sx:int = fX - fY;
			var sy:int = ( -fZ) * 1.2247 + (fX + fY) * 0.5;		
			if (p == null) {
				p = new Point(sx, sy);
			} else {
				p.setTo(sx, sy);
			}
			return p;
		}
		public function To2D(p:Point = null):Point {
			var sx:int = fY + fX2;
			var sy:int = fY - fY2;
			if (p == null) {
				p = new Point(sx, sy);
			} else {
				p.setTo(sx, sy);
			}
			return p;
		}
		//}
		
		//{ ------------------------ Size ---------------------------------------------------
		// functions related to when this is used as the size of a 3d object
		public final function get IsoBounds():IsoPolygon {
			if (fIsDirty) {
				CalculateIsoBounds();
			}
			return fIsoBounds;
		}
		/** @private */
		private function CalculateIsoBounds():void {
			if (fIsoBounds == null) {
				fIsoBounds = new IsoPolygon();
			} else {
				fIsoBounds.Reset();
			}
			// bottom face
			var bf2:Point = IsoMath.ToIso( +fX2, -fY2, -fZ2);
			var bf3:Point = IsoMath.ToIso( +fX2, +fY2, -fZ2);
			var bf4:Point = IsoMath.ToIso( -fX2, +fY2, -fZ2);
			// top face
			var tf1:Point = IsoMath.ToIso( -fX2, -fY2, +fZ2);
			var tf2:Point = IsoMath.ToIso( +fX2, -fY2, +fZ2);
			var tf4:Point = IsoMath.ToIso( -fX2, +fY2, +fZ2);
			fIsoBounds.AddPoint(tf1);
			fIsoBounds.AddPoint(tf2);
			fIsoBounds.AddPoint(bf2);
			fIsoBounds.AddPoint(bf3);
			fIsoBounds.AddPoint(bf4);
			fIsoBounds.AddPoint(tf4);
			fIsoBounds.AddPoint(tf1);
		}
		/** @private */
		private var fIsoBounds:IsoPolygon;
		//}

		//{ ------------------------ Properties ---------------------------------------------
		[Inline]
		public final function get x():int {
			return fX;
		}
		/** @private */
		public function set x(v:int):void {
			fX = v;
			fX2 = v / 2;
			fIsDirty = true;
		}
		[Inline]
		public final function get x2():int {
			return fX2;
		}
		[Inline]
		public final function get y():int {
			return fY;
		}
		/** @private */
		public function set y(v:int):void {
			fY = v;
			fY2 = v / 2;
			fIsDirty = true;
		}
		[Inline]
		public final function get y2():int {
			return fY2;
		}
		[Inline]
		public final function get z():int {
			return fZ;
		}
		/** @private */
		public function set z(v:int):void {
			fZ = v;
			fZ2 = v / 2;
			fIsDirty = true;
		}		
		[Inline]
		public final function get z2():int {
			return fZ2;
		}
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		private var fX:int;
		/** @private */
		private var fX2:int;
		/** @private */
		private var fY:int;
		/** @private */
		private var fY2:int;
		/** @private */
		private var fZ:int;
		/** @private */
		private var fZ2:int;
		/** @private */
		private var fIsDirty:Boolean = true;
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