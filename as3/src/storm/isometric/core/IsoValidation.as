/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.isometric.core {
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	/**
	 * @author NSi
	 */
	public class IsoValidation implements IAnimatable {
		//{ ------------------------ Constructors -------------------------------------------
		public function IsoValidation() {
			Instance = this;
			Init();
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		private function Init():void {
			fItems = new Vector.<IIsoValidatable>();
			fDelayedItems = new Vector.<IIsoValidatable>();
		}
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Add an item for validation in the next frame
		 */
		public function Add(item:IIsoValidatable):void {
			if (fIsValidating) {
				if (fDelayedItems.indexOf(item) >= 0) {
					return;
				}
				fDelayedItems.push(item);
			} else {
				if (fItems.indexOf(item) >= 0) {
					return;
				}
				fItems.push(item);
				if (fItems.length == 1) {
					Starling.juggler.add(this);
				}
			}
		}
		/**
		 * Remove an item from the validation list
		 */
		public function Remove(item:IIsoValidatable):void {
			var index:int = fItems.indexOf(item);
			if (index >= 0) {
				fItems.splice(index, 1);
			}
			index = fDelayedItems.indexOf(item);
			if (index >= 0) {
				fDelayedItems.splice(index, 1);
			}
			
		}
		/** @private */
		public function advanceTime(time:Number):void {
			fIsValidating = true;
			for (var i:* in fItems) {
				fItems[i].Validate();
			}
			
			fItems = fDelayedItems.concat();
			fDelayedItems = new Vector.<IIsoValidatable>();
			if (fItems.length == 0) {
				Starling.juggler.remove(this);
			}
			fIsValidating = false;
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		private var fItems:Vector.<IIsoValidatable>;
		/** @private */
		private var fDelayedItems:Vector.<IIsoValidatable>;
		/** @private */
		private var fIsValidating:Boolean = false;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Static -------------------------------------------------
		public static var Instance:IsoValidation = new IsoValidation();
		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}