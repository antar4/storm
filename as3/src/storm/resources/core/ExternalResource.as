/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.resources.core {
	import storm.core.operation.IAsynOperation;
	import storm.core.operation.LoadOperation;
	/**
	 * @author 
	 */
	public class ExternalResource extends Resource implements IExternalResource {
		//{ ------------------------ Constructors -------------------------------------------
		/**
		 * Creates a new external resource
		 * @param	url				the url to load the resource from. if NO id is supplied, the url is used as id
		 * @param	consumer		the default consumer for the resource. not providing a consumer with cachePolicy VOLATILE or NONE will cause the operation to fail
		 * @param	priority		a number between 0 and 10 indicating the loading priority of the resource
		 * @param	cachePolicy		the policy used to cache the resource, @see EResourceCachePolicy
		 * @param	id				an optional id. if not supplied url is used instead
		 * @param	retries			the number of times to retry when an IOError occurs during loading
		 */
		public function ExternalResource(url:String, consumer:IResourceConsumer, priority:int = 5, cachePolicy:int = EResourceCachePolicy.VOLATILE, id:String = null, retries:int = 3) {
			const _id:String = id == null ? url : id;
			fUrl = url;
			fPriority = priority;
			fCachePolicy = cachePolicy;
			fRetries = retries;
			super(_id, consumer);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/** @inheritDoc */
		public function Load():IAsynOperation {
			if (fLoadOperation == null) {
				fLoadOperation = new LoadOperation(fUrl, fRetries);
				fLoadOperation.OnComplete.addOnce(HandleOnLoadComplete);
				fLoadOperation.Execute();
			}
			return fLoadOperation;
		}
		/** @inheritDoc */
		public function Cancel():Boolean {
			if (fStatus == EResourceStatus.LOADING) {
				return fLoadOperation.Cancel();
			} else if (fStatus == EResourceStatus.PARSING) {
				return true;
			}
			return false;
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @inheritDoc */
		public function get Url():String {
			return fUrl;
		}
		
		/** @inheritDoc */
		public function get CachePolicy():int {
			return fCachePolicy;
		}
		
		/** @inheritDoc */
		public function get Priority():int {
			return fPriority;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fPriority:int;
		/** @private */
		protected var fCachePolicy:int;
		/** @private */
		protected var fUrl:String;
		/** @private */
		protected var fLoadOperation:LoadOperation;
		/** @private */
		protected var fRetries:int;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		/** @private */
		private function HandleOnLoadComplete(loadOperation:LoadOperation):void {
			
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