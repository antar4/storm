/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package perf {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * @author 
	 */
	public class PerfGraphItem {
		//{ ------------------------ Constructors -------------------------------------------
		public function PerfGraphItem(group:String, name:String, value:int, iterations:int, mArgs:String, valSuffix:String) {
			Group = group == null ? "-" : group;
			fName = name;
			Value = value;
			fIterations = iterations;
			fMArgs = mArgs;
			fValSuffix = valSuffix == null ? "" : valSuffix;
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		public function toString():String {
			var msg:String = "";
			if (Group != null) {
				msg += Group + ":";
			}
			msg += fName;
			if (fMArgs != null) {
				msg += " (" + fMArgs + ")";
			}
			
			if (fIterations > 0) {
				msg += " [Iterations=" + fIterations + "]";
			}
			msg += " =>" + Value+" " + fValSuffix;
			return msg;
		}
		public function Info():String {
			var msg:String = "";
			if (Group != null) {
				msg += Group + ":";
			}
			msg += fName;
			if (fMArgs != null && fMArgs != "") {
				msg += " (" + fMArgs + ")";
			}
			return msg;
		}

		//}
		
		//{ ------------------------ API ----------------------------------------------------
		
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		public function CreateBar(maxTime:int):Sprite {
			var s:Sprite = new Sprite();
			var g:Graphics = s.graphics;
			var pct:Number = Value / maxTime;
			var clr:uint = BAR_COLORS[COLOR_INDEX++];
			if (COLOR_INDEX >= BAR_COLORS.length || (NUMBER_OF_COLORS_TO_USE != -1 && COLOR_INDEX >= NUMBER_OF_COLORS_TO_USE)) {
				COLOR_INDEX = 0;
			}
			g.beginFill(clr);
			g.drawRect(0, 0, BAR_WIDTH * pct, BAR_HEIGHT);
			g.endFill();
			
			var infoTxt:TextField = new TextField();
			infoTxt.defaultTextFormat = new TextFormat("Segoe UI", 12, 0x0);
			infoTxt.selectable = true;
			infoTxt.text = Info();
			infoTxt.width = BAR_WIDTH;
			s.addChild(infoTxt);
			
			var timeTxt:TextField = new TextField();
			timeTxt.defaultTextFormat = new TextFormat("Segoe UI", 12, 0x0, true, null, null, null, null, "right");
			timeTxt.text = Value+" " + fValSuffix;
			timeTxt.width = BAR_WIDTH;
			timeTxt.selectable = false;
			s.addChild(timeTxt);			
			return s;
		}
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		internal var Group:String;
		/** @private */
		private var fName:String;
		/** @private */
		internal var Value:int;
		/** @private */
		private var fIterations:int;
		/** @private */
		private var fMArgs:String;
		/** @private */
		private var fValSuffix:String;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Static -------------------------------------------------
		public static var BAR_WIDTH:int = 400;
		public static var BAR_HEIGHT:int = 20;
		internal static var COLOR_INDEX:int = 0;
		public static var NUMBER_OF_COLORS_TO_USE:int = -1;
		public static var BAR_COLORS:Array = [0x96DFEE, 0xCBE3D6, 0xF7AC6B, 0xE2788F];
		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}