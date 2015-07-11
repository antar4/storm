/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {

	import starling.display.Sprite;
	import starling.events.TouchEvent;
	/**
	 * @author 
	 */
	public class IsoLayer extends InternalIsoSprite {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoLayer(id:String) {
			fId = id;
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		internal function $InternalInit(scene:IsoScene):void {
			fScene = scene;
			fEntities = new Vector.<IsoEntity>();
			addEventListener(TouchEvent.TOUCH, HandleOnTouch);
			//pivotX = -fScene.ExplicitWidth / 2;
			//pivotY = -fScene.ExplicitHeight / 2;
		}
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
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
		//}
		
		//{ ------------------------ Depth Sorting ------------------------------------------
		/** @private */
		protected function SortChildren():void {
			
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
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Mouse Interaction --------------------------------------
		private function HandleOnTouch(e:TouchEvent):void {
			
		}		
		//}
		
		//{ ------------------------ Static -------------------------------------------------

		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}