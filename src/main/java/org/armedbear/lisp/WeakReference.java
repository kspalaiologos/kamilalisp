/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.lang.ref.WeakReference;
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
/*     */ public class WeakReference
/*     */   extends LispObject
/*     */ {
/*     */   WeakReference<LispObject> ref;
/*     */   
/*     */   public WeakReference(LispObject ref) {
/*  42 */     this.ref = new WeakReference<>(ref);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  47 */     return Symbol.WEAK_REFERENCE;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  52 */     return BuiltInClass.WEAK_REFERENCE;
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/*  57 */     return unreadableString("WEAK-REFERENCE " + 
/*  58 */         toString());
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  63 */     if (typeSpecifier == Symbol.WEAK_REFERENCE) {
/*  64 */       return Lisp.T;
/*     */     }
/*  66 */     if (typeSpecifier == BuiltInClass.WEAK_REFERENCE) {
/*  67 */       return Lisp.T;
/*     */     }
/*  69 */     return super.typep(typeSpecifier);
/*     */   }
/*     */   
/*  72 */   private static final Primitive MAKE_WEAK_REFERENCE = new pf_make_weak_reference();
/*     */ 
/*     */   
/*     */   @DocString(name = "make-weak-reference", args = "obj", doc = "Creates a weak reference to 'obj'.")
/*     */   private static final class pf_make_weak_reference
/*     */     extends Primitive
/*     */   {
/*     */     pf_make_weak_reference() {
/*  80 */       super("make-weak-reference", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject obj) {
/*  85 */       return new WeakReference(obj);
/*     */     }
/*     */   }
/*     */   
/*  89 */   private static final Primitive WEAK_REFERENCE_VALUE = new pf_weak_reference_value();
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "weak-reference-value", args = "obj", doc = "Returns two values, the first being the value of the weak ref,the second T if the reference is valid, or NIL if it hasbeen cleared.")
/*     */   private static final class pf_weak_reference_value
/*     */     extends Primitive
/*     */   {
/*     */     pf_weak_reference_value() {
/*  99 */       super("weak-reference-value", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject obj) {
/* 104 */       if (!(obj instanceof WeakReference)) {
/* 105 */         return Lisp.type_error(obj, Symbol.WEAK_REFERENCE);
/*     */       }
/* 107 */       LispObject value = ((WeakReference)obj).ref.get();
/* 108 */       return LispThread.currentThread().setValues((value == null) ? Lisp.NIL : value, (value == null) ? Lisp.NIL : Lisp.T);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/WeakReference.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */