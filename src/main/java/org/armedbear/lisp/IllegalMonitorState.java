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
/*    */ public final class IllegalMonitorState
/*    */   extends ProgramError
/*    */ {
/*    */   String message;
/*    */   
/*    */   public IllegalMonitorState() {
/* 45 */     super(StandardClass.PROGRAM_ERROR);
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
/* 62 */     this.message = "Illegal monitor state."; setFormatControl(getMessage().replaceAll("~", "~~")); setFormatArguments(Lisp.NIL); } public IllegalMonitorState(String message) { super(StandardClass.PROGRAM_ERROR); this.message = "Illegal monitor state.";
/*    */     if (message != null)
/*    */       this.message = message; 
/*    */     setFormatControl(getMessage().replaceAll("~", "~~"));
/*    */     setFormatArguments(Lisp.NIL); } public String getMessage() {
/* 67 */     return this.message;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/IllegalMonitorState.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */