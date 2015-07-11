/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package debug.debugIso {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	/**
	 * @author
	 */
	public class ExecIso extends Sprite {
		//{ ------------------------ Constructors -------------------------------------------
		public function ExecIso() {
			if (stage)
				Init();
			else
				addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		//}
		
		//{ ------------------------ Init ---------------------------------------------------
		private function Init(e:Event = null):void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			stage.addEventListener(Event.RESIZE, HandleOnStageResized, false, 0, true);
			// entry point
			fS = new Starling(DebugIso, stage);
			fS.start();
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
		private var fS:Starling;
		//}
		
		//{ ------------------------ Event Handlers -----------------------------------------
		private function HandleOnStageResized(e:Event):void {
			// set rectangle dimensions for viewPort:
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			
			// resize the viewport:
			Starling.current.viewPort = viewPortRectangle;
			
			// assign the new stage width and height:
			fS.stage.stageWidth = viewPortRectangle.width;
			fS.stage.stageHeight = viewPortRectangle.height;
		}
		//}
	
		//{ ------------------------ Events -------------------------------------------------
	
		//}
	
		//{ ------------------------ Static -------------------------------------------------
	
		//}
	
		//{ ------------------------ Enums --------------------------------------------------
	
		//}
	}

}