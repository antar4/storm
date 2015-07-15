/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {

	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * @author 
	 */
	public class IsoLayer extends InternalIsoSprite implements IIsoValidatable {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoLayer(id:String) {
			fId = id;
			fInteractiveObjects = new Vector.<IsoEntity>();
			addChild(HIT_DO);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		internal function $InternalInit(scene:IsoScene):void {
			fScene = scene;
			fEntities = new Vector.<IsoEntity>();
			addEventListener(TouchEvent.TOUCH, HandleOnTouch);
		}
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		internal final function Translate(dx:int, dy:int):void {
			x += dx;
			y += dy;
			Invalidate(VALIDATION_CAMERA);
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Adds an IsoEntity to the layer
		 */
		public function Add(e:IsoEntity):void {
			if (e.Layer != null) {
				throw new ArgumentError("The IsoEntity being added has already been added to a layer");
			}
			fEntities.push(e);
			e.$InternalInit(this);
		}
		/**
		 * Removes an IsoEntity from the layer
		 * @return	true if the entity was removed
		 * @throws ArgumentError if the entity is not a child of the current layer
		 */
		public function Remove(e:IsoEntity, dispose:Boolean = false):Boolean {
			if (e.Layer != this) {
				throw new ArgumentError("The entity is not a child of the layer");
			}
			var index:int = fEntities.indexOf(e);
			if (index >= 0) {
				fEntities.splice(index, 1);
				if (dispose) {
					e.dispose();
				}
				return true;
			}
			return false;
		}
		/**
		 * Returns the entity with the specified id on the layer
		 */
		public function Get(id:String):IsoEntity {
			var e:IsoEntity = IsoEntity.Get(id);
			if (e == null) return null;
			if (e.Layer != this) return null;
			return e;
		}
		override public function dispose():void {
			removeEventListener(TouchEvent.TOUCH, HandleOnTouch);
		}
		//}
		
		//{ ------------------------ Depth Sorting ------------------------------------------
		/** @private */
		protected function SortChildren():void {
			
		}
		//}
		
		//{ ------------------------ Camera -------------------------------------------------
		/**
		 * @private
		 * Validates scale and position
		 */
		protected function ValidateCamera():void {
			/*
			scaleX = scaleY = fScale;
			
			// TODO Optimize
			// universe
			var uW:int = fUniverse.ExplicitWidth;
			var uH:int = fUniverse.ExplicitHeight;
			
			// horizontal
			var sX:int = (x / fScale); // the x location including paddings on the universe canvas
			var sW:int = (ActualWidth + fPaddingRight + fPaddingLeft) * fScale;
			var sPL:int = fPaddingLeft * fScale;
			
			// vertical
			var sY:int = (y / fScale); // the x location including paddings on the universe canvas
			var sH:int = (ActualHeight + fPaddingBottom + fPaddingTop) * fScale;
			var sPT:int = fPaddingTop * fScale;
			
			// horizontal
			if (sW < uW) {
				// center x
				x = ((uW - sW) / 2) + sPL;
			} else {
				// enforce bounds
				if ((sX - fPaddingLeft) > 0) {
					x = sPL;
				} else if (x + sW - sPL < uW) {
					x = uW - sW + sPL;
				}
			}
			
			// vertical
			if (sH < uH) {
				// center y
				y = ((uH - sH) / 2) + sPT;
			} else {
				// enforce bounds
				if ((sY - fPaddingTop) > 0) {
					y = sPT;
				} else if (y + sH - sPT < uH) {
					y = uH - sH + sPT;
				}
			}*/
			Cull();
		}
		/** @private */
		protected function Cull():void {
			var layerBounds:Rectangle = Bounds;
			var b:Rectangle;
			for (var i:* in fEntities) {
				b = fEntities[i].Bounds;
				trace(b);
				if (!RectIntersects(layerBounds, b)) {
					fEntities[i].Culled = true;
				} else {
					fEntities[i].Culled = false;
				}
			}
		}
		[Inline]
		public final function RectIntersects(r1:Rectangle, r2:Rectangle):Boolean {
			return !(r1.bottom < r2.y || r1.y > r2.bottom || r1.right < r2.x || r1.x > r2.right)
		}		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/**
		 * The mode for sorting objects
		 * @see EIsoSortingMode
		 */
		public function get SortMode():int {
			return fSortMode;
		}
		/** @private */
		public function set SortMode(v:int):void {
			fSortMode = v;
			SortChildren();
		}
		/**
		 * The id of the layer
		 */
		public function get Id():String {
			return fId;
		}
		/**
		 * Indicates this layer dispatched touch events
		 */
		public function get Interactive():Boolean {
			return fInteractive;
		}
		/** @private */
		public function set Interactive(v:Boolean):void {
			if (fInteractive == v) return;
			fInteractive = v;
			if (fInteractive) {
				addEventListener(TouchEvent.TOUCH, HandleOnTouch);
			} else {
				removeEventListener(TouchEvent.TOUCH, HandleOnTouch);
			}
		}
		/**
		 * The bounds of the layer
		 */
		public final function get Bounds():Rectangle {
			fBounds.setTo( -x, -y, fScene.ExplicitWidth, fScene.ExplicitHeight);
			return fBounds;
		}
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fScene:IsoScene;
		/** @private */
		protected var fSortMode:int = EIsoSortingMode.BOUNDS_3D;
		/** @private */
		protected var fId:String;
		/** @private */
		private var fEntities:Vector.<IsoEntity>;
		/** @private */
		protected var fInteractive:Boolean = true;
		/** @private */
		private var fBounds:Rectangle = new Rectangle();
		//}
		
		//{ ------------------------ Math ---------------------------------------------------
		/**
		 * Returns iso coordinates for the provided screen coordinates
		 */
		public final function ScreenToIso(screenX:int, screenY:int, isoP:Point = null):Point {
			if (isoP == null) {
				isoP = new Point();
			}
			screenX -= x;
			screenY -= y;
			IsoMath.ScreenToIso(screenX, screenY, isoP);
			return isoP;
		}
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Mouse Interaction --------------------------------------
		/**
		 * Locks all interaction with the layer, except for the specified entity
		 */
		public function LockTouch(exclude:IsoEntity = null):void {
			fIsTouchLocked = true;
			fExcludeFromTouchLock = exclude;
		}
		/**
		 * Resumes all interaction with the layer
		 */
		public function UnlockTouch():void {
			fExcludeFromTouchLock = null;
			fIsTouchLocked = false;
		}
		/** @private */
		private function HandleOnTouch(e:TouchEvent):void {
			var t:IsoHDO = e.target as IsoHDO;
			if (!t) return;
			var touch:Touch = e.getTouch(t);
			if (!touch) {
				if (fScene.RollOverEntity != null) {
					DispatchInteractiveEvent(fScene.RollOverEntity, EIsoInteractiveEvents.ROLLOUT);
					fScene.RollOverEntity = null;
				}
				return;
			}
			
			var isoEntity:IsoEntity = t.Target as IsoEntity;
			if (isoEntity == null) {
				return;
			}
			
			var phase:String = touch.phase;
			var rollOverEntity:IsoEntity;
			if (phase == TouchPhase.HOVER) {
				rollOverEntity = fScene.RollOverEntity;
				if (rollOverEntity == isoEntity) {
					// already in rollover - ignore
					return;
				} else {
					if (rollOverEntity != null) {
						DispatchInteractiveEvent(rollOverEntity, EIsoInteractiveEvents.ROLLOUT);
					} 
					fScene.RollOverEntity = rollOverEntity = isoEntity;
					DispatchInteractiveEvent(rollOverEntity, EIsoInteractiveEvents.ROLLOVER);
				}
			} else if (phase == TouchPhase.BEGAN) {
				DispatchInteractiveEvent(isoEntity, EIsoInteractiveEvents.PRESS);
				fLongPressTimeout = setTimeout(DispatchInteractiveEvent, fScene.LongPressTime, isoEntity, EIsoInteractiveEvents.LONG_PRESS);
				fLongPressStartTimeout = setTimeout(DispatchInteractiveEvent, fScene.LongPressStartTime, isoEntity, EIsoInteractiveEvents.LONG_PRESS_START);				
			} else if (phase == TouchPhase.ENDED) {
				DispatchInteractiveEvent(isoEntity, EIsoInteractiveEvents.RELEASE);
			} else if (phase == TouchPhase.MOVED) {
				touch.getLocation(this, H_POINT);
				t = hitTest(H_POINT) as IsoHDO;
				if (t) {
					isoEntity = t.Target as IsoEntity;
					if (isoEntity != null) {
						rollOverEntity = fScene.RollOverEntity;
						if (rollOverEntity != isoEntity) {
							DispatchInteractiveEvent(rollOverEntity, EIsoInteractiveEvents.ROLLOUT);
							DispatchInteractiveEvent(rollOverEntity, EIsoInteractiveEvents.RELEASE);
						}
						fScene.RollOverEntity = rollOverEntity = isoEntity;
						DispatchInteractiveEvent(rollOverEntity, EIsoInteractiveEvents.ROLLOUT);
						DispatchInteractiveEvent(rollOverEntity, EIsoInteractiveEvents.RELEASE);
					}
				}
			}
		}	
		/** @inheritDoc */
		override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject {
			if (!fInteractive) return null;
			
			if (fIsTouchLocked) {
				if (fExcludeFromTouchLock != null) {
					if (fExcludeFromTouchLock.hitTest(localPoint)) {
						HIT_DO.Target = fExcludeFromTouchLock;
						return HIT_DO;
					}
				}
				return null;
			}
			
			var l:int = fInteractiveObjects.length;
			var e:IsoEntity;
			for (var i:int = l-1; i >=0; i--) {
				e = fInteractiveObjects[i];
				if (e.hitTest(localPoint)) {
					HIT_DO.Target = e;
					return HIT_DO;
				}
			}
			
			return null;
		}
		/** @private */
		internal final function SetEntityInteractive(e:IsoEntity, isInteractive:Boolean):void {
			var index:int = fInteractiveObjects.indexOf(e);
			if (isInteractive && index == -1) {
				fInteractiveObjects.push(e);
			} else if (!isInteractive && index >= 0) {
				fInteractiveObjects.splice(index, 1);
			}
		}
		/** @private */
		private final function DispatchInteractiveEvent(e:IsoEntity, event:int):void {
			if (event != EIsoInteractiveEvents.LONG_PRESS_START) {
				clearTimeout(fLongPressTimeout);
			}
			clearTimeout(fLongPressStartTimeout);
			if (event == EIsoInteractiveEvents.LONG_PRESS && !fScene.LongPressEnabled) {
				return;
			}
			fScene.DispatchInteractiveEvent(e, event);
		}		
		
		/** @private */
		protected var fInteractiveObjects:Vector.<IsoEntity>;
		/** @private */
		private var fIsTouchLocked:Boolean;
		/** @private */
		private var fExcludeFromTouchLock:IsoEntity;
		/** @private */
		private var fLongPressTimeout:uint = 0;
		/** @private */
		private var fLongPressStartTimeout:uint = 0;		
		/** @private */
		protected const HIT_DO:IsoHDO = new IsoHDO();
		/** @private */
		protected const H_POINT:Point = new Point();
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
					case VALIDATION_CAMERA: 
						ValidateCamera();
						break;
					case VALIDATION_SORTING: 
						SortChildren();
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
		protected static const VALIDATION_CAMERA:int = 10;
		/** @private */
		protected static const VALIDATION_SORTING:int = 11;
		//}		
		
		//{ ------------------------ Static -------------------------------------------------

		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}