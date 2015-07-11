/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	/**
	 * @author 
	 */
	public class IsoScene extends InternalIsoSprite implements IIsoValidatable {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoScene() {
			_Init();
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		private function _Init():void {
			_InitInternalBg();
			_InitBackground();
			_InitEvents();
			try {
				Init();
			} catch (e:Error) {
				$LogMessage("Failed to exec Init for IsoUniverse, e=" + e.message);
			}		
			_InitLayers();
			try {
				PostInit();
			} catch (e:Error) {
				$LogMessage("Failed to exec PostInit for IsoUniverse, e=" + e.message);
			}			
		}
		/** @private */
		private function _InitEvents():void {
			addEventListener(TouchEvent.TOUCH, HandleOnTouchForDrag);
		}	
		/** @private */
		protected function Init():void {
		
		}
		/** @private */
		protected function PostInit():void {
		
		}		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/**
		 * Sets the visible area of the scene
		 */
		public function SetSize(w:int, h:int):void {
			ExplicitWidth = w;
			ExplicitHeight = h;
			Invalidate(VALIDATION_SIZE);
		}		
		/** @private */
		protected function ValidateSize():void {
			if (fInternalBg != null) {
				fInternalBg.width = ExplicitWidth;
				fInternalBg.height = ExplicitHeight;
			}
		}		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		
		//}
		
		//{ ------------------------ Background ---------------------------------------------
		/** @private */
		private function _InitBackground():void {
			try {
				var d:DisplayObject = InitBackground();
				if (d != null) {
					/*
					fBackgroundLayer = new IsoLayerImage("bg", d);
					fBackgroundLayer.touchable = false;
					fBackgroundLayer.IsInteractive = false;*/
				}
			} catch (e:Error) {
				$LogMessage("Failed to Initialize Universe Background, e=" + e.message);
			}
		}
		/** @private */
		protected function InitBackground():DisplayObject {
			return null;
		}
		
		/** @private */
		private function _InitInternalBg():void {
			fInternalBg = new Quad(100, 100, 0xEAFFFF);
			fInternalBg.alpha = 1.0;
			addChild(fInternalBg);
		}
		/** @private */
		private var fInternalBg:Quad;
		/** @private */
		//protected var fBackgroundLayer:IsoLayerImage;		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/**
		 * @private
		 * The width of the visible area
		 */
		internal var ExplicitWidth:int;
		/**
		 * @private
		 * The height of the visible area
		 */
		internal var ExplicitHeight:int;
		//}
		
		//{ ------------------------ Layers -------------------------------------------------
		/**
		 * Adds a layer to the scene.
		 * Layers are displayed in the order that are being added
		 */
		public function AddLayer(layer:IsoLayer):void {
			fLayers.push(layer);
			layer.$InternalInit(this);
			addChild(layer);
		}
		/** @private */
		private function _InitLayers():void {
			fLayers = new Vector.<IsoLayer>();
			try {
				InitLayers();
			} catch (e:Error) {
				$LogMessage("Failed to exec InitLayers in IsoUniverse, e=" + e.message);
			}			
		}
		/** @private */
		protected function InitLayers():void {
			
		}
		/** @private */
		private var fLayers:Vector.<IsoLayer>;
		//}
		
		//{ ------------------------ Interaction --------------------------------------------
		/** @private */
		private function HandleOnTouchForDrag(e:TouchEvent):void {
			
		}
		//}
		
		//{ ------------------------ Validation ---------------------------------------------
		/** @private */
		public function Invalidate(... rest:Array):void {
			var flag:int;
			var invalidate:Boolean = false;
			for (var i:*in rest) {
				flag = rest[i];
				if (fValidationFlags.indexOf(flag) == -1) {
					fValidationFlags.push(flag);
					invalidate = true;
				}
			}
			if (invalidate) {
				IsoValidation.Instance.Add(this);
			}
		}
		
		/** @private */
		public function Validate():void {
			var flag:int;
			for (var i:*in fValidationFlags) {
				flag = fValidationFlags[i];
				switch (flag) {
					case VALIDATION_ZOOM: 
						//ValidateCamera();
						break;
					case VALIDATION_SIZE: 
						ValidateSize();
						break;
				}
			}
			fValidationFlags = new Vector.<int>();
		}
		public function get IsInvalid():Boolean {
			return fValidationFlags.length > 0;
		}
		/** @private */
		private var fValidationFlags:Vector.<int> = new Vector.<int>();
		/** @private */
		public static const VALIDATION_ZOOM:int = 10;
		/** @private */
		public static const VALIDATION_SIZE:int = 11;
		
		//}		
		
		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Static -------------------------------------------------
		public static var $LogMessage:Function = trace;
		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}