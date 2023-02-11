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
/*    */ public final class listen
/*    */   extends Primitive
/*    */ {
/*    */   private listen() {
/* 43 */     super("listen", "&optional input-stream");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 50 */     Stream stream = Lisp.checkCharacterInputStream(Symbol.STANDARD_INPUT.symbolValue());
/* 51 */     return stream.listen();
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 57 */     return Lisp.inSynonymOf(arg).listen();
/*    */   }
/*    */   
/* 60 */   private static final Primitive LISTEN = new listen();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/listen.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */