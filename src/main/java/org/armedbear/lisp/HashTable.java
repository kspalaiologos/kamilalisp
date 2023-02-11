/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.concurrent.locks.ReentrantLock;
/*     */ import org.armedbear.lisp.protocol.Hashtable;
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
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class HashTable
/*     */   extends LispObject
/*     */   implements Hashtable
/*     */ {
/*     */   protected static final float loadFactor = 0.75F;
/*     */   protected final LispObject rehashSize;
/*     */   protected final LispObject rehashThreshold;
/*     */   protected int threshold;
/*     */   protected volatile HashEntry[] buckets;
/*     */   protected volatile int count;
/*     */   final Comparator comparator;
/*  56 */   private final ReentrantLock lock = new ReentrantLock();
/*     */ 
/*     */   
/*     */   protected HashTable(Comparator c, int size, LispObject rehashSize, LispObject rehashThreshold) {
/*  60 */     this.rehashSize = rehashSize;
/*  61 */     this.rehashThreshold = rehashThreshold;
/*  62 */     this.buckets = new HashEntry[size];
/*  63 */     this.threshold = (int)(size * 0.75F);
/*  64 */     this.comparator = c;
/*     */   }
/*     */   
/*     */   protected static int calculateInitialCapacity(int size) {
/*  68 */     int capacity = 1;
/*  69 */     while (capacity < size) {
/*  70 */       capacity <<= 1;
/*     */     }
/*  72 */     return capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public static HashTable newEqHashTable(int size, LispObject rehashSize, LispObject rehashThreshold) {
/*  77 */     return new HashTable(new Comparator(), size, rehashSize, rehashThreshold);
/*     */   }
/*     */ 
/*     */   
/*     */   public static HashTable newEqlHashTable(int size, LispObject rehashSize, LispObject rehashThreshold) {
/*  82 */     return new HashTable(new EqlComparator(), size, rehashSize, rehashThreshold);
/*     */   }
/*     */ 
/*     */   
/*     */   public static HashTable newEqualHashTable(int size, LispObject rehashSize, LispObject rehashThreshold) {
/*  87 */     return new HashTable(new EqualComparator(), size, rehashSize, rehashThreshold);
/*     */   }
/*     */ 
/*     */   
/*     */   public static LispObject newEqualpHashTable(int size, LispObject rehashSize, LispObject rehashThreshold) {
/*  92 */     return new HashTable(new EqualpComparator(), size, rehashSize, rehashThreshold);
/*     */   }
/*     */   
/*     */   public final LispObject getRehashSize() {
/*  96 */     return this.rehashSize;
/*     */   }
/*     */   
/*     */   public final LispObject getRehashThreshold() {
/* 100 */     return this.rehashThreshold;
/*     */   }
/*     */   
/*     */   public int getSize() {
/* 104 */     return this.buckets.length;
/*     */   }
/*     */   
/*     */   public int getCount() {
/* 108 */     return this.count;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 113 */     return Symbol.HASH_TABLE;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 118 */     return BuiltInClass.HASH_TABLE;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 123 */     if (type == Symbol.HASH_TABLE) {
/* 124 */       return Lisp.T;
/*     */     }
/* 126 */     if (type == BuiltInClass.HASH_TABLE) {
/* 127 */       return Lisp.T;
/*     */     }
/* 129 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 134 */     if (this == obj) {
/* 135 */       return true;
/*     */     }
/* 137 */     if (obj instanceof HashTable) {
/* 138 */       HashTable ht = (HashTable)obj;
/* 139 */       if (this.count != ht.count) {
/* 140 */         return false;
/*     */       }
/* 142 */       if (getTest() != ht.getTest()) {
/* 143 */         return false;
/*     */       }
/* 145 */       LispObject entries = ENTRIES();
/* 146 */       while (entries != Lisp.NIL) {
/* 147 */         LispObject entry = entries.car();
/* 148 */         LispObject key = entry.car();
/* 149 */         LispObject value = entry.cdr();
/* 150 */         if (!value.equalp(ht.get(key))) {
/* 151 */           return false;
/*     */         }
/* 153 */         entries = entries.cdr();
/*     */       } 
/* 155 */       return true;
/*     */     } 
/* 157 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 163 */     HashEntry[] b = this.buckets;
/* 164 */     LispObject parts = Lisp.NIL;
/* 165 */     for (int i = 0; i < b.length; i++) {
/* 166 */       HashEntry e = b[i];
/* 167 */       while (e != null) {
/* 168 */         parts = parts.push(new Cons("KEY [bucket " + i + "]", e.key));
/* 169 */         parts = parts.push(new Cons("VALUE", e.value));
/* 170 */         e = e.next;
/*     */       } 
/*     */     } 
/* 173 */     return parts.nreverse();
/*     */   }
/*     */   
/*     */   public void clear() {
/* 177 */     this.lock.lock();
/*     */     try {
/* 179 */       this.buckets = new HashEntry[this.buckets.length];
/* 180 */       this.count = 0;
/*     */     } finally {
/* 182 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject gethash(LispObject key) {
/* 188 */     LispObject presentp, value = get(key);
/*     */     
/* 190 */     if (value == null) {
/* 191 */       value = presentp = Lisp.NIL;
/*     */     } else {
/* 193 */       presentp = Lisp.T;
/*     */     } 
/* 195 */     return LispThread.currentThread().setValues(value, presentp);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject gethash(LispObject key, LispObject defaultValue) {
/* 200 */     LispObject presentp, value = get(key);
/*     */     
/* 202 */     if (value == null) {
/* 203 */       value = defaultValue;
/* 204 */       presentp = Lisp.NIL;
/*     */     } else {
/* 206 */       presentp = Lisp.T;
/*     */     } 
/* 208 */     return LispThread.currentThread().setValues(value, presentp);
/*     */   }
/*     */   
/*     */   public LispObject gethash1(LispObject key) {
/* 212 */     LispObject value = get(key);
/* 213 */     return (value != null) ? value : Lisp.NIL;
/*     */   }
/*     */   
/*     */   public LispObject puthash(LispObject key, LispObject newValue) {
/* 217 */     put(key, newValue);
/* 218 */     return newValue;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject remhash(LispObject key) {
/* 224 */     return (remove(key) != null) ? Lisp.T : Lisp.NIL;
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 229 */     if (Symbol.PRINT_READABLY.symbolValue(LispThread.currentThread()) != Lisp.NIL) {
/* 230 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/* 231 */       return null;
/*     */     } 
/* 233 */     StringBuilder sb = new StringBuilder(getTest().princToString());
/* 234 */     sb.append(' ');
/* 235 */     sb.append(Symbol.HASH_TABLE.princToString());
/* 236 */     sb.append(' ');
/* 237 */     sb.append(this.count);
/* 238 */     if (this.count == 1) {
/* 239 */       sb.append(" entry");
/*     */     } else {
/* 241 */       sb.append(" entries");
/*     */     } 
/* 243 */     sb.append(", ");
/* 244 */     sb.append(this.buckets.length);
/* 245 */     sb.append(" buckets");
/* 246 */     return unreadableString(sb.toString());
/*     */   }
/*     */   
/*     */   public Symbol getTest() {
/* 250 */     return this.comparator.getTest();
/*     */   }
/*     */   
/*     */   protected HashEntry getEntry(LispObject key) {
/* 254 */     HashEntry[] b = this.buckets;
/* 255 */     int hash = this.comparator.hash(key);
/* 256 */     HashEntry e = b[hash & b.length - 1];
/* 257 */     while (e != null) {
/* 258 */       if (hash == e.hash && (key == e.key || this.comparator
/* 259 */         .keysEqual(key, e.key))) {
/* 260 */         return e;
/*     */       }
/* 262 */       e = e.next;
/*     */     } 
/* 264 */     return null;
/*     */   }
/*     */   
/*     */   public LispObject get(LispObject key) {
/* 268 */     HashEntry e = getEntry(key);
/* 269 */     LispObject v = (e == null) ? null : e.value;
/*     */     
/* 271 */     if (e == null || v != null) {
/* 272 */       return v;
/*     */     }
/*     */     
/* 275 */     this.lock.lock();
/*     */     try {
/* 277 */       return e.value;
/*     */     } finally {
/* 279 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */   
/*     */   public void put(LispObject key, LispObject value) {
/* 284 */     this.lock.lock();
/*     */     try {
/* 286 */       HashEntry e = getEntry(key);
/* 287 */       if (e != null) {
/* 288 */         e.value = value;
/*     */       } else {
/*     */         
/* 291 */         if (++this.count > this.threshold) {
/* 292 */           rehash();
/*     */         }
/*     */         
/* 295 */         int hash = this.comparator.hash(key);
/* 296 */         int index = hash & this.buckets.length - 1;
/* 297 */         this.buckets[index] = new HashEntry(key, hash, value, this.buckets[index]);
/*     */       } 
/*     */     } finally {
/* 300 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */   
/*     */   public LispObject remove(LispObject key) {
/* 305 */     this.lock.lock();
/*     */     try {
/* 307 */       int index = this.comparator.hash(key) & this.buckets.length - 1;
/*     */       
/* 309 */       HashEntry e = this.buckets[index];
/* 310 */       HashEntry last = null;
/* 311 */       while (e != null) {
/* 312 */         if (this.comparator.keysEqual(key, e.key)) {
/* 313 */           if (last == null) {
/* 314 */             this.buckets[index] = e.next;
/*     */           } else {
/* 316 */             last.next = e.next;
/*     */           } 
/* 318 */           this.count--;
/* 319 */           return e.value;
/*     */         } 
/* 321 */         last = e;
/* 322 */         e = e.next;
/*     */       } 
/* 324 */       return null;
/*     */     } finally {
/* 326 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */   
/*     */   protected void rehash() {
/* 331 */     this.lock.lock();
/*     */     try {
/* 333 */       int newCapacity = this.buckets.length * 2;
/* 334 */       this.threshold = (int)(newCapacity * 0.75F);
/* 335 */       int mask = newCapacity - 1;
/* 336 */       HashEntry[] newBuckets = new HashEntry[newCapacity];
/*     */       
/* 338 */       for (int i = this.buckets.length; i-- > 0; ) {
/* 339 */         HashEntry e = this.buckets[i];
/* 340 */         while (e != null) {
/* 341 */           int index = this.comparator.hash(e.key) & mask;
/* 342 */           newBuckets[index] = new HashEntry(e.key, e.hash, e.value, newBuckets[index]);
/*     */           
/* 344 */           e = e.next;
/*     */         } 
/*     */       } 
/* 347 */       this.buckets = newBuckets;
/*     */     } finally {
/* 349 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject ENTRIES() {
/* 355 */     return getEntries();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getEntries() {
/* 361 */     HashEntry[] b = this.buckets;
/* 362 */     LispObject list = Lisp.NIL;
/* 363 */     for (int i = b.length; i-- > 0; ) {
/* 364 */       HashEntry e = b[i];
/* 365 */       while (e != null) {
/* 366 */         list = new Cons(new Cons(e.key, e.value), list);
/* 367 */         e = e.next;
/*     */       } 
/*     */     } 
/* 370 */     return list;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject MAPHASH(LispObject function) {
/* 378 */     HashEntry[] b = this.buckets;
/* 379 */     for (int i = b.length; i-- > 0; ) {
/* 380 */       HashEntry e = b[i];
/* 381 */       while (e != null) {
/* 382 */         function.execute(e.key, e.value);
/* 383 */         e = e.next;
/*     */       } 
/*     */     } 
/* 386 */     return Lisp.NIL;
/*     */   }
/*     */   
/*     */   protected static class Comparator
/*     */   {
/*     */     Symbol getTest() {
/* 392 */       return Symbol.EQ;
/*     */     }
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 396 */       return (key1 == key2);
/*     */     }
/*     */     
/*     */     int hash(LispObject key) {
/* 400 */       return key.sxhash();
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class EqlComparator
/*     */     extends Comparator
/*     */   {
/*     */     Symbol getTest() {
/* 408 */       return Symbol.EQL;
/*     */     }
/*     */ 
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 413 */       return key1.eql(key2);
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class EqualComparator
/*     */     extends Comparator
/*     */   {
/*     */     Symbol getTest() {
/* 421 */       return Symbol.EQUAL;
/*     */     }
/*     */ 
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 426 */       return key1.equal(key2);
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class EqualpComparator
/*     */     extends Comparator
/*     */   {
/*     */     Symbol getTest() {
/* 434 */       return Symbol.EQUALP;
/*     */     }
/*     */ 
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 439 */       return key1.equalp(key2);
/*     */     }
/*     */ 
/*     */     
/*     */     int hash(LispObject key) {
/* 444 */       return key.psxhash();
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class HashEntry
/*     */   {
/*     */     LispObject key;
/*     */     int hash;
/*     */     volatile LispObject value;
/*     */     HashEntry next;
/*     */     
/*     */     HashEntry(LispObject key, int hash, LispObject value, HashEntry next) {
/* 456 */       this.key = key;
/* 457 */       this.hash = hash;
/* 458 */       this.value = value;
/* 459 */       this.next = next;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 466 */     long result = 2062775257L;
/* 467 */     result = Lisp.mix(result, this.count);
/* 468 */     result = Lisp.mix(result, getTest().sxhash());
/* 469 */     return (int)(result & 0x7FFFFFFFL);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/HashTable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */