/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class HashTableFunctions
/*     */ {
/*  40 */   static final LispObject FUNCTION_EQ = Symbol.EQ
/*  41 */     .getSymbolFunction();
/*  42 */   static final LispObject FUNCTION_EQL = Symbol.EQL
/*  43 */     .getSymbolFunction();
/*  44 */   static final LispObject FUNCTION_EQUAL = Symbol.EQUAL
/*  45 */     .getSymbolFunction();
/*  46 */   static final LispObject FUNCTION_EQUALP = Symbol.EQUALP
/*  47 */     .getSymbolFunction();
/*     */   
/*  49 */   private static final Primitive _MAKE_HASH_TABLE = new pf__make_hash_table();
/*     */   
/*     */   @DocString(name = "%make-hash-table")
/*     */   private static final class pf__make_hash_table extends Primitive {
/*     */     pf__make_hash_table() {
/*  54 */       super("%make-hash-table", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject test, LispObject size, LispObject rehashSize, LispObject rehashThreshold) {
/*  62 */       int n = Fixnum.getValue(size);
/*  63 */       if (test == HashTableFunctions.FUNCTION_EQL || test == Lisp.NIL)
/*  64 */         return HashTable.newEqlHashTable(n, rehashSize, rehashThreshold); 
/*  65 */       if (test == HashTableFunctions.FUNCTION_EQ)
/*  66 */         return HashTable.newEqHashTable(n, rehashSize, rehashThreshold); 
/*  67 */       if (test == HashTableFunctions.FUNCTION_EQUAL)
/*  68 */         return HashTable.newEqualHashTable(n, rehashSize, rehashThreshold); 
/*  69 */       if (test == HashTableFunctions.FUNCTION_EQUALP)
/*  70 */         return HashTable.newEqualpHashTable(n, rehashSize, rehashThreshold); 
/*  71 */       return Lisp.error(new LispError("Unsupported test for MAKE-HASH-TABLE: " + test
/*  72 */             .princToString()));
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*  77 */   private static final Primitive _MAKE_WEAK_HASH_TABLE = new pf__make_weak_hash_table();
/*     */   
/*     */   @DocString(name = "%make-weak-hash-table")
/*     */   private static final class pf__make_weak_hash_table extends Primitive {
/*     */     pf__make_weak_hash_table() {
/*  82 */       super("%make-weak-hash-table", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject test, LispObject size, LispObject rehashSize, LispObject rehashThreshold, LispObject weakness) {
/*  91 */       int n = Fixnum.getValue(size);
/*  92 */       if (test == HashTableFunctions.FUNCTION_EQL || test == Lisp.NIL) {
/*  93 */         return WeakHashTable.newEqlHashTable(n, rehashSize, rehashThreshold, weakness);
/*     */       }
/*  95 */       if (test == HashTableFunctions.FUNCTION_EQ) {
/*  96 */         return WeakHashTable.newEqHashTable(n, rehashSize, rehashThreshold, weakness);
/*     */       }
/*  98 */       if (test == HashTableFunctions.FUNCTION_EQUAL) {
/*  99 */         return WeakHashTable.newEqualHashTable(n, rehashSize, rehashThreshold, weakness);
/*     */       }
/* 101 */       if (test == HashTableFunctions.FUNCTION_EQUALP) {
/* 102 */         return WeakHashTable.newEqualpHashTable(n, rehashSize, rehashThreshold, weakness);
/*     */       }
/* 104 */       return Lisp.error(new LispError("Unsupported test for MAKE-HASH-TABLE: " + test
/* 105 */             .princToString()));
/*     */     }
/*     */   }
/*     */   
/* 109 */   private static final Primitive GETHASH = new pf_gethash();
/*     */ 
/*     */   
/*     */   @DocString(name = "gethash", args = "key hash-table &optional default", returns = "value, present-p", doc = "Returns the value associated with KEY in HASH-TABLE.")
/*     */   private static final class pf_gethash
/*     */     extends Primitive
/*     */   {
/*     */     pf_gethash() {
/* 117 */       super(Symbol.GETHASH, "key hash-table &optional default");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject key, LispObject ht) {
/* 124 */       if (ht instanceof WeakHashTable) {
/* 125 */         return ((WeakHashTable)ht).gethash(key);
/*     */       }
/* 127 */       return HashTableFunctions.checkHashTable(ht).gethash(key);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject key, LispObject ht, LispObject defaultValue) {
/* 134 */       if (ht instanceof WeakHashTable) {
/* 135 */         return ((WeakHashTable)ht).gethash(key, defaultValue);
/*     */       }
/* 137 */       return HashTableFunctions.checkHashTable(ht).gethash(key, defaultValue);
/*     */     }
/*     */   }
/*     */   
/* 141 */   private static final Primitive GETHASH1 = new pf_gethash1();
/*     */   
/*     */   @DocString(name = "gethash1", args = "key hash-table", returns = "value")
/*     */   private static final class pf_gethash1
/*     */     extends Primitive {
/*     */     pf_gethash1() {
/* 147 */       super(Symbol.GETHASH1, "key hash-table");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 151 */       if (second instanceof WeakHashTable) {
/* 152 */         WeakHashTable weakHashTable = (WeakHashTable)second;
/* 153 */         synchronized (weakHashTable) {
/* 154 */           LispObject value = weakHashTable.get(first);
/* 155 */           return (value != null) ? value : Lisp.NIL;
/*     */         } 
/*     */       } 
/* 158 */       HashTable ht = HashTableFunctions.checkHashTable(second);
/* 159 */       synchronized (ht) {
/* 160 */         LispObject value = ht.get(first);
/* 161 */         return (value != null) ? value : Lisp.NIL;
/*     */       } 
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 167 */   private static final Primitive PUTHASH = new pf_puthash();
/*     */   
/*     */   @DocString(name = "puthash", args = "key hash-table new-value &optional default", returns = "value")
/*     */   private static final class pf_puthash
/*     */     extends Primitive {
/*     */     pf_puthash() {
/* 173 */       super(Symbol.PUTHASH, "key hash-table new-value &optional default");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject key, LispObject ht, LispObject value) {
/* 180 */       if (ht instanceof WeakHashTable) {
/* 181 */         return ((WeakHashTable)ht).puthash(key, value);
/*     */       }
/* 183 */       return HashTableFunctions.checkHashTable(ht).puthash(key, value);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject key, LispObject ht, LispObject ignored, LispObject value) {
/* 189 */       if (ht instanceof WeakHashTable) {
/* 190 */         return ((WeakHashTable)ht).puthash(key, value);
/*     */       }
/* 192 */       return HashTableFunctions.checkHashTable(ht).puthash(key, value);
/*     */     }
/*     */   }
/*     */   
/* 196 */   private static final Primitive REMHASH = new pf_remhash();
/*     */   
/*     */   @DocString(name = "remhash", args = "key hash-table", returns = "generalized-boolean", doc = "Removes the value for KEY in HASH-TABLE, if any.")
/*     */   private static final class pf_remhash
/*     */     extends Primitive
/*     */   {
/*     */     pf_remhash() {
/* 203 */       super(Symbol.REMHASH, "key hash-table");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject key, LispObject ht) {
/* 207 */       if (ht instanceof WeakHashTable) {
/* 208 */         return ((WeakHashTable)ht).remhash(key);
/*     */       }
/* 210 */       return HashTableFunctions.checkHashTable(ht).remhash(key);
/*     */     }
/*     */   }
/*     */   
/* 214 */   private static final Primitive CLRHASH = new pf_clrhash();
/*     */   
/*     */   @DocString(name = "clrhash", args = "hash-table", returns = "hash-table")
/*     */   private static final class pf_clrhash
/*     */     extends Primitive {
/*     */     pf_clrhash() {
/* 220 */       super(Symbol.CLRHASH, "hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject ht) {
/* 225 */       if (ht instanceof WeakHashTable) {
/* 226 */         ((WeakHashTable)ht).clear();
/* 227 */         return ht;
/*     */       } 
/* 229 */       HashTableFunctions.checkHashTable(ht).clear();
/* 230 */       return ht;
/*     */     }
/*     */   }
/*     */   
/* 234 */   private static final Primitive HASH_TABLE_COUNT = new pf_hash_table_count();
/*     */   
/*     */   @DocString(name = "hash-table-count", args = "hash-table", doc = "Returns the number of entries in HASH-TABLE.")
/*     */   private static final class pf_hash_table_count
/*     */     extends Primitive
/*     */   {
/*     */     pf_hash_table_count() {
/* 241 */       super(Symbol.HASH_TABLE_COUNT, "hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 246 */       if (arg instanceof WeakHashTable) {
/* 247 */         return Fixnum.getInstance(((WeakHashTable)arg).getCount());
/*     */       }
/* 249 */       return Fixnum.getInstance(HashTableFunctions.checkHashTable(arg).getCount());
/*     */     }
/*     */   }
/*     */   
/* 253 */   private static final Primitive SXHASH = new pf_sxhash();
/*     */   
/*     */   @DocString(name = "sxhash", args = "object => hash-code")
/*     */   private static final class pf_sxhash
/*     */     extends Primitive {
/*     */     pf_sxhash() {
/* 259 */       super(Symbol.SXHASH, "object");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 264 */       return Fixnum.getInstance(arg.sxhash());
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "psxhash", args = "object")
/* 271 */   private static final Primitive PSXHASH = new pf_psxhash();
/*     */   
/*     */   private static final class pf_psxhash extends Primitive {
/*     */     pf_psxhash() {
/* 275 */       super("psxhash", Lisp.PACKAGE_SYS, true, "object");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 280 */       return Fixnum.getInstance(arg.psxhash());
/*     */     }
/*     */   }
/*     */   
/* 284 */   private static final Primitive HASH_TABLE_P = new pf_hash_table_p();
/*     */   
/*     */   @DocString(name = "hash-table-p", args = "object", doc = "Whether OBJECT is an instance of a hash-table.")
/*     */   private static final class pf_hash_table_p
/*     */     extends Primitive
/*     */   {
/*     */     pf_hash_table_p() {
/* 291 */       super(Symbol.HASH_TABLE_P, "object");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 296 */       if (arg instanceof WeakHashTable) return Lisp.T; 
/* 297 */       return (arg instanceof HashTable) ? Lisp.T : Lisp.NIL;
/*     */     }
/*     */   }
/*     */   
/* 301 */   private static final Primitive HASH_TABLE_ENTRIES = new pf_hash_table_entries();
/*     */   
/*     */   @DocString(name = "hah-table-entries", args = "hash-table", doc = "Returns a list of all key/values pairs in HASH-TABLE.")
/*     */   private static final class pf_hash_table_entries
/*     */     extends Primitive
/*     */   {
/*     */     pf_hash_table_entries() {
/* 308 */       super("hash-table-entries", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 313 */       if (arg instanceof WeakHashTable) {
/* 314 */         return ((WeakHashTable)arg).ENTRIES();
/*     */       }
/* 316 */       return HashTableFunctions.checkHashTable(arg).ENTRIES();
/*     */     }
/*     */   }
/*     */   
/* 320 */   private static final Primitive HASH_TABLE_TEST = new pf_hash_table_test();
/*     */   
/*     */   @DocString(name = "hash-table-test", args = "hash-table", doc = "Return the test used for the keys of HASH-TABLE.")
/*     */   private static final class pf_hash_table_test
/*     */     extends Primitive
/*     */   {
/*     */     pf_hash_table_test() {
/* 327 */       super(Symbol.HASH_TABLE_TEST, "hash-table");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 331 */       if (arg instanceof WeakHashTable) {
/* 332 */         return ((WeakHashTable)arg).getTest();
/*     */       }
/* 334 */       return HashTableFunctions.checkHashTable(arg).getTest();
/*     */     }
/*     */   }
/*     */   
/* 338 */   private static final Primitive HASH_TABLE_SIZE = new pf_hash_table_size();
/*     */   
/*     */   @DocString(name = "hash-table-size", args = "hash-table", doc = "Returns the number of storage buckets in HASH-TABLE.")
/*     */   private static final class pf_hash_table_size
/*     */     extends Primitive
/*     */   {
/*     */     pf_hash_table_size() {
/* 345 */       super(Symbol.HASH_TABLE_SIZE, "hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 350 */       if (arg instanceof WeakHashTable) {
/* 351 */         return Fixnum.getInstance(((WeakHashTable)arg).getSize());
/*     */       }
/* 353 */       return Fixnum.getInstance(HashTableFunctions.checkHashTable(arg).getSize());
/*     */     }
/*     */   }
/*     */   
/* 357 */   private static final Primitive HASH_TABLE_REHASH_SIZE = new pf_hash_table_rehash_size();
/*     */   
/*     */   @DocString(name = "hash-table-rehash-size", args = "hash-table")
/*     */   private static final class pf_hash_table_rehash_size
/*     */     extends Primitive {
/*     */     pf_hash_table_rehash_size() {
/* 363 */       super(Symbol.HASH_TABLE_REHASH_SIZE, "hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 368 */       if (arg instanceof WeakHashTable) {
/* 369 */         return ((WeakHashTable)arg).getRehashSize();
/*     */       }
/* 371 */       return HashTableFunctions.checkHashTable(arg).getRehashSize();
/*     */     }
/*     */   }
/*     */   
/* 375 */   private static final Primitive HASH_TABLE_REHASH_THRESHOLD = new pf_hash_table_rehash_threshold();
/*     */   
/*     */   @DocString(name = "hash-table-rehash-threshold", args = "hash-table")
/*     */   private static final class pf_hash_table_rehash_threshold
/*     */     extends Primitive {
/*     */     pf_hash_table_rehash_threshold() {
/* 381 */       super(Symbol.HASH_TABLE_REHASH_THRESHOLD, "hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 386 */       if (arg instanceof WeakHashTable) {
/* 387 */         return ((WeakHashTable)arg).getRehashThreshold();
/*     */       }
/* 389 */       return HashTableFunctions.checkHashTable(arg).getRehashThreshold();
/*     */     }
/*     */   }
/*     */   
/* 393 */   private static final Primitive MAPHASH = new pf_maphash();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "maphash", args = "function hash-table", doc = "Iterates over all entries in the hash-table. For each entry, the function is called with two arguments--the key and the value of that entry.")
/*     */   private static final class pf_maphash
/*     */     extends Primitive
/*     */   {
/*     */     pf_maphash() {
/* 402 */       super(Symbol.MAPHASH, "function hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 407 */       if (second instanceof WeakHashTable) {
/* 408 */         return ((WeakHashTable)second).MAPHASH(first);
/*     */       }
/* 410 */       return HashTableFunctions.checkHashTable(second).MAPHASH(first);
/*     */     }
/*     */   }
/*     */   
/* 414 */   private static final Primitive HASH_TABLE_WEAKNESS = new pf_hash_table_weakness();
/*     */   
/*     */   @DocString(name = "hash-table-weakness", args = "hash-table", doc = "Return weakness property of HASH-TABLE, or NIL if it has none.")
/*     */   private static final class pf_hash_table_weakness
/*     */     extends Primitive
/*     */   {
/*     */     pf_hash_table_weakness() {
/* 421 */       super(Symbol.HASH_TABLE_WEAKNESS, "hash-table");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first) {
/* 426 */       if (first instanceof HashTable)
/* 427 */         return Lisp.NIL; 
/* 428 */       if (first instanceof WeakHashTable) {
/* 429 */         return ((WeakHashTable)first).getWeakness();
/*     */       }
/* 431 */       return Lisp.type_error(first, Symbol.HASH_TABLE);
/*     */     }
/*     */   }
/*     */   
/*     */   protected static HashTable checkHashTable(LispObject ht) {
/* 436 */     if (ht instanceof HashTable) return (HashTable)ht; 
/* 437 */     Lisp.type_error(ht, Symbol.HASH_TABLE);
/* 438 */     return null;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/HashTableFunctions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */