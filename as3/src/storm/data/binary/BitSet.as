/* Copyright (C) NSiFor Holding LTD - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Nicolas Siatras for NSiFor Holding LTD
 */
package storm.data.binary {
	import flash.utils.ByteArray;
	/**
	 * @author Nicolas Siatras
	 * A BitSet stores bits. It emulates an array of Boolean elements
	 * but is optimized for space allocation, where each bit occupies only 1 bit
	 * instead of 4 bytes when stored in an Array or Vector.<Boolean>
	 */
	// TODO Rename Add1 to Push
	// TODO Rename Get1 to Get
	// TODO Rename Set1Pos to SetAt
	// TODO Rename Get1Pos to GetAt
	// TODO Rename GetBytes to ToBytes
	public class BitSet {
		//{ ------------------------ Constructors -------------------------------------------
		/**
		 * Creates a new BitSet
		 */
		public function BitSet(b:ByteArray = null) {
			Init(b);
		}
		//}

		//{ ------------------------ Init ---------------------------------------------------
		/** @private */
		private function Init(b:ByteArray):void {
			fPosition = 0;
			if (b == null) {
				fStorage = new Vector.<uint>(4);
			} else {
				BytesToStorage(b);
			}
		}
		//}
		
		//{ ------------------------ Core ---------------------------------------------------
		
		//}
		
		//{ ------------------------ API ----------------------------------------------------
		/**
		 * Resizes the set to the specified size
		 */
		public function Resize(bits:int):void {
			var s:int = bits / 32;
			if (bits % 32 == 0) {
				fStorage.length = s;
			} else {
				fStorage.length = s + 1;
			}
		}
		/**
		 * Sets bit at the specified index to 1 (right->0, left->31);
		 * Does not increase the storage
		 */
		[Inline]
		public final function Set1Pos(i:uint):void {
			fStorage[i >> 5] |= 1 << (31 - (i & 31)) ;
		}
		/**
		 * Adds the specified bit to the end of the BitSet
		 * and increases the storage accordingly
		 */
		[Inline]
		public final function Add1(val:Boolean):void {
			fStorage.length = 4 + ((fLen + 1) >> 5);
			if (val) {
				fStorage[fLen >> 5] |= 1 << (31 - (fLen & 31)) ;
			}
			fLen++;
		}
		/**
		 * Returns the value at the current cursor position
		 * and advances the cursor
		 */
		[Inline]
		public final function Get1():Boolean {
			var r:Boolean = ((fStorage[fPosition >> 5] << (fPosition & 31)) >>>  31) == 1;
			this.fPosition++;
			return r;
		}
		/**
		 * Returns the value at the specified index
		 */
		[Inline]
		public final function Get1Pos(i:int):Boolean {
			return ((fStorage[i >> 5] << (i & 31)) >>>  31) == 1;
		}
		/**
		 * Clones the BitSet
		 */
		public final function Clone():BitSet {
			return new BitSet(GetBytes());
		}
		//}
		
		//{ ------------------------ UI -----------------------------------------------------
		
		//}

		//{ ------------------------ Properties ---------------------------------------------
		/**
		 * Returns the raw data of the bitset
		 */
		public function get Raw():Vector.<uint> {
			return fStorage;
		}
		//}
		
		//{ ------------------------ Fields -------------------------------------------------
		/** @private */
		internal var fStorage:Vector.<uint>;
		// Bits position
		protected var fPosition:int = 0;
		/** @private */
		internal var fLen:int = 0;
		//}

		//{ ------------------------ IO -----------------------------------------------------
		/**
		 * Returns the bitset in a ByteArray
		 */
		public final function GetBytes():ByteArray {
			var b:ByteArray = new ByteArray();
			var l:int = Math.ceil(fLen / 32);
			var bt:uint;
			for (var i:int = 0; i < l; i++) {
				bt = fStorage[i];
				b.writeUnsignedInt(bt);
			}
			b.position = 0;
			return b;
		}
		[Inline]
		private final function BytesToStorage(b:ByteArray):void {
			b.position = 0;
			var i:int;
			var l:int = b.length / 4;
			var sBytes:int = b.length % 4;
			if (sBytes>0) {
				fStorage = new Vector.<uint>(l+1);
			} else {
				fStorage = new Vector.<uint>(l);
			}
			var bt:uint;
			
			for (i = 0; i < l; i++) {
				bt = b.readUnsignedInt();
				fStorage[i] = bt;
			}
			var lastByte:int = i;
			if (sBytes > 0) {
				
				for (i = 0; i < sBytes; i++) {
					fStorage[lastByte] |= (((b.readByte() << 24) >>> 24) << ((3 - i) * 8));
				}
			}
			
			fLen = b.length * 8;
		}
		//}

		//{ ------------------------ Events -------------------------------------------------
		
		//}
		
		//{ ------------------------ Static -------------------------------------------------
		/**
		 * Creates a new BitSet from a uint vector
		 */
		public static function FromRaw(v:Vector.<uint>):BitSet {
			var bs:BitSet = new BitSet();
			bs.fStorage = v;
			bs.fLen = v.length * 32;
			return bs;
		}
		//}
		
		//{ ------------------------ Enums --------------------------------------------------
		
		//}
	}

}