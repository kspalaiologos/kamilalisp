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
/*    */ public class ProgramError
/*    */   extends LispError
/*    */ {
/*    */   protected ProgramError(LispClass cls) {
/* 42 */     super(cls);
/*    */   }
/*    */ 
/*    */   
/*    */   public ProgramError(LispObject initArgs) {
/* 47 */     super(StandardClass.PROGRAM_ERROR);
/* 48 */     initialize(initArgs);
/*    */     
/* 50 */     if (initArgs.listp() && initArgs.car().stringp()) {
/* 51 */       setFormatControl(initArgs.car().getStringValue());
/* 52 */       setFormatArguments(initArgs.cdr());
/*    */     } 
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public ProgramError(String message) {
/* 59 */     super(StandardClass.PROGRAM_ERROR);
/* 60 */     setFormatControl(message.replaceAll("~", "~~"));
/* 61 */     setFormatArguments(Lisp.NIL);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 67 */     return Symbol.PROGRAM_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 73 */     return StandardClass.PROGRAM_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 79 */     if (type == Symbol.PROGRAM_ERROR)
/* 80 */       return Lisp.T; 
/* 81 */     if (type == StandardClass.PROGRAM_ERROR)
/* 82 */       return Lisp.T; 
/* 83 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ProgramError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */