/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.net.ServerSocket;
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
/*    */ public final class server_socket_close
/*    */   extends Primitive
/*    */ {
/*    */   private server_socket_close() {
/* 45 */     super("%server-socket-close", Lisp.PACKAGE_SYS, false, "socket");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first) {
/*    */     try {
/* 53 */       ServerSocket serverSocket = (ServerSocket)JavaObject.getObject(first);
/* 54 */       serverSocket.close();
/* 55 */       return Lisp.T;
/*    */     }
/* 57 */     catch (Exception e) {
/* 58 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */   
/* 62 */   private static final Primitive SERVER_SOCKET_CLOSE = new server_socket_close();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/server_socket_close.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */