/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import starling.display.Graphics;
	import starling.display.Shape;
	/**
	 * @author 
	 */
	public class IsoEntity {
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
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		internal function $InternalInit(layer:IsoLayer):void {
			fLayer = layer;
			c = RenderIsoBox();
			var p:Point = fIsoLocation.ToIso();
			if (c!=null) {
				c.x = p.x;
				c.y = p.y;
			}			
			fLayer.addChild(c);
			
			
		}
		private var c:Shape;
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Destroys any references this entity holds
		 */
		public function dispose():void {
			
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
			return null;
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
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
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
		internal static const H_POLY:Polygon2d = new Polygon2d();
		internal static const H_POINT:Point = new Point();
		//}
		
	}

}