/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package debug.debugIso {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import storm.isometric.core.IsoEntity;
	import storm.isometric.core.IsoLayer;
	import storm.isometric.core.IsoPoint;
	import storm.isometric.core.IsoScene;
	/**
	 * @author 
	 */
	public class DebugIso extends Sprite {
		//{ ------------------------ Constructors -------------------------------------------
		public function DebugIso() {
			trace("debug iso");
			Init();
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		private function Init():void {
			var s:IsoScene = new IsoScene();
			s.SetSize(600, 400);

			var l:IsoLayer = new IsoLayer("test");
			s.AddLayer(l);
			
			/*
			var xx:int = 300;
			var yy:int = 0;
			var e:IsoEntity
			for (var _x:int = 0; _x < 3; _x++) {
				for (var _y:int = 0; _y < 3; _y++) {
					if (_x == 1 && _y == 1) {
						e = new IsoEntity("e-" + _x + "-" + _y, 100, 50, 10);
					} else {
						e = new IsoEntity("e-" + _x + "-" + _y, 50, 50, 1);
					}
					e.IsoLocation = new IsoPoint(xx + (_x * 50), yy + (_y * 50), 0);
					l.Add(e);
				}
			}
			*/
			
			var e1:IsoEntity = new IsoEntity("e-1", 50, 50, 10);
			e1.IsoLocation = new IsoPoint(100, 50, 0);
			l.Add(e1);
			
			/**
			e3 = new IsoEntity("e-3", 50, 100, 0);
			e3.IsoLocation = new IsoPoint(0, 50, 50);
			l.Add(e3);			
			*/
			addChild(s);
			
			addEventListener(KeyboardEvent.KEY_UP, HadleOnKey);
		}
		private var e3:IsoEntity ;
		
		private function HadleOnKey(e:KeyboardEvent):void {
			e3.IsoZ++;
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