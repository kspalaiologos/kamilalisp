/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.concurrent.ConcurrentHashMap;
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
/*     */ public final class EMFCache
/*     */   extends LispObject
/*     */ {
/*  41 */   ConcurrentHashMap<CacheEntry, LispObject> cache = new ConcurrentHashMap<>();
/*     */   
/*  43 */   EqlSpecialization[] eqlSpecializations = new EqlSpecialization[0];
/*     */ 
/*     */   
/*     */   void clearCache() {
/*  47 */     this.cache = new ConcurrentHashMap<>();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*  53 */     return unreadableString("EMF-CACHE");
/*     */   }
/*     */ 
/*     */   
/*     */   static final FuncallableStandardObject checkStandardGenericFunction(LispObject obj) {
/*  58 */     if (obj instanceof FuncallableStandardObject)
/*  59 */       return (FuncallableStandardObject)obj; 
/*  60 */     return 
/*  61 */       (FuncallableStandardObject)Lisp.type_error(obj, Symbol.STANDARD_GENERIC_FUNCTION);
/*     */   }
/*     */   
/*     */   private static class EqlSpecialization
/*     */     extends LispObject
/*     */   {
/*     */     public LispObject eqlTo;
/*     */     
/*     */     public EqlSpecialization(LispObject eqlTo) {
/*  70 */       this.eqlTo = eqlTo;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   private static class CacheEntry
/*     */   {
/*     */     final LispObject[] array;
/*     */     
/*     */     CacheEntry(LispObject[] array) {
/*  80 */       this.array = array;
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public int hashCode() {
/*  86 */       int result = 0;
/*  87 */       for (int i = this.array.length; i-- > 0;)
/*  88 */         result ^= this.array[i].hashCode(); 
/*  89 */       return result;
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public boolean equals(Object object) {
/*  95 */       if (!(object instanceof CacheEntry))
/*  96 */         return false; 
/*  97 */       CacheEntry otherEntry = (CacheEntry)object;
/*  98 */       if (otherEntry.array.length != this.array.length)
/*  99 */         return false; 
/* 100 */       LispObject[] otherArray = otherEntry.array;
/* 101 */       for (int i = this.array.length; i-- > 0;) {
/* 102 */         if (this.array[i] != otherArray[i])
/* 103 */           return false; 
/* 104 */       }  return true;
/*     */     }
/*     */   }
/*     */   
/* 108 */   private static final Primitive _MAKE_EMF_CACHE = new pf__make_emf_cache();
/*     */   
/*     */   @DocString(name = "%make-emf-cache")
/*     */   private static final class pf__make_emf_cache
/*     */     extends Primitive
/*     */   {
/*     */     pf__make_emf_cache() {
/* 115 */       super("%make-emf-cache", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 120 */       return new EMFCache();
/*     */     }
/*     */   }
/*     */   
/* 124 */   private static final Primitive _REINIT_EMF_CACHE = new pf__reinit_emf_cache();
/*     */ 
/*     */   
/*     */   @DocString(name = "%reinit-emf-cache", args = "generic-function eql-specilizer-objects-list")
/*     */   private static final class pf__reinit_emf_cache
/*     */     extends Primitive
/*     */   {
/*     */     pf__reinit_emf_cache() {
/* 132 */       super("%reinit-emf-cache", Lisp.PACKAGE_SYS, true, "generic-function eql-specializer-objects-list");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject generic_function, LispObject eql_specializers) {
/* 138 */       FuncallableStandardObject gf = EMFCache.checkStandardGenericFunction(generic_function);
/* 139 */       EMFCache cache = gf.cache;
/* 140 */       cache.clearCache();
/* 141 */       cache.eqlSpecializations = new EMFCache.EqlSpecialization[eql_specializers.length()];
/* 142 */       for (int i = 0; i < cache.eqlSpecializations.length; i++) {
/* 143 */         cache.eqlSpecializations[i] = new EMFCache.EqlSpecialization(eql_specializers.car());
/* 144 */         eql_specializers = eql_specializers.cdr();
/*     */       } 
/* 146 */       return Lisp.T;
/*     */     }
/*     */   }
/*     */   
/* 150 */   private static final Primitive CACHE_EMF = new pf_cache_emf();
/*     */ 
/*     */   
/*     */   @DocString(name = "cache-emf", args = "generic-function args emf")
/*     */   private static final class pf_cache_emf
/*     */     extends Primitive
/*     */   {
/*     */     pf_cache_emf() {
/* 158 */       super("cache-emf", Lisp.PACKAGE_SYS, true, "generic-function args emf");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 164 */       FuncallableStandardObject gf = EMFCache.checkStandardGenericFunction(first);
/* 165 */       EMFCache cache = gf.cache;
/* 166 */       LispObject args = second;
/*     */       
/* 168 */       int numberOfRequiredArgs = gf.getInstanceSlotValue(Symbol.REQUIRED_ARGS).length();
/* 169 */       LispObject[] array = new LispObject[numberOfRequiredArgs];
/* 170 */       for (int i = numberOfRequiredArgs; i-- > 0; ) {
/*     */         
/* 172 */         array[i] = cache.getArgSpecialization(args.car());
/* 173 */         args = args.cdr();
/*     */       } 
/* 175 */       EMFCache.CacheEntry specializations = new EMFCache.CacheEntry(array);
/* 176 */       ConcurrentHashMap<EMFCache.CacheEntry, LispObject> ht = cache.cache;
/* 177 */       ht.put(specializations, third);
/* 178 */       return third;
/*     */     }
/*     */   }
/*     */   
/* 182 */   private static final Primitive GET_CACHED_EMF = new pf_get_cached_emf();
/*     */   
/*     */   @DocString(name = "get-cached-emf", args = "generic-function args")
/*     */   private static final class pf_get_cached_emf
/*     */     extends Primitive
/*     */   {
/*     */     pf_get_cached_emf() {
/* 189 */       super("get-cached-emf", Lisp.PACKAGE_SYS, true, "generic-function args");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 194 */       FuncallableStandardObject gf = EMFCache.checkStandardGenericFunction(first);
/* 195 */       EMFCache cache = gf.cache;
/* 196 */       LispObject args = second;
/*     */       
/* 198 */       int numberOfRequiredArgs = gf.getInstanceSlotValue(Symbol.REQUIRED_ARGS).length();
/* 199 */       LispObject[] array = new LispObject[numberOfRequiredArgs];
/* 200 */       for (int i = numberOfRequiredArgs; i-- > 0; ) {
/*     */         
/* 202 */         array[i] = cache.getArgSpecialization(args.car());
/* 203 */         args = args.cdr();
/*     */       } 
/* 205 */       EMFCache.CacheEntry specializations = new EMFCache.CacheEntry(array);
/* 206 */       ConcurrentHashMap<EMFCache.CacheEntry, LispObject> ht = cache.cache;
/* 207 */       LispObject emf = ht.get(specializations);
/* 208 */       return (emf != null) ? emf : Lisp.NIL;
/*     */     }
/*     */   }
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
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   LispObject getArgSpecialization(LispObject arg) {
/* 270 */     for (EqlSpecialization eqlSpecialization : this.eqlSpecializations) {
/*     */       
/* 272 */       if (eqlSpecialization.eqlTo.eql(arg))
/* 273 */         return eqlSpecialization; 
/*     */     } 
/* 275 */     return arg.classOf();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/EMFCache.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */