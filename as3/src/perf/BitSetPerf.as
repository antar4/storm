/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by  for NSiFor Holding LTD
 */
package perf {
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	import storm.data.binary.BitSet;
	
	/**
	 * @author
	 */
	public class BitSetPerf extends PerformanceTestBase {
		//{ ------------------------ Constructors -------------------------------------------
		public function BitSetPerf() {
			PerfGraphItem.NUMBER_OF_COLORS_TO_USE = 2;
		}
		//}
		
		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		override protected function Init():void {
			setTimeout(Test, 1000);
		}
		private function Test():void {
			LogHeader("Vector");
			TestVectorAdd();
			TestVectorGet();			

			LogHeader("BitSet");
			TestBitSetAdd();
			TestBitSetGet();	
			
			CreateChart();
		}
		//}
		
		//{ ------------------------ BitSet -------------------------------------------------
		/** @private */
		private function TestBitSetAdd():void {
			var r:PerfTestResult;
			var bs:BitSet = new BitSet();
			var i:int = 0;
			BeginTest();
			for (i; i < ITERATIONS_ADD; i++) {
				bs.Add1(true);
			}
			r = StopTest();
			LogCounter("ADD", "BitSet", r.Time, ITERATIONS_ADD);
			LogCounter("Memory", "BitSet", int(r.Mem/1024), 0, null, "Kbytes");
			
			
			bs = new BitSet();
			i = 0;
			bs.Resize(ITERATIONS_ADD);
			BeginTest();
			for (i; i < ITERATIONS_ADD; i++) {
				bs.Add1(true);
			}
			r = StopTest();
			LogCounter("ADD", "BitSet", r.Time, ITERATIONS_ADD, "Init Size");
		}
		/** @private */
		private function TestBitSetGet():void {
			var r:PerfTestResult;
			var bs:BitSet = new BitSet();
			var i:int = 0;
			for (i; i < ITERATIONS_ADD; i++) {
				bs.Add1(true);
			}
			
			var _r:Boolean;
			BeginTest();
			for (var j:int = 0; j < ITERATIONS_GET; j++) {
				i = 0;
				for (i; i < ITERATIONS_ADD; i++) {
					_r = bs.Get1Pos(i);
				}
			}
			r = StopTest();
			LogCounter("GET", "BitSet", r.Time, ITERATIONS_ADD * ITERATIONS_GET);
		}
		
		//}
		
		//{ ------------------------ Vector -------------------------------------------------
		/** @private */
		private function TestVectorAdd():void {
			var r:PerfTestResult;
			var v:Vector.<Boolean> = new Vector.<Boolean>();
			var i:int = 0;
			BeginTest();
			for (i; i < ITERATIONS_ADD; i++) {
				v.push(true);
			}
			r = StopTest();
			LogCounter("ADD", "Vector.<Boolean>", r.Time, ITERATIONS_ADD);
			LogCounter("Memory", "Vector.<Boolean>", int(r.Mem/1024), 0, null, "Kbytes");
			
			i = 0
			var y:Vector.<Boolean> = new Vector.<Boolean>();
			y.length = ITERATIONS_ADD;
			BeginTest();
			
			for (i; i < ITERATIONS_ADD; i++) {
				y[i] = true;
			}
			r = StopTest();
			LogCounter("ADD", "Vector.<Boolean>", r.Time, ITERATIONS_ADD, "Init Size");
		}
		/** @private */
		private function TestVectorGet():void {
			var r:PerfTestResult;
			var v:Vector.<Boolean> = new Vector.<Boolean>();
			v.length = ITERATIONS_ADD;
			var i:int = 0;
			for (i; i < ITERATIONS_ADD; i++) {
				v[i] = true;
			}
			
			var _r:Boolean;
			BeginTest();
			for (var j:int = 0; j < ITERATIONS_GET; j++) {
				i = 0;
				for (i; i < ITERATIONS_ADD; i++) {
					_r = v[i];
				}
			}
			r = StopTest();
			LogCounter("GET", "Vector.<Boolean>", r.Time, ITERATIONS_ADD * ITERATIONS_GET);
		}
		//}
		
		//{ ------------------------ Array --------------------------------------------------

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
		protected static const ITERATIONS_ADD:int = 10 * 1000 * 1000;
		protected static const ITERATIONS_GET:int = 100; // x ITERATIONS_ADD
		//}
	
		//{ ------------------------ Enums --------------------------------------------------
	
		//}
	}

}