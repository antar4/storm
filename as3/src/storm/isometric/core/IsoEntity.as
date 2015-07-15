/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import starling.display.DisplayObject;
	import starling.display.Graphics;
	import starling.display.Shape;
	/**
	 * @author 
	 */
	public class IsoEntity implements IIsoValidatable {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoEntity(id:String, _width:int, _length:int, _height:int) {
			if (id == null) {
				throw new ArgumentError("The id for an IsoEntity cannot be null");
			}
			if (EntityHash[id] != null) {
				throw new ArgumentError("An IsoEntity with the same id=" + id + " already exists");
			}
			fSize3D = new IsoPoint(_width, _length, _height);
			// translate z so all objects are placed on the floor
			fIsoLocation = new IsoPoint(0, 0, 0);
			fId = id;
			EntityHash[id] = this;
			fChildren = new Vector.<IsoDisplayObject>();
			fBounds = new Rectangle();
			Invalidate(VALIDATION_POSITION, VALIDATION_RENDER, VALIDATION_VISIBLE);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		internal function $InternalInit(layer:IsoLayer):void {
			fLayer = layer;
			fLayer.SetEntityInteractive(this, fIsInteractive);
			var c:Shape = RenderIsoBox();
			addChild("#isobox", c, 0, 0, false);
			CreateChildren();
		}
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		protected function CreateChildren():void {
			var d:DisplayObject;
			var ido:IsoDisplayObject;
			var p:Point = ScreenPt;
			for (var i:* in fChildren) {
				ido = fChildren[i];
				d = ido.DO;
				if (!d.stage) {
					fLayer.addChild(d);
					d.x = p.x + ido.fOffsetX;
					d.y = p.y + ido.fOffsetY;			
				}
			}
		}
		/** @private */
		protected function ValidatePosition():void {
			var p:Point = ScreenPt;
			var d:DisplayObject;
			var ido:IsoDisplayObject;			
			for (var i:* in fChildren) {
				ido = fChildren[i];
				d = ido.DO;
				if (d.stage) {
					d.x = p.x + ido.fOffsetX;
					d.y = p.y + ido.fOffsetY;			
				}
			}
			Render();
		}
		/** @private */
		protected function Render():void {
			var r:Rectangle;
			var ido:IsoDisplayObject;
			
			var bot:int = -999999;
			var right:int = -999999;
			var left:int = 999999;
			var top:int = 999999;
			
			for (var i:* in fChildren) {
				ido = fChildren[i];
				if (ido.IncludeInBounds) {
					r = ido.Bounds;
					
					if (r.x < left) {
						left = r.x;
					}
					if (r.y < top) {
						top = r.y;
					}
					if (r.right > right) {
						right = r.right;
					}
					if (r.bottom > bot) {
						bot = r.bottom;
					}
				}
				
			}
			H_RECT.setTo(left, top, right - left, bot - top);
			if (!H_RECT.equals(fBounds)) {
				fBounds.setTo(left, top, right - left, bot - top);
				trace(fId + "=>" + fBounds);
				$OnBoundsChanged();
			}			
		}
		/** @private */
		protected function ValidateVisible():void {
			for (var i:* in fChildren) {
				var v:Boolean = !fCulled && fVisible;
				fChildren[i].visible = v;
			}
		}
		/** @private */
		internal function $BeginMove():void {
		}
		internal function $CompleteMove():void {
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Destroys any references this entity holds
		 */
		public function dispose():void {
			
		}
		/**
		 * Adds a display object on the entity
		 * @param	id				a unique id for the display object
		 * @param	d				the display object to add
		 * @param	offsetX			x offset from the registration point of the entity (top)
		 * @param	offsetY			y offset from the registration point of the entity (top)
		 * @param	includeInBounds	if true the display object is calculated to identify bounds and will trigger touch events
		 * @return a reference to the IsoDisplayObject that is created
		 */
		public function addChild(id:String, d:DisplayObject, offsetX:int, offsetY:int, includeInBounds:Boolean = true):IsoDisplayObject {
			var ido:IsoDisplayObject = new IsoDisplayObject(id, d, offsetX, offsetY, includeInBounds);
			fChildren.push(ido);
			var p:Point = ScreenPt;
			d.x = p.x + offsetX;
			d.y = p.y + offsetY;
			if (fLayer!=null) {
				fLayer.addChild(d);
			}
			Invalidate(VALIDATION_RENDER, VALIDATION_VISIBLE);
			return ido;
		}
		/**
		 * Removes the entity from it's parent layer
		 */
		public function Remove(dispose:Boolean = true):void {
			if (fLayer != null) {
				fLayer.Remove(this, dispose);
			}
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/**
		 * The unique Id of the entity
		 */
		public function get Id():String {
			return fId;
		}
		/**
		 * An arbitrary category for the entity. 
		 */
		public function get Category():String {
			return fCategory;
		}
		/** @private */
		public function set Category(v:String):void {
			fCategory = v;
		}
		/**
		 * The IsoEntity is entity is child of
		 */
		public function get Layer():IsoLayer {
			return fLayer;
		}
		[Inline]
		public final function get Bounds():Rectangle {
			return fBounds;
		}
		/**
		 * The isometric location of the object along the X axis
		 */
		public final function get IsoX():int {
			return fIsoLocation.x;
		}
		/** @private */
		public function set IsoX(v:int):void {
			fIsoLocation.x = v;
			fScreenPtCache = null;
			Invalidate(VALIDATION_POSITION);
		}
		/**
		 * The isometric location of the object along the Y axis
		 */
		public final function get IsoY():int {
			return fIsoLocation.y;
		}
		/** @private */
		public function set IsoY(v:int):void {
			fIsoLocation.y = v;
			fScreenPtCache = null;
			Invalidate(VALIDATION_POSITION);
		}
		/**
		 * The isometric location of the object along the Z axis
		 */
		public final function get IsoZ():int {
			return fIsoLocation.z;
		}
		/** @private */
		public function set IsoZ(v:int):void {
			fIsoLocation.z = v;
			fScreenPtCache = null;
			Invalidate(VALIDATION_POSITION);
		}
		/**
		 * The isometric location of the object 
		 */
		public function get IsoLocation():IsoPoint {
			return fIsoLocation;
		}
		/** @private */
		public function set IsoLocation(v:IsoPoint):void {
			fIsoLocation = v;
		}
		/** @private */
		public function get ScreenPt():Point {
			if (fScreenPtCache == null) {
				fScreenPtCache = fIsoLocation.ToIso();
			}
			return fScreenPtCache;
		}
		/**
		 * The object is outside of the visible area
		 */
		public function get Culled():Boolean {
			return fCulled;
		}
		/** @private */
		public function set Culled(v:Boolean):void {
			if (fCulled == v) return;
			fCulled = v;
			Invalidate(VALIDATION_VISIBLE);
		}
		public function get visible():Boolean {
			return fVisible;
		}
		/** @private */
		public function set visible(v:Boolean):void {
			if (fVisible == v) return;
			Invalidate(VALIDATION_VISIBLE);
			fVisible = v;
		}
		public function get Children():Vector.<IsoDisplayObject> {
			return fChildren;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fId:String;
		/** @private */
		protected var fCategory:String;
		/** @private */
		protected var fLayer:IsoLayer;
		/** @private */
		protected var fSize3D:IsoPoint;
		/** @private */
		protected var fIsoLocation:IsoPoint;
		/** @private */
		protected var fChildren:Vector.<IsoDisplayObject>;
		/** @private */
		protected var fScreenPtCache:Point;
		/** @private */
		protected var fBounds:Rectangle;
		/** @private */
		protected var fCulled:Boolean;
		/** @private */
		protected var fVisible:Boolean = true;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		private function $OnBoundsChanged():void {
			trace("$Bounds=" + fBounds);
		}
		//}
		
		//{ ------------------------ Interaction --------------------------------------------
		/** @private */
		internal final function $InteractiveEvent(event:int):void {
			if (event == EIsoInteractiveEvents.ROLLOVER) {
				fIsRollOver = true;
			} else  if (event == EIsoInteractiveEvents.ROLLOUT) {
				fIsRollOver = false;
			}
			$OnTouch(event);
			EmitOnTouch(event);
		}
		/** @private */
		protected function $OnTouch(event:int):void {
			
		}
		/**
		 * Dispatched when the object is touched
		 * 
		 * Expected signature is <code>function(e:IsoEntity, event:int):void</code>
		 */
		public function get OnTouch():ISignal {
			if (fOnTouch == null) {
				fOnTouch = new Signal(IsoEntity, int);
			}
			return fOnTouch;
		}
		/** @private */
		private function EmitOnTouch(event:int):void {
			if (fOnTouch == null) return;
			fOnTouch.dispatch(this, event);
		}
		/** @private */
		private var fOnTouch:Signal;		
		/** @private */
		internal function hitTest(p:Point):Boolean {
			trace(p);
			if (!Bounds.containsPoint(p)) return false;
			for (var i:* in fChildren) {
				if (fChildren[i].hitTest(p)) {
					return true;
				}
			}
			return false;
		}
		/**
		 * Indicates the mouse is over the object
		 */
		public function get IsRollOver():Boolean {
			return fIsRollOver;
		}		
		/**
		 * Indicates if the entity dispatched in touch events
		 */
		public function get IsInteractive():Boolean {
			return fIsInteractive;
		}
		/** @private */
		public function set IsInteractive(v:Boolean):void {
			if (fIsInteractive == v) return;
			fIsInteractive = v;
			if (fLayer) {
				fLayer.SetEntityInteractive(this, fIsInteractive);
			}			
		}
		protected var fIsRollOver:Boolean;
		/** @private */
		protected var fIsInteractive:Boolean;
		//}
		
		//{ ------------------------ Bounds -------------------------------------------------
		/**
		 * Returns the iso bounds of the entity
		 */
		public function get IsoBounds():Polygon2d {
			if (fIsoBoundsDirty) {
				fIsoBounds = CalculateLocalIsoBounds();
			}
			fIsoBoundsDirty = false;
			return fIsoBounds;
		}
		/** @private */
		private function CalculateLocalIsoBounds():Polygon2d {
			return fSize3D.IsoBounds;
		}
		/** @private */
		private var fIsoBoundsDirty:Boolean = true;
		/** @private */
		protected var fIsoBounds:Polygon2d;
		//}
		
		//{ ------------------------ Render -------------------------------------------------
		private function RenderIsoBox():Shape {
			var s:IsoPoint = fSize3D;
			var zp:Point = IsoMath.ToIso(0, 0, 0, H_POINT);
			
			
			// axis
			var xl1:Point = IsoMath.ToIso(   0, s.y2, s.z2);
			var xl2:Point = IsoMath.ToIso( s.x, s.y2, s.z2);
			var xl3:Point = IsoMath.ToIso(s.x2,    0, s.z2);
			var xl4:Point = IsoMath.ToIso(s.x2,  s.y, s.z2);
			var xl5:Point = IsoMath.ToIso(s.x2, s.y2, 0);
			var xl6:Point = IsoMath.ToIso(s.x2, s.y2, s.z);
			
			// bottom face
			var bf1:Point = zp;
			var bf2:Point = IsoMath.ToIso(s.x,   0, 0);
			var bf3:Point = IsoMath.ToIso(s.x, s.y, 0);
			var bf4:Point = IsoMath.ToIso(  0, s.y, 0);
			
			
			// top face
			var tf1:Point = IsoMath.ToIso(  0,   0, s.z);
			var tf2:Point = IsoMath.ToIso(s.x,   0, s.z);
			var tf3:Point = IsoMath.ToIso(s.x, s.y, s.z);			
			var tf4:Point = IsoMath.ToIso(  0, s.y, s.z);			
			
			var r:Shape = new Shape();
			var g:Graphics = r.graphics;
			g.clear();
			
			g.lineStyle(1, 0xFF0000);
			g.moveTo(xl1.x, xl1.y);
			g.lineTo(xl2.x, xl2.y);
			
			g.lineStyle(1, 0x00FF00);
			g.moveTo(xl3.x, xl3.y);
			g.lineTo(xl4.x, xl4.y);			
			
			g.lineStyle(1, 0x0000FF);
			g.moveTo(xl5.x, xl5.y);
			g.lineTo(xl6.x, xl6.y);	
			
			g.lineStyle(1, 0x400080);
			
			var a:Number = 0.4;
			
			// left face
			g.beginFill(0x2BBAFF, a);
			g.moveTo(bf3.x, bf3.y);
			g.lineTo(bf4.x, bf4.y);
			g.lineTo(tf4.x, tf4.y);
			g.lineTo(tf3.x, tf3.y);
			g.lineTo(bf3.x, bf3.y);
			g.endFill();
			
			// right face
			g.beginFill(0x006595, a);
			g.moveTo(bf3.x, bf3.y);
			g.lineTo(bf2.x, bf2.y);
			g.lineTo(tf2.x, tf2.y);
			g.lineTo(tf3.x, tf3.y);
			g.lineTo(bf3.x, bf3.y);
			g.endFill();
			
			// top face
			g.beginFill(0x55C8FF, a);
			g.moveTo(tf1.x, tf1.y);
			g.lineTo(tf2.x, tf2.y);
			g.lineTo(tf3.x, tf3.y);
			g.lineTo(tf4.x, tf4.y);
			g.lineTo(tf1.x, tf1.y);
			g.endFill();			
			
			
			return r;
		}
		//}

		//{ ------------------------ Validation ---------------------------------------------
		/** @private */
		public function Invalidate(... rest:Array):void {
			var flag:int;
			var invalidate:Boolean = false;
			for (var i:* in rest) {
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
			// position should ALWAYS be validated FIRST
			if (fValidationFlags.indexOf(VALIDATION_POSITION) >= 0) {
				ValidatePosition();
			}
			for (var i:* in fValidationFlags) {
				flag = fValidationFlags[i];
				switch (flag) {
					case VALIDATION_RENDER:
						Render();
						break;
					case VALIDATION_VISIBLE:
						ValidateVisible();
						break;
				}
			}
			fValidationFlags = new Vector.<int>();
		}
		

		public function get IsInvalid():Boolean {
			return fValidationFlags.length > 0;
		}
		/** @private */
		protected var fValidationFlags:Vector.<int> = new Vector.<int>();
		/** @private */
		public static const VALIDATION_RENDER:int = 10;
		/** @private */
		public static const VALIDATION_POSITION:int = 11;
		/** @private */
		public static const VALIDATION_VISIBLE:int = 12;
		//}				
		//}
		
		
		//{ ------------------------ Static -------------------------------------------------
		/** @private */
		protected static var EntityHash:Dictionary = new Dictionary();
		/**
		 * Returns the IsoEntity with the specified id, null if it does not exist
		 */
		public static function Get(id:String):IsoEntity {
			return EntityHash[id];
		}
		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
		
		//{ ------------------------ Helpers ------------------------------------------------
		protected static const H_POLY:Polygon2d = new Polygon2d();
		protected static const H_POINT:Point = new Point();
		protected static const H_RECT:Rectangle = new Rectangle();		
		//}
		
	}

}