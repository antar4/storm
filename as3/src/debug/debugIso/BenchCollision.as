/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package debug.debugIso {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * @author
	 */
	public class BenchCollision extends Sprite {
		//{ ------------------------ Constructors -------------------------------------------
		public function BenchCollision() {
			Run();
		}
		//}
		
		//{ ------------------------ Init ---------------------------------------------------
		private function Run():void {
			var w:int = 1024;
			var h:int = 1024;
			
			var bd:BitmapData = new BitmapData(w, h, true);
			var items:int = 1000;
			var i:int;
			var r:Rectangle;
			var rList:Vector.<Rectangle> = new Vector.<Rectangle>();
			for (i = 0; i < items; i++) {
				r = new Rectangle(int(Math.random() * w), int(Math.random() * h), int(Math.random() * w / 10), int(Math.random() * h / 10));
				rList.push(r);
			}
			rList[0] = new Rectangle(5, 5, 10, 10);
			
			var st:int = getTimer();
			var s:Shape = new Shape();
			s.graphics.clear();
			for (i = 0; i < items; i++) {
				r = rList[i];
				var c:uint = 0xFF0000;
				//c += i;
				s.graphics.lineStyle(0, c);
				s.graphics.beginFill(c);
				s.graphics.drawRect(r.x, r.y, r.width, r.height);
				s.graphics.endFill();
			}
			bd.draw(s);
			var et:int = getTimer();
			addChild(new Bitmap(bd));
			
			var t:TextField = new TextField();
			t.defaultTextFormat = new TextFormat("Tahoma", 12, 0x0);
			t.wordWrap = t.multiline = true;
			addChild(t);
			t.text = "Time = " + (et - st) + " ms.";
			
			var rr:Rectangle = new Rectangle(0, 0, 10, 10);
			var collisionIterations:int = 10;
			
			var isHit:Boolean;
			st = getTimer();
			for (i = 0; i < collisionIterations; i++) {
				for (var j:int = 0; j < items; j++) {
					//isHit = rList[j].intersects(rr);
					isHit = RectIntersects(rList[j], rr);
				}
			}
			et = getTimer();
			t.appendText("\nRect Collision = " + (et - st) + " ms.");
			
			var hp:Point = new Point(20, 20);
			
			st = getTimer();
			
			for (i = 0; i < collisionIterations; i++) {
				isHit = (bd.hitTest(hp, 1, rr, hp, 1));
			}
			et = getTimer();
			t.appendText("\nBD Collision = " + (et - st) + " ms.");
		
		}
		[Inline]
		public final function RectIntersects(r1:Rectangle, r2:Rectangle):Boolean {
			return !(r1.bottom < r2.y || r1.y > r2.bottom || r1.right < r2.x || r1.x > r2.right)
		}
		//}
	
		//{ ------------------------ Core ---------------------------------------------------
	
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