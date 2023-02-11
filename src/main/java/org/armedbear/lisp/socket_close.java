/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.net.Socket;
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
/*    */ public final class socket_close
/*    */   extends Primitive
/*    */ {
/*    */   private socket_close() {
/* 45 */     super("%socket-close", Lisp.PACKAGE_SYS, false, "socket");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first) {
/* 52 */     Socket socket = (Socket)JavaObject.getObject(first);
/*    */     try {
/* 54 */       socket.close();
/* 55 */       return Lisp.T;
/*    */     }
/* 57 */     catch (Exception e) {
/* 58 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */   
/* 62 */   private static final Primitive SOCKET_CLOSE = new socket_close();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/socket_close.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */