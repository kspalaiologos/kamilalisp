/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.net.ServerSocket;
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
/*    */ public final class socket_accept
/*    */   extends Primitive
/*    */ {
/*    */   private socket_accept() {
/* 46 */     super("%socket-accept", Lisp.PACKAGE_SYS, false, "socket");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first) {
/* 54 */     ServerSocket serverSocket = (ServerSocket)((JavaObject)first).getObject();
/*    */     try {
/* 56 */       Socket socket = serverSocket.accept();
/* 57 */       return new JavaObject(socket);
/*    */     }
/* 59 */     catch (Exception e) {
/* 60 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */   
/* 64 */   private static final Primitive SOCKET_ACCEPT = new socket_accept();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/socket_accept.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */