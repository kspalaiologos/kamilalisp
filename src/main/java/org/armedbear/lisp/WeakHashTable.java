/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.lang.ref.Reference;
/*     */ import java.lang.ref.ReferenceQueue;
/*     */ import java.lang.ref.WeakReference;
/*     */ import java.util.Collections;
/*     */ import java.util.HashMap;
/*     */ import java.util.Map;
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
/*     */ public class WeakHashTable
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
/*  76 */   private final ReentrantLock lock = new ReentrantLock();
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   HashEntry bucketType;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   final LispObject weakness;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   ReferenceQueue<LispObject> queue;
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   Map<Reference, HashEntry> entryLookup;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected static int calculateInitialCapacity(int size) {
/* 106 */     int capacity = 1;
/* 107 */     while (capacity < size) {
/* 108 */       capacity <<= 1;
/*     */     }
/* 110 */     return capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   enum ReferenceType
/*     */   {
/* 116 */     NORMAL,
/* 117 */     WEAK,
/* 118 */     SOFT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   enum WeaknessType
/*     */   {
/* 125 */     KEY,
/*     */ 
/*     */     
/* 128 */     VALUE,
/*     */ 
/*     */     
/* 131 */     KEY_AND_VALUE,
/*     */ 
/*     */     
/* 134 */     KEY_OR_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static WeakHashTable newEqHashTable(int size, LispObject rehashSize, LispObject rehashThreshold, LispObject weakness) {
/* 141 */     return new WeakHashTable(new Comparator(), size, rehashSize, rehashThreshold, weakness);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static WeakHashTable newEqlHashTable(int size, LispObject rehashSize, LispObject rehashThreshold, LispObject weakness) {
/* 149 */     return new WeakHashTable(new EqlComparator(), size, rehashSize, rehashThreshold, weakness);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static WeakHashTable newEqualHashTable(int size, LispObject rehashSize, LispObject rehashThreshold, LispObject weakness) {
/* 157 */     return new WeakHashTable(new EqualComparator(), size, rehashSize, rehashThreshold, weakness);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static WeakHashTable newEqualpHashTable(int size, LispObject rehashSize, LispObject rehashThreshold, LispObject weakness) {
/* 165 */     return new WeakHashTable(new EqualpComparator(), size, rehashSize, rehashThreshold, weakness);
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getRehashSize() {
/* 170 */     return this.rehashSize;
/*     */   }
/*     */   
/*     */   public final LispObject getRehashThreshold() {
/* 174 */     return this.rehashThreshold;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getSize() {
/* 179 */     HashEntry[] b = getTable();
/* 180 */     return b.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getCount() {
/* 185 */     getTable();
/* 186 */     return this.count;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 191 */     return Symbol.HASH_TABLE;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 196 */     return BuiltInClass.HASH_TABLE;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 201 */     if (type == Symbol.HASH_TABLE) {
/* 202 */       return Lisp.T;
/*     */     }
/* 204 */     if (type == BuiltInClass.HASH_TABLE) {
/* 205 */       return Lisp.T;
/*     */     }
/* 207 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 216 */     if (this == obj) {
/* 217 */       return true;
/*     */     }
/* 219 */     if (obj instanceof WeakHashTable) {
/* 220 */       WeakHashTable ht = (WeakHashTable)obj;
/* 221 */       if (this.count != ht.count) {
/* 222 */         return false;
/*     */       }
/* 224 */       if (getTest() != ht.getTest()) {
/* 225 */         return false;
/*     */       }
/* 227 */       LispObject entries = ENTRIES();
/* 228 */       while (entries != Lisp.NIL) {
/* 229 */         LispObject entry = entries.car();
/* 230 */         LispObject key = entry.car();
/* 231 */         LispObject value = entry.cdr();
/* 232 */         if (!value.equalp(ht.get(key))) {
/* 233 */           return false;
/*     */         }
/* 235 */         entries = entries.cdr();
/*     */       } 
/* 237 */       return true;
/*     */     } 
/* 239 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 244 */     HashEntry[] b = getTable();
/* 245 */     LispObject parts = Lisp.NIL;
/* 246 */     for (int i = 0; i < b.length; i++) {
/* 247 */       HashEntry e = b[i];
/* 248 */       while (e != null) {
/* 249 */         LispObject key = e.getKey();
/* 250 */         LispObject value = e.getValue();
/* 251 */         if (key != null && value != null) {
/* 252 */           parts = parts.push(new Cons("KEY [bucket " + i + "]", key));
/* 253 */           parts = parts.push(new Cons("VALUE", value));
/*     */         } else {
/* 255 */           assert false : "Dangling hash entries encountered.";
/*     */         } 
/*     */         
/* 258 */         e = e.getNext();
/*     */       } 
/*     */     } 
/* 261 */     return parts.nreverse();
/*     */   }
/*     */   
/*     */   public void clear() {
/* 265 */     this.lock.lock();
/*     */     try {
/* 267 */       this.buckets = this.bucketType.makeArray(this.buckets.length);
/* 268 */       this.count = 0;
/* 269 */       while (this.queue.poll() != null);
/*     */     } finally {
/*     */       
/* 272 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject gethash(LispObject key) {
/* 278 */     LispObject presentp, value = get(key);
/*     */     
/* 280 */     if (value == null) {
/* 281 */       value = presentp = Lisp.NIL;
/*     */     } else {
/* 283 */       presentp = Lisp.T;
/*     */     } 
/* 285 */     return LispThread.currentThread().setValues(value, presentp);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject gethash(LispObject key, LispObject defaultValue) {
/* 290 */     LispObject presentp, value = get(key);
/*     */     
/* 292 */     if (value == null) {
/* 293 */       value = defaultValue;
/* 294 */       presentp = Lisp.NIL;
/*     */     } else {
/* 296 */       presentp = Lisp.T;
/*     */     } 
/* 298 */     return LispThread.currentThread().setValues(value, presentp);
/*     */   }
/*     */   
/*     */   public LispObject gethash1(LispObject key) {
/* 302 */     LispObject value = get(key);
/* 303 */     return (value != null) ? value : Lisp.NIL;
/*     */   }
/*     */   
/*     */   public LispObject puthash(LispObject key, LispObject newValue) {
/* 307 */     put(key, newValue);
/* 308 */     return newValue;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject remhash(LispObject key) {
/* 314 */     return (remove(key) != null) ? Lisp.T : Lisp.NIL;
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 319 */     if (Symbol.PRINT_READABLY.symbolValue(LispThread.currentThread()) != Lisp.NIL) {
/* 320 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/* 321 */       return null;
/*     */     } 
/* 323 */     StringBuilder sb = new StringBuilder(getTest().princToString());
/* 324 */     sb.append(' ');
/* 325 */     sb.append(Symbol.HASH_TABLE.princToString());
/* 326 */     sb.append(' ');
/* 327 */     if (this.bucketType instanceof HashEntryWeakKey) {
/* 328 */       sb.append("WEAKNESS :KEY");
/* 329 */     } else if (this.bucketType instanceof HashEntryWeakValue) {
/* 330 */       sb.append("WEAKNESS :VALUE");
/* 331 */     } else if (this.bucketType instanceof HashEntryWeakKeyAndValue) {
/* 332 */       sb.append("WEAKNESS :KEY-AND-VALUE");
/* 333 */     } else if (this.bucketType instanceof HashEntryWeakKeyOrValue) {
/* 334 */       sb.append("WEAKNESS :KEY-OR-VALUE");
/*     */     } 
/* 336 */     sb.append(' ');
/* 337 */     sb.append(this.count);
/* 338 */     if (this.count == 1) {
/* 339 */       sb.append(" entry");
/*     */     } else {
/* 341 */       sb.append(" entries");
/*     */     } 
/* 343 */     sb.append(", ");
/* 344 */     sb.append(this.buckets.length);
/* 345 */     sb.append(" buckets");
/* 346 */     return unreadableString(sb.toString());
/*     */   }
/*     */   
/*     */   public Symbol getTest() {
/* 350 */     return this.comparator.getTest();
/*     */   }
/*     */   
/*     */   public LispObject getWeakness() {
/* 354 */     return this.weakness;
/*     */   }
/*     */   
/*     */   HashEntry[] getTable() {
/* 358 */     this.lock.lock();
/*     */     try {
/* 360 */       this.bucketType.expungeQueue();
/* 361 */       return this.buckets;
/*     */     } finally {
/* 363 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */   
/*     */   protected HashEntry getEntry(LispObject key) {
/* 368 */     HashEntry[] b = getTable();
/* 369 */     int hash = this.comparator.hash(key);
/* 370 */     HashEntry e = b[hash & b.length - 1];
/* 371 */     while (e != null) {
/* 372 */       if (hash == e.getHash() && (key == e
/* 373 */         .getKey() || this.comparator
/* 374 */         .keysEqual(key, e.getKey()))) {
/* 375 */         return e;
/*     */       }
/* 377 */       e = e.getNext();
/*     */     } 
/* 379 */     return null;
/*     */   }
/*     */   
/*     */   public LispObject get(LispObject key) {
/* 383 */     HashEntry e = getEntry(key);
/* 384 */     LispObject v = (e == null) ? null : e.getValue();
/*     */     
/* 386 */     if (e == null || v != null) {
/* 387 */       return v;
/*     */     }
/* 389 */     return e.getValue();
/*     */   }
/*     */   
/*     */   public void put(LispObject key, LispObject value) {
/* 393 */     HashEntry e = getEntry(key);
/* 394 */     if (e != null) {
/* 395 */       e.setValue(value);
/*     */     } else {
/*     */       
/* 398 */       if (++this.count > this.threshold) {
/* 399 */         rehash();
/*     */       }
/* 401 */       int hash = this.comparator.hash(key);
/* 402 */       int index = hash & this.buckets.length - 1;
/* 403 */       this.buckets[index] = this.bucketType.makeInstance(key, hash, value, this.buckets[index], index);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject remove(LispObject key) {
/* 410 */     this.lock.lock();
/*     */     try {
/* 412 */       this.bucketType.expungeQueue();
/* 413 */       int index = this.comparator.hash(key) & this.buckets.length - 1;
/*     */       
/* 415 */       HashEntry e = this.buckets[index];
/* 416 */       HashEntry last = null;
/* 417 */       while (e != null) {
/* 418 */         LispObject entryKey = e.getKey();
/* 419 */         if (entryKey == null) {
/* 420 */           e.clear();
/* 421 */           if (last == null) {
/* 422 */             this.buckets[index] = e.getNext();
/*     */           } else {
/* 424 */             last.setNext(e.getNext());
/*     */           } 
/* 426 */           this.count--;
/* 427 */         } else if (this.comparator.keysEqual(key, entryKey)) {
/* 428 */           e.clear();
/* 429 */           if (last == null) {
/* 430 */             this.buckets[index] = e.getNext();
/*     */           } else {
/* 432 */             last.setNext(e.getNext());
/*     */           } 
/* 434 */           this.count--;
/* 435 */           return e.getValue();
/*     */         } 
/* 437 */         last = e;
/* 438 */         e = e.getNext();
/*     */       } 
/* 440 */       return null;
/*     */     } finally {
/* 442 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private void remove(Reference ref) {
/* 452 */     assert this.lock.isHeldByCurrentThread();
/* 453 */     HashEntry entry = this.entryLookup.get(ref);
/*     */ 
/*     */     
/* 456 */     if (entry == null) {
/*     */       return;
/*     */     }
/* 459 */     int index = entry.getSlot();
/* 460 */     HashEntry e = this.buckets[index];
/* 461 */     HashEntry last = null;
/* 462 */     while (e != null) {
/* 463 */       if (e.equals(entry)) {
/* 464 */         if (last == null) {
/* 465 */           this.buckets[index] = e.getNext();
/*     */         } else {
/* 467 */           last.setNext(e.getNext());
/*     */         } 
/* 469 */         this.count--;
/*     */         break;
/*     */       } 
/* 472 */       last = e;
/* 473 */       e = e.getNext();
/*     */     } 
/*     */   }
/*     */   
/*     */   protected void rehash() {
/* 478 */     this.lock.lock();
/*     */     try {
/* 480 */       int newCapacity = this.buckets.length * 2;
/* 481 */       this.threshold = (int)(newCapacity * 0.75F);
/* 482 */       int mask = newCapacity - 1;
/* 483 */       HashEntry[] newBuckets = this.bucketType.makeArray(newCapacity);
/*     */       
/* 485 */       for (int i = this.buckets.length; i-- > 0; ) {
/* 486 */         HashEntry e = this.buckets[i];
/* 487 */         while (e != null) {
/* 488 */           LispObject key = e.getKey();
/* 489 */           LispObject value = e.getValue();
/* 490 */           if (key == null || value == null) {
/* 491 */             e.clear();
/* 492 */             e = e.getNext();
/*     */             continue;
/*     */           } 
/* 495 */           int index = this.comparator.hash(key) & mask;
/* 496 */           e.clear();
/* 497 */           newBuckets[index] = this.bucketType
/* 498 */             .makeInstance(key, e
/* 499 */               .getHash(), value, newBuckets[index], index);
/*     */ 
/*     */ 
/*     */           
/* 503 */           e = e.getNext();
/*     */         } 
/*     */       } 
/* 506 */       this.buckets = newBuckets;
/*     */     } finally {
/* 508 */       this.lock.unlock();
/*     */     } 
/*     */   }
/*     */   
/*     */   @Deprecated
/*     */   public LispObject ENTRIES() {
/* 514 */     return getEntries();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getEntries() {
/* 519 */     HashEntry[] b = getTable();
/* 520 */     LispObject list = Lisp.NIL;
/* 521 */     for (int i = b.length; i-- > 0; ) {
/* 522 */       HashEntry e = b[i];
/* 523 */       while (e != null) {
/* 524 */         LispObject key = e.getKey();
/* 525 */         LispObject value = e.getValue();
/* 526 */         if (key != null && value != null) {
/* 527 */           list = new Cons(new Cons(key, value), list);
/*     */         } else {
/* 529 */           assert false : "ENTRIES encounted dangling entries.";
/*     */         } 
/*     */         
/* 532 */         e = e.getNext();
/*     */       } 
/*     */     } 
/* 535 */     return list;
/*     */   }
/*     */   
/*     */   public LispObject MAPHASH(LispObject function) {
/* 539 */     HashEntry[] b = getTable();
/* 540 */     for (int i = b.length; i-- > 0; ) {
/* 541 */       HashEntry e = b[i];
/* 542 */       while (e != null) {
/* 543 */         LispObject key = e.getKey();
/* 544 */         LispObject value = e.getValue();
/* 545 */         if (key != null && value != null) {
/* 546 */           function.execute(key, value);
/*     */         } else {
/* 548 */           assert false : "MAPHASH encountered dangling entries.";
/*     */         } 
/*     */         
/* 551 */         e = e.getNext();
/*     */       } 
/*     */     } 
/* 554 */     return Lisp.NIL;
/*     */   }
/*     */   
/*     */   protected static class Comparator {
/*     */     Symbol getTest() {
/* 559 */       return Symbol.EQ;
/*     */     }
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 563 */       return (key1 == key2);
/*     */     }
/*     */     
/*     */     int hash(LispObject key) {
/* 567 */       return key.sxhash();
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class EqlComparator
/*     */     extends Comparator {
/*     */     Symbol getTest() {
/* 574 */       return Symbol.EQL;
/*     */     }
/*     */ 
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 579 */       return key1.eql(key2);
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class EqualComparator
/*     */     extends Comparator {
/*     */     Symbol getTest() {
/* 586 */       return Symbol.EQUAL;
/*     */     }
/*     */ 
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 591 */       return key1.equal(key2);
/*     */     }
/*     */   }
/*     */   
/*     */   protected static class EqualpComparator
/*     */     extends Comparator {
/*     */     Symbol getTest() {
/* 598 */       return Symbol.EQUALP;
/*     */     }
/*     */ 
/*     */     
/*     */     boolean keysEqual(LispObject key1, LispObject key2) {
/* 603 */       return key1.equalp(key2);
/*     */     }
/*     */ 
/*     */     
/*     */     int hash(LispObject key) {
/* 608 */       return key.psxhash();
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   abstract class HashEntry
/*     */   {
/*     */     LispObject key;
/*     */     
/*     */     int hash;
/*     */     volatile LispObject value;
/*     */     HashEntry next;
/*     */     int slot;
/*     */     
/*     */     public HashEntry() {}
/*     */     
/*     */     public HashEntry(LispObject key, int hash, LispObject value, HashEntry next, int slot) {
/* 625 */       this.key = key;
/* 626 */       this.hash = hash;
/* 627 */       this.value = value;
/* 628 */       this.next = next;
/* 629 */       this.slot = slot;
/*     */     }
/*     */     
/*     */     public LispObject getKey() {
/* 633 */       return this.key;
/*     */     }
/*     */     
/*     */     public void setKey(LispObject key) {
/* 637 */       this.key = key;
/*     */     }
/*     */     
/*     */     public int getHash() {
/* 641 */       return this.hash;
/*     */     }
/*     */     
/*     */     public void setHash(int hash) {
/* 645 */       this.hash = hash;
/*     */     }
/*     */     
/*     */     public LispObject getValue() {
/* 649 */       return this.value;
/*     */     }
/*     */     
/*     */     public void setValue(LispObject value) {
/* 653 */       this.value = value;
/*     */     }
/*     */     
/*     */     public HashEntry getNext() {
/* 657 */       return this.next;
/*     */     }
/*     */     
/*     */     public void setNext(HashEntry next) {
/* 661 */       this.next = next;
/*     */     }
/*     */     
/*     */     public int getSlot() {
/* 665 */       return this.slot;
/*     */     }
/*     */     
/*     */     public void setSlot(int slot) {
/* 669 */       this.slot = slot;
/*     */     }
/*     */     
/*     */     abstract HashEntry[] makeArray(int param1Int);
/*     */     
/*     */     abstract HashEntry makeInstance(LispObject param1LispObject1, int param1Int1, LispObject param1LispObject2, HashEntry param1HashEntry, int param1Int2);
/*     */     
/*     */     abstract void expungeQueue();
/*     */     
/*     */     abstract void clear();
/*     */   }
/*     */   
/* 681 */   private WeakHashTable(Comparator c, int size, LispObject rehashSize, LispObject rehashThreshold, LispObject weakness) { this.queue = new ReferenceQueue<>();
/*     */ 
/*     */     
/* 684 */     this
/* 685 */       .entryLookup = Collections.synchronizedMap(new HashMap<>()); this.rehashSize = rehashSize; this.rehashThreshold = rehashThreshold; this.bucketType = null; this.weakness = weakness; if (weakness.equals(Keyword.KEY)) {
/*     */       this.bucketType = new HashEntryWeakKey();
/*     */     } else if (weakness.equals(Keyword.VALUE)) {
/*     */       this.bucketType = new HashEntryWeakValue();
/*     */     } else if (weakness.equals(Keyword.KEY_AND_VALUE)) {
/*     */       this.bucketType = new HashEntryWeakKeyAndValue();
/*     */     } else if (weakness.equals(Keyword.KEY_OR_VALUE)) {
/*     */       this.bucketType = new HashEntryWeakKeyOrValue();
/*     */     } else {
/*     */       assert false : "Bad weakness argument to WeakHashTable type constructor.";
/*     */     }  this.buckets = this.bucketType.makeArray(size);
/*     */     this.threshold = (int)(size * 0.75F);
/* 697 */     this.comparator = c; } class HashEntryWeakKey extends HashEntry { private WeakReference<LispObject> key; public HashEntryWeakKey(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) { this.hash = hash;
/* 698 */       this.value = value;
/* 699 */       this.next = next;
/* 700 */       this.slot = slot;
/*     */       
/* 702 */       this.key = new WeakReference<>(key, WeakHashTable.this.queue);
/* 703 */       WeakHashTable.this.entryLookup.put(this.key, this); }
/*     */     
/*     */     public HashEntryWeakKey() {}
/*     */     public LispObject getKey() {
/* 707 */       return this.key.get();
/*     */     }
/*     */     
/*     */     public void setKey(LispObject key) {
/* 711 */       WeakReference<LispObject> old = this.key;
/* 712 */       old.clear();
/* 713 */       this.key = new WeakReference<>(key, WeakHashTable.this.queue);
/* 714 */       WeakHashTable.this.entryLookup.put(this.key, this);
/*     */     }
/*     */     
/*     */     HashEntryWeakKey[] makeArray(int length) {
/* 718 */       return new HashEntryWeakKey[length];
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     WeakHashTable.HashEntry makeInstance(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 724 */       return new HashEntryWeakKey(key, hash, value, next, slot);
/*     */     }
/*     */     
/*     */     void expungeQueue() {
/* 728 */       Reference<? extends LispObject> ref = WeakHashTable.this.queue.poll();
/* 729 */       while (ref != null) {
/* 730 */         WeakHashTable.this.remove(ref);
/* 731 */         WeakHashTable.this.entryLookup.remove(ref);
/* 732 */         ref = WeakHashTable.this.queue.poll();
/*     */       } 
/*     */     }
/*     */ 
/*     */     
/*     */     void clear() {
/* 738 */       this.key.clear();
/* 739 */       assert WeakHashTable.this.entryLookup.containsKey(this.key) : "Key was not in lookup table";
/*     */       
/* 741 */       WeakHashTable.this.entryLookup.remove(this.key);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*     */   class HashEntryWeakValue
/*     */     extends HashEntry
/*     */   {
/*     */     private WeakReference<LispObject> value;
/*     */ 
/*     */     
/*     */     public HashEntryWeakValue() {}
/*     */     
/*     */     public HashEntryWeakValue(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 755 */       this.hash = hash;
/* 756 */       this.key = key;
/* 757 */       this.next = next;
/* 758 */       this.slot = slot;
/*     */       
/* 760 */       this.value = new WeakReference<>(value, WeakHashTable.this.queue);
/* 761 */       WeakHashTable.this.entryLookup.put(this.value, this);
/*     */     }
/*     */     
/*     */     public LispObject getValue() {
/* 765 */       return this.value.get();
/*     */     }
/*     */     
/*     */     public void setValue(LispObject value) {
/* 769 */       WeakReference<LispObject> old = this.value;
/* 770 */       old.clear();
/* 771 */       this.value = new WeakReference<>(value, WeakHashTable.this.queue);
/* 772 */       WeakHashTable.this.entryLookup.put(this.value, this);
/*     */     }
/*     */     
/*     */     HashEntryWeakValue[] makeArray(int length) {
/* 776 */       return new HashEntryWeakValue[length];
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     HashEntryWeakValue makeInstance(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 782 */       return new HashEntryWeakValue(key, hash, value, next, slot);
/*     */     }
/*     */     
/*     */     void expungeQueue() {
/* 786 */       Reference<? extends LispObject> ref = WeakHashTable.this.queue.poll();
/* 787 */       while (ref != null) {
/* 788 */         WeakHashTable.this.remove(ref);
/* 789 */         WeakHashTable.this.entryLookup.remove(ref);
/* 790 */         ref = WeakHashTable.this.queue.poll();
/*     */       } 
/*     */     }
/*     */ 
/*     */     
/*     */     void clear() {
/* 796 */       this.value.clear();
/* 797 */       assert WeakHashTable.this.entryLookup.containsKey(this.value) : "Value was not in lookup table.";
/*     */       
/* 799 */       WeakHashTable.this.entryLookup.remove(this.value);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   class HashEntryWeakKeyAndValue
/*     */     extends HashEntry
/*     */   {
/*     */     private WeakReference<LispObject> key;
/*     */     
/*     */     private WeakReference<LispObject> value;
/*     */ 
/*     */     
/*     */     public HashEntryWeakKeyAndValue() {}
/*     */     
/*     */     public HashEntryWeakKeyAndValue(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 815 */       this.hash = hash;
/* 816 */       this.next = next;
/* 817 */       this.slot = slot;
/*     */       
/* 819 */       this.key = new WeakReference<>(key, WeakHashTable.this.queue);
/* 820 */       WeakHashTable.this.entryLookup.put(this.key, this);
/*     */       
/* 822 */       this.value = new WeakReference<>(value, WeakHashTable.this.queue);
/* 823 */       WeakHashTable.this.entryLookup.put(this.value, this);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject getKey() {
/* 828 */       return this.key.get();
/*     */     }
/*     */     
/*     */     public void setKey(LispObject key) {
/* 832 */       WeakReference<LispObject> old = this.key;
/* 833 */       WeakHashTable.this.entryLookup.remove(old);
/* 834 */       old.clear();
/* 835 */       this.key = new WeakReference<>(key, WeakHashTable.this.queue);
/* 836 */       WeakHashTable.this.entryLookup.put(this.key, this);
/*     */     }
/*     */     
/*     */     public LispObject getValue() {
/* 840 */       return this.value.get();
/*     */     }
/*     */     
/*     */     public void setValue(LispObject value) {
/* 844 */       WeakReference<LispObject> old = this.value;
/* 845 */       WeakHashTable.this.entryLookup.remove(old);
/* 846 */       old.clear();
/* 847 */       this.value = new WeakReference<>(value, WeakHashTable.this.queue);
/* 848 */       WeakHashTable.this.entryLookup.put(this.value, this);
/*     */     }
/*     */     
/*     */     HashEntryWeakKeyAndValue[] makeArray(int length) {
/* 852 */       return new HashEntryWeakKeyAndValue[length];
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     HashEntryWeakKeyAndValue makeInstance(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 859 */       return new HashEntryWeakKeyAndValue(key, hash, value, next, slot);
/*     */     }
/*     */     
/*     */     void expungeQueue() {
/* 863 */       Reference<? extends LispObject> ref = WeakHashTable.this.queue.poll();
/* 864 */       while (ref != null) {
/* 865 */         WeakHashTable.HashEntry entry = WeakHashTable.this.entryLookup.get(ref);
/* 866 */         if (entry == null) {
/* 867 */           ref = WeakHashTable.this.queue.poll();
/*     */           continue;
/*     */         } 
/* 870 */         if (entry.getKey() == null && entry
/* 871 */           .getValue() == null) {
/* 872 */           WeakHashTable.this.remove(ref);
/* 873 */           WeakHashTable.this.entryLookup.remove(ref);
/*     */         } else {
/* 875 */           WeakHashTable.this.entryLookup.remove(ref);
/*     */         } 
/* 877 */         ref = WeakHashTable.this.queue.poll();
/*     */       } 
/*     */     }
/*     */ 
/*     */     
/*     */     void clear() {
/* 883 */       this.key.clear();
/* 884 */       this.value.clear();
/* 885 */       WeakHashTable.this.entryLookup.remove(this.key);
/* 886 */       WeakHashTable.this.entryLookup.remove(this.value);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   class HashEntryWeakKeyOrValue
/*     */     extends HashEntryWeakKeyAndValue
/*     */   {
/*     */     public HashEntryWeakKeyOrValue() {}
/*     */ 
/*     */     
/*     */     public HashEntryWeakKeyOrValue(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 899 */       super(key, hash, value, next, slot);
/*     */     }
/*     */     HashEntryWeakKeyOrValue[] makeArray(int length) {
/* 902 */       return new HashEntryWeakKeyOrValue[length];
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     HashEntryWeakKeyOrValue makeInstance(LispObject key, int hash, LispObject value, WeakHashTable.HashEntry next, int slot) {
/* 909 */       return new HashEntryWeakKeyOrValue(key, hash, value, next, slot);
/*     */     }
/*     */     
/*     */     void expungeQueue() {
/* 913 */       Reference<? extends LispObject> ref = WeakHashTable.this.queue.poll();
/* 914 */       while (ref != null) {
/* 915 */         WeakHashTable.HashEntry entry = WeakHashTable.this.entryLookup.get(ref);
/* 916 */         if (entry == null) {
/* 917 */           ref = WeakHashTable.this.queue.poll();
/*     */           continue;
/*     */         } 
/* 920 */         WeakHashTable.this.remove(ref);
/* 921 */         WeakHashTable.this.entryLookup.remove(entry.key);
/* 922 */         WeakHashTable.this.entryLookup.remove(entry.value);
/* 923 */         ref = WeakHashTable.this.queue.poll();
/*     */       } 
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 931 */     long result = 2062775257L;
/* 932 */     result = Lisp.mix(result, this.count);
/* 933 */     result = Lisp.mix(result, getTest().sxhash());
/* 934 */     return (int)(result & 0x7FFFFFFFL);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/WeakHashTable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */