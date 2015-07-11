/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package perf.callbackPerf {
	import flash.utils.setTimeout;
	import perf.PerformanceTestBase;
	import perf.PerfTestResult;
	/**
	 * @author 
	 */
	public class CallbackPerf extends PerformanceTestBase {
		//{ ------------------------ Constructors -------------------------------------------
		public function CallbackPerf() {
			
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		override protected function Init():void {
			setTimeout(Test, 1000);
		}
		private function Test():void {
			var r:PerfTestResult;
			
			const iterations:int = 10 * 1000 * 1000;
			var runnable:Runnable = new MyRunnable();
			var f:Function = runnable.run;
			var i:int;
			
			BeginTest();
			for (i = 0; i < iterations; i++) {
				f();
			}
			r = StopTest();
			LogCounter("Function Ref", "f", r.Time, iterations);
			BeginTest();
			for (i = 0; i < iterations; i++) {
				runnable.run();
			}
			r = StopTest();
			LogCounter("Runnable", "f", r.Time, iterations);
			BeginTest();
			for (i = 0; i < iterations; i++) {
				foo();
			}
			r = StopTest();
			LogCounter("Direct", "f", r.Time, iterations);			
			
			
			CreateChart();
		}		
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		[Inline]
		protected static function foo():void {
			
		}
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		
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
	internal interface Runnable {
		function run(): void
	}
	internal class MyRunnable implements Runnable {
		public function run(): void {
		}
	}	