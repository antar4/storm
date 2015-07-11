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
	public class Polygon2d {
		//{ ------------------------ Constructors -------------------------------------------
		public function Polygon2d() {
			fPoints = new Vector.<Point>();
			fScale = new Point(1, 1);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		public function toString():String {
			var s:String = "";
			for (var i:* in fPoints) {
				s += fPoints[i].x + "x" + fPoints[i].y + " ";
			}
			return s;
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Adds a new point to the polygon
		 */
		public function Add(x:int, y:int):void {
			fPoints.push(new Point(x, y));
		}
		/**
		 * Adds a new point to the polygon
		 */
		public function AddPoint(p:Point):void {
			fPoints.push(p);
		}
		/**
		 * Resets the polygon to its initial value
		 */
		public function Reset():void {
			fPoints.length = 0;
			fScale.setTo(1, 1);
		}
		/**
		 * Renders the polygon in a shape
		 * @return
		 */
		public function Render(scaleX:Number = 1.0, scaleY:Number = 1.0):Shape {
			if (fPoints.length <= 0) return new Shape();
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.lineStyle(1, 0xFF0000, 1.0);
			g.moveTo(fPoints[0].x * scaleX, fPoints[0].y * scaleY);
			for (var i:int = 1; i < fPoints.length; i++) {
				g.lineTo(fPoints[i].x * scaleX, fPoints[i].y * scaleY);
			}
			return s;
		}
		
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/**
		 * Returns a list with all the points in the polygon
		 */
		[Inline]
		public final function get Points():Vector.<Point> {
			return fPoints;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		private var fPoints:Vector.<Point>;
		/** @private */
		private var fScale:Point;
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