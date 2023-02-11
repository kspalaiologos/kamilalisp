/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class get_properties
/*    */   extends Primitive
/*    */ {
/*    */   private get_properties() {
/* 43 */     super(Symbol.GET_PROPERTIES, "plist indicator-list");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 50 */     LispThread thread = LispThread.currentThread();
/* 51 */     LispObject plist = first;
/* 52 */     while (plist != Lisp.NIL) {
/*    */       
/* 54 */       if (plist.cdr() instanceof Cons) {
/*    */         
/* 56 */         LispObject indicator = ((Cons)plist).car;
/* 57 */         LispObject indicators = second;
/* 58 */         while (indicators instanceof Cons) {
/*    */           
/* 60 */           if (indicator == ((Cons)indicators).car)
/* 61 */             return thread.setValues(indicator, plist.cadr(), plist); 
/* 62 */           indicators = ((Cons)indicators).cdr;
/*    */         } 
/* 64 */         if (indicators != Lisp.NIL)
/* 65 */           return Lisp.type_error(indicators, Symbol.LIST); 
/* 66 */         plist = plist.cddr();
/*    */         continue;
/*    */       } 
/* 69 */       return Lisp.type_error(plist.cdr(), Symbol.CONS);
/*    */     } 
/* 71 */     return thread.setValues(Lisp.NIL, Lisp.NIL, Lisp.NIL);
/*    */   }
/*    */   
/* 74 */   private static final Primitive GET_PROPERTIES = new get_properties();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/get_properties.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */