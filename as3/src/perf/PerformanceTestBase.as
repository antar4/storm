/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package perf {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.LocalConnection;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * @author 
	 */
	public class PerformanceTestBase extends Sprite {
		//{ ------------------------ Constructors -------------------------------------------
		public function PerformanceTestBase() {
			_Init();
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		private function _Init():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			fLog = new TextField();
			fLog.defaultTextFormat = new TextFormat("Segoe UI", 12, 0);
			fLog.width = 1000;
			fLog.height = 600;
			fLog.wordWrap = true;
			fLog.multiline = true;
			fLog.y = 600;
			addChild(fLog);
			Init();
		}
		/** @private */
		protected function Init():void {
			
		}
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		protected function Log(msg:String):void {
			fLog.htmlText += msg;
		}
		protected function LogHeader(msg:String):void {
			fLog.htmlText += "\n";
			fLog.htmlText += "<b>" + msg + "</b>";
		}
		protected function LogCounter(group:String, name:String, value:int, iterations:int = 0, mArgs:String = "", valSuffix:String = "ms."):void {
			var item:PerfGraphItem = new PerfGraphItem(group, name, value, iterations, mArgs, valSuffix);
			fGraphItems.push(item);
			Log(item.toString());
		}
		private function __gc():void {
			try {
				new LocalConnection().connect("__GC__");
				new LocalConnection().connect("__GC__");
			} catch (e:Error) { }
			System.gc();
			System.gc();			
		}		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Begins a stopwatch with the specified id
		 */
		public final function BeginTest(id:String = "#"):void {
			__gc();
			fMem[id] = System.totalMemory;
			fSW[id] = getTimer();
		}
		/**
		 * Stops a stopwatch with the specified id
		 * @return 	the time in milliseconds passed since the stopwatch was started
		 * if no stopwatch is found, -1 is returned
		 */
		public final function StopTest(id:String = "#"):PerfTestResult {
			var t:int;
			if (fSW[id] == null) {
				t = -1;
			} else {
				var v:int = fSW[id];
				t = getTimer() - v;
				delete(fSW[id]);
			}
			var m:int;
			if (fMem[id] == null) {
				m = 0;
			} else {
				m = System.totalMemory - fMem[id];
			}
			return new PerfTestResult(t, m);
		}
		public function CreateChart():void {
			PerfGraphItem.COLOR_INDEX = 0;
			var max:int = 0;
			var groups:Dictionary = new Dictionary();
			var item:PerfGraphItem;
			for (i in fGraphItems) {
				item = fGraphItems[i];
				max = groups[item.Group];
				if (item.Value > max) {
					max = item.Value;
					groups[item.Group] = max;
				}
			}
			var i:*;
			var s:Sprite = new Sprite();
			var bar:Sprite;
			var yy:int = 0;
			for (var g:* in groups) {
				for (i in fGraphItems) {
					item = fGraphItems[i];
					if (item.Group == g) {
						bar = item.CreateBar(groups[g]);
						bar.y = yy;
						addChild(bar);
						yy += PerfGraphItem.BAR_HEIGHT + 2;
					}
				}
				yy += 32;
				PerfGraphItem.COLOR_INDEX = 0;
			}
			s.x = 20;
			s.y = 20;
			addChild(s);
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		private var fSW:Dictionary = new Dictionary();
		/** @private */
		private var fMem:Dictionary = new Dictionary();
		/** @private */
		private var fLog:TextField;
		/** @private */
		private var fGraphItems:Vector.<PerfGraphItem> = new Vector.<PerfGraphItem>();
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