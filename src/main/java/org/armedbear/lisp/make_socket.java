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
/*    */ public final class make_socket
/*    */   extends Primitive
/*    */ {
/*    */   private make_socket() {
/* 45 */     super("%make-socket", Lisp.PACKAGE_SYS, false, "host port");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 52 */     String host = first.getStringValue();
/* 53 */     int port = Fixnum.getValue(second);
/*    */     try {
/* 55 */       Socket socket = new Socket(host, port);
/* 56 */       return new JavaObject(socket);
/*    */     }
/* 58 */     catch (Exception e) {
/* 59 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */   
/* 63 */   private static final Primitive MAKE_SOCKET = new make_socket();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/make_socket.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */