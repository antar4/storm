/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.resources.core {
	import flash.utils.Dictionary;
	import storm.core.error.NotImplementedError;
	/**
	 * Basic implementation of the IResource interface
	 * @author 
	 */
	public class Resource extends IResource {
		//{ ------------------------ Constructors -------------------------------------------
		/**
		 * Creates a new Resource
		 * @param	id				a unique id to identify the resource. matching ids will overwrite the existing resources
		 * @param	consumer		a consumer to be used by this resource
		*/
		public function Resource(id:String, consumer:IResourceConsumer = null) {
			fId = id;
			fStatus = EResourceStatus.NA;
			fConsumers = new Dictionary(true);
			if (consumer != null) {
				AddConsumer(consumer);
			}
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		internal function __gc():void {
			throw new NotImplementedError("__gc not implemented");
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/** @inheritDoc */
		public function AddConsumer(consumer:IResourceConsumer):void {
			if (consumer == null) return;
			fConsumers[consumer] = true;
		}
		
		/** @inheritDoc */
		public function RemoveConsumer(consumer:IResourceConsumer):void {
			if (consumer == null) return;
			delete(fConsumers[consumer]);
			__gc();
		}
		
		/** @inheritDoc */
		public function RefreshConsumer(consumer:IResourceConsumer):Boolean {
			if (consumer == null) return false;
			if (fConsumers[consumer] == true) {
				consumer.$OnResourceChanged(this);
				return true;
			}
			return false;
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @inheritDoc */
		public function get Id():String {
			return fId;
		}
		
		/** @inheritDoc */
		public function get Status():int {
			return fStatus;
		}
		
		/** @inheritDoc */
		public function get Consumers():Vector.<IResourceConsumer> {
			var v:Vector.<IResourceConsumer> = new Vector.<IResourceConsumer>();
			for (var i:* in fConsumers) {
				if (i != null) {
					v.push(i);
				}
			}
			return v;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fId:String;
		/** @private */
		protected var fCachePolicy:int;
		/** @private */
		protected var fStatus:int;
		/** @private */
		protected var fConsumers:Dictionary;
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