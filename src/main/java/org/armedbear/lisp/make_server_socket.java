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
/*    */ public final class make_server_socket
/*    */   extends Primitive
/*    */ {
/*    */   private make_server_socket() {
/* 45 */     super("%make-server-socket", Lisp.PACKAGE_SYS, false, "port element-type");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first) {
/* 52 */     int port = Fixnum.getValue(first);
/*    */     try {
/* 54 */       ServerSocket socket = new ServerSocket(port);
/* 55 */       return new JavaObject(socket);
/*    */     }
/* 57 */     catch (Exception e) {
/* 58 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */   
/* 62 */   private static final Primitive MAKE_SERVER_SOCKET = new make_server_socket();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/make_server_socket.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */