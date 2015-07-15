/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package debug.debugIso {
	import flash.display.Bitmap;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	import storm.isometric.core.EIsoInteractiveEvents;
	import storm.isometric.core.IsoDisplayObject;
	import storm.isometric.core.IsoEntity;
	import storm.isometric.core.IsoLayer;
	import storm.isometric.core.IsoPoint;
	import storm.isometric.core.IsoScene;
	/**
	 * @author 
	 */
	public class DebugIso extends Sprite {
		[Embed(source = "assets/bank1.png")]
		public static var BANK:Class;		
		[Embed(source = "assets/bakery1.png")]
		public static var BAKERY:Class;
		
		//{ ------------------------ Constructors -------------------------------------------
		public function DebugIso() {
			Init();
			Starling.current.showStatsAt();
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		private function Init():void {
			scene = new IsoScene();
			var s:IsoScene = scene;
			s.OnEntityTouch.add(HandleOnSceneEntityTouch);
			s.SetSize(600, 400);

			var l:IsoLayer = new IsoLayer("test");
			s.AddLayer(l);
			
			var bank:Bitmap = new BANK();
			var bankTexture:Texture = Texture.fromBitmap(bank, false);
			var bankImage:Image = new Image(bankTexture);

			var bakery:Bitmap = new BAKERY();
			var bakeryTexture:Texture = Texture.fromBitmap(bakery, false);
			var bakeryImage:Image = new Image(bakeryTexture);
			/*
			
			e3 = new IsoEntity("e-3", 100, 100, 100);
			e3.IsoLocation = new IsoPoint(300, 200, 1);
			var bankDO:IsoDisplayObject = e3.addChild("bank", bankImage, -100, -100);
			l.Add(e3);			
			e3.IsInteractive = true;
			e3.OnTouch.add(HandleOnEntityTouch);
			
			*/
			e4 = new IsoEntity("e-4", 100, 100, 50);
			e4.IsoLocation = new IsoPoint(300, 300, 1);
			var bakeryDO:IsoDisplayObject = e4.addChild("bakery", bakeryImage, -100, -64);
			l.Add(e4);			
			e4.IsInteractive = true;
			e4.OnTouch.add(HandleOnEntityTouch);

			addChild(s);
			addEventListener(KeyboardEvent.KEY_UP, HadleOnKey);
		}
		
		private function HandleOnSceneEntityTouch(e:IsoEntity, event:int):void {
			//trace("Scene Entity Touched=" + e+" =>" + event);
		}
		
		private function HandleOnEntityTouch(e:IsoEntity, event:int):void {
			trace("Entity Touched=" + e.Id + " =>" + event);
			trace("\t" + e.Children[0].b);
			if (event == EIsoInteractiveEvents.PRESS) {
				scene.BeginMove(e, true, true);
			} else if (event == EIsoInteractiveEvents.ROLLOVER) {
				e.Children[0].filter = BlurFilter.createGlow(0xFF0000, 10, 2, 2);
			} else if (event == EIsoInteractiveEvents.ROLLOUT) {
				e.Children[0].filter = null;
			}
			
		}
		private var scene:IsoScene;
		private var e3:IsoEntity ;
		private var e4:IsoEntity ;
		
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