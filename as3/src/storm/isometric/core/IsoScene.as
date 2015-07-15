/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
		/**
		 * Translates the viewport
		 * @param	animateSeconds 	if greater than zero the camera will move to the new location is the specified seconds
		 */
		public function Translate(dx:int, dy:int, animateSeconds:Number = 0.0):void {
			for (var i:* in fLayers) {
				fLayers[i].Translate(dx, dy);
			}
		}
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
			if (fMovingEntity != null) {
				if (HandleOnTouchForMove(e)) {
					return;
				}
			}			
			
			if (!fIsDraggingEnabled) {
				return;
			}
			
			var d:DisplayObject = e.currentTarget as DisplayObject;
			var t:Touch = e.getTouch(d);
			if (!t) {
				return;
			}
			t.getLocation(d, TOUCH_HELPER_POINT);
			if (t.phase == TouchPhase.BEGAN) {
				fIsDragging = false;
				fStartDrag = true;
				fDragPt = TOUCH_HELPER_POINT.clone();
			} else  if (t.phase == TouchPhase.ENDED) {
				fStartDrag = false;
				fIsDragging = false;
			} else if (fStartDrag || fIsDragging) {
				var _x:Number = TOUCH_HELPER_POINT.x - fDragPt.x;
				var _y:Number = TOUCH_HELPER_POINT.y - fDragPt.y;
				if (fStartDrag) {
					var ax:int = (_x + (_x >> 31)) ^ (_x >> 31);
					var ay:int = (_y + (_y >> 31)) ^ (_y >> 31);
					if (ax + ay < DragSensitivity) {
						return;
					} else {
						fIsDragging = true;
						fStartDrag = false;
					}
				}
				Translate(_x, _y);
				fDragPt.setTo(TOUCH_HELPER_POINT.x, TOUCH_HELPER_POINT.y);
				
			}
		}
		/** @private */
		protected function HandleOnTouchForMove(e:TouchEvent):Boolean {
			
			if (fMovingEntity == null) {
				return false
			}
			var t:Touch = e.getTouch(this);
			if (!t) {
				return true;
			}
			
			if (t.phase == TouchPhase.ENDED && fCompleteMoveOnTouchEnd) {
				CompleteMove();
				return true;
			}
			if (t.phase == TouchPhase.HOVER && !fHasBegunMovingEntity) {
				return false;
			}
			var layer:IsoLayer = fMovingEntity.Layer;
			if (fHasBegunMovingEntity) {
				if (t.phase == TouchPhase.ENDED) {
					fHasBegunMovingEntity = false;
					return true;
				}
				t.getLocation(this, TOUCH_HELPER_POINT);
				
				fMovingEntity.Layer.ScreenToIso(TOUCH_HELPER_POINT.x, TOUCH_HELPER_POINT.y, H_POINT_1);
				// implement tiling
				fMovingEntity.IsoX = H_POINT_1.x;
				fMovingEntity.IsoY = H_POINT_1.y;
			} else {
				t.getLocation(layer, TOUCH_HELPER_POINT);
				var ht:IsoHDO = layer.hitTest(TOUCH_HELPER_POINT) as IsoHDO;
				if (ht == null || ht.Target != fMovingEntity) {
					return false;
				}		
				if (t.phase == TouchPhase.BEGAN || t.phase == TouchPhase.MOVED) {
					fHasBegunMovingEntity = true;
					return true;
				}				
			}
			return true;
		}
		//}
		
		//{ ------------------------ Entities -----------------------------------------------
		public function BeginMove(e:IsoEntity, lockEverythingElse:Boolean = true, completeMoveOnTouchEnd:Boolean = false):void {
			if (fMovingEntity != null) {
				throw new ArgumentError("Cannot BeginMove while an entity is already being moved. Call CompleteMove first");
			}
			fCompleteMoveOnTouchEnd = completeMoveOnTouchEnd;
			fStartDrag = false;
			fIsDragging = false;
			fMovingObjectInitialPosition.setTo(e.IsoX, e.IsoY, 0, 0);
			fMovingEntity = e;
			fMovingEntity.$BeginMove();
		}
		public function CompleteMove(keep:Boolean = true):void {
			trace("Complete Move");
			if (!keep) {
				fMovingEntity.IsoX = fMovingObjectInitialPosition.x;
				fMovingEntity.IsoY = fMovingObjectInitialPosition.y;
			}
			fMovingEntity.$CompleteMove();
			fMovingEntity = null;
		}
		
		/**
		 * Indicates the mouse/finger is down and over the fMovingEntity
		 * and the fMovingOffset is set
		 * Will be set to false when the mouse/finger is lifted
		 */
		protected var fHasBegunMovingEntity:Boolean = false;		
		/** @private */
		protected var fMovingObjectInitialPosition:Rectangle = new Rectangle();
		/** @private */
		protected var fMovingEntity:IsoEntity;
		/** @private */
		protected var fCompleteMoveOnTouchEnd:Boolean = false;
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
		internal var RollOverEntity:IsoEntity;
		/** @private */
		private var fValidationFlags:Vector.<int> = new Vector.<int>();
		/** @private */
		public static const VALIDATION_ZOOM:int = 10;
		/** @private */
		public static const VALIDATION_SIZE:int = 11;
		
		//}		
		
		//{ ------------------------ Interaction --------------------------------------------
		/** @private */
		internal final function DispatchInteractiveEvent(e:IsoEntity, event:int):void {
			if (!fDispatchObjectEventsWhenDragging && fIsDragging) {
				return;
			}
			e.$InteractiveEvent(event);
			fOnEntityTouch.dispatch(e, event);
		}		
		/**
		 * Indicates the entities on the scene respond to long press
		 */
		public function get LongPressEnabled():Boolean {
			return fLongPressEnabled;
		}
		/** @private */
		public function set LongPressEnabled(v:Boolean):void {
			fLongPressEnabled = v;
		}		
		/**
		 * Indicates if IsoEntity events will be dispatched while
		 * dragging the scene
		 * @default	false
		 */
		public function get DispatchEventsWhileDragging():Boolean {
			return fDispatchObjectEventsWhenDragging;
		}
		/** @private */
		public function set DispatchEventsWhileDragging(v:Boolean):void {
			fDispatchObjectEventsWhenDragging = v;
		}
		/**
		 * Indicates if dragging the universe is enabled
		 */
		public function get IsDraggingEnabled():Boolean {
			return fIsDraggingEnabled;
		}
		/** @private */
		public function set IsDraggingEnabled(v:Boolean):void {
			fIsDraggingEnabled = v;
		}		
		/**
		 * Dispatched when any Interactive IsoObject is touched
		 *
		 * Expected signature is <code>function(isoEntity:IsoEntity, event:int):void</code>
		 */
		public function get OnEntityTouch():ISignal {
			return fOnEntityTouch;
		}
		/** @private */
		private var fOnEntityTouch:Signal = new Signal(IsoEntity, int);		
		/** @private */
		private var fDispatchObjectEventsWhenDragging:Boolean = false;		
		/** @private */
		protected var fLongPressEnabled:Boolean;
		/** @private */
		private var fIsDragging:Boolean = false;
		/** @private */
		private var fStartDrag:Boolean = false;
		/** @private */
		protected static const TOUCH_HELPER_POINT:Point = new Point();
		protected static const H_POINT_1:Point = new Point();
		/** @private */
		protected static var fDragPt:Point;
		/** @private */
		private var fIsDraggingEnabled:Boolean = true;
		public var LongPressStartTime:int = 250;
		public var LongPressTime:int = 750;
		/**
		 * Minimum amount of pixels in ANY direction
		 * required to begin a drag operation
		 */
		public var DragSensitivity:int = 12;
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