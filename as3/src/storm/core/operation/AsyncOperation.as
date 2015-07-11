/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.core.operation {
	import flash.utils.ByteArray;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import storm.core.error.NotImplementedError;
	/**
	 * Basic implementation if IAsyncOperation
	 * @author 
	 */
	public class AsyncOperation extends Operation implements IAsynOperation {
		//{ ------------------------ Constructors -------------------------------------------
		public function AsyncOperation(id:String) {
			super(id);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------

		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		protected function $Complete(data:ByteArray):void {
			fRawData = data;
			Status = EOperationStatus.COMPLETE;
			DispatchComplete();
		}
		/** @private */
		protected function $Fail(error:String):void {
			fStatus = EOperationStatus.FAILED;
			fRawData = null;
			DispatchError(error);
			DispatchComplete();
		}		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/** @inheritDoc */
		public function Cancel():Boolean {
			Status = EOperationStatus.CANCELLED;
			DispatchComplete();
		}
		/** @private */
		override public function dispose():void {
			fRawData = null;
			if (fOnComplete != null) {
				fOnComplete.removeAll();
				fOnComplete = null;
			}
			if (fOnProgress != null) {
				fOnProgress.removeAll();
				fOnProgress = null;
			}
			if (fOnStatusChanged != null) {
				fOnStatusChanged.removeAll();
				fOnStatusChanged = null;
			}
			if (fOnError != null) {
				fOnError.removeAll();
				fOnError = null;
			}
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @inheritDoc */
		public function get Progress():Number {
			throw new NotImplementedError("AsyncOperation.Progress is NOT implemented, Override in subclass");
		}

		/** @inheritDoc */
		override public function set Status(value:int):void {
			if (fStatus == v) return;
			fStatus = value;
			DispatchStatusChanged(fStatus);
		}
		
		/** @inheritDoc */
		public function get RawData():ByteArray {
			return fRawData;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fRawData:ByteArray;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		
		//}

		//{ ------------------------ Events -------------------------------------------------
		/** @private */
		protected final function DispatchProgress(progress:Number):void {
			if (fOnProgress == null) return;
			fOnProgress.dispatch(this, progress);
		}
		/** @inheritDoc */
		public final function get OnProgress():ISignal {
			if (fOnProgress == null) {
				fOnProgress = new Signal(IAsynOperation, Number, int, int);
			}
			return fOnProgress;
		}
		/** @private */
		protected var fOnProgress:Signal;
		
		/** @private */
		protected final function DispatchComplete():void {
			if (fOnComplete == null) return;
			fOnComplete.dispatch();
		}
		/** @inheritDoc */
		public final function get OnComplete():ISignal {
			if (fOnComplete == null) {
				fOnComplete = new Signal(IAsynOperation);
			}
			return fOnComplete;
		}
		/** @private */
		protected var fOnComplete:Signal;		
		
		/** @private */
		protected final function DispatchStatusChanged(status:int):void {
			if (fOnStatusChanged == null) return;
			fOnStatusChanged.dispatch(status);
		}
		/** @inheritDoc */
		public final function get OnStatusChanged():ISignal {
			if (fOnStatusChanged == null) {
				fOnStatusChanged = new Signal(IAsynOperation, int);
			}
			return fOnStatusChanged;
		}
		/** @private */
		protected var fOnStatusChanged:Signal;	
		
		/** @private */
		protected final function DispatchError(error:String):void {
			if (fOnError == null) return;
			fOnError.dispatch(error);
		}
		/** @inheritDoc */
		public final function get OnError():ISignal {
			if (fOnError == null) {
				fOnError = new Signal(IAsynOperation, String);
			}
			return fOnError;
		}
		/** @private */
		protected var fOnError:Signal;		
		//}
		
		//{ ------------------------ Static -------------------------------------------------

		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}