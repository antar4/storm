/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package storm.core.operation {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import storm.core.error.NotImplementedError;
	/**
	 * @author 
	 */
	public class LoadOperation extends AsyncOperation {
		//{ ------------------------ Constructors -------------------------------------------
		public function LoadOperation(url:String, retries:int = 3) {
			fMaxRetries = retries;
			fUrl = url;
			super(url);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		override protected function Init():void {	
			fStatus = EOperationStatus.IDLE;
		}
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		/** @private */
		protected function Retry(e:IOErrorEvent):void {
			throw new NotImplementedError("LoadOperation.Retry is not implemented");
		}
		/** @private */
		private function disposeInternal():void {
			if (fUrlLoader != null) {
				fUrlLoader.removeEventListener(Event.COMPLETE, HandleOnUrlLoaderComplete, false);
				fUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, HandleOnUrlLoaderError, false);
				fUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, HandleOnUrlLoaderSecurityError, false);
				fUrlLoader.removeEventListener(ProgressEvent.PROGRESS, HandleOnUrlLoaderProgress, false);	
				try {
					fUrlLoader.close();
				} catch (e:Error) { };
				fUrlLoader = null;
			}
		}
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/** @inheritDoc */
		override public function Execute():Boolean {
			if (fStatus != EOperationStatus.IDLE) {
				return false;
			}
			Status = EOperationStatus.IN_PROGRESS;
			fURLLoader = new URLLoader();
			fURLLoader.dataFormat = URLLoaderDataFormat.BINARY;
			fURLLoader.addEventListener(ProgressEvent.PROGRESS, HandleOnUrlLoaderProgress, false, 0, true);
			fURLLoader.addEventListener(Event.COMPLETE, HandleOnUrlLoaderComplete, false, 0, true);
			fURLLoader.addEventListener(IOErrorEvent.IO_ERROR, HandleOnUrlLoaderError, false, 0, true);
			fURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, HandleOnUrlLoaderSecurityError, false, 0, true);	
			fUrlLoader.load(new URLRequest(fUrl));			
		}
		/** @inheritDoc */
		override public function Cancel():Boolean {
			Status = EOperationStatus.CANCELLED;
			DispatchComplete();
			disposeInternal();
		}
		/** @inheritDoc */
		override public function dispose():void {
			disposeInternal();
			super.dispose();
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/** @inheritDoc */
		override public function get Progress():Number {
			return fProgress;
		}
		/** @inheritDoc */
		public function get Url():String {
			return fUrl
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		protected var fUrl:String;
		/** @private */
		protected var fUrlLoader:URLLoader;
		/** @private */
		protected var fProgress:Number;
		/** @private */
		protected var fMaxRetries:int;
		//}

		//{ ------------------------ Event Handlers -----------------------------------------
		/** @private */
		private function HandleOnUrlLoaderError(e:IOErrorEvent):void {
			Retry(e);
		}
		/** @private */
		private function HandleOnUrlLoaderSecurityError(e:SecurityErrorEvent):void {
			$Fail("SecurityError=" + e.text);
			disposeInternal();
		}
		/** @private */
		private function HandleOnUrlLoaderProgress(e:ProgressEvent):void {
			fProgress = e.bytesTotal == 0 ? 1 : e.bytesLoaded / e.bytesTotal;
			DispatchProgress(fProgress);
		}	
		/** @private */
		private function HandleOnUrlLoaderComplete(e:Event):void {		
			$Complete(fUrlLoader.data as ByteArray);
			disposeInternal();
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