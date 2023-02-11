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
/*    */ public final class socket_stream
/*    */   extends Primitive
/*    */ {
/*    */   private socket_stream() {
/* 45 */     super("%socket-stream", Lisp.PACKAGE_SYS, false, "socket element-type external-format");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 52 */     Socket socket = (Socket)((JavaObject)first).getObject();
/* 53 */     LispObject elementType = second;
/*    */     
/*    */     try {
/* 56 */       Stream in = new Stream(Symbol.SYSTEM_STREAM, socket.getInputStream(), elementType, third);
/*    */       
/* 58 */       Stream out = new Stream(Symbol.SYSTEM_STREAM, socket.getOutputStream(), elementType, third);
/* 59 */       return new SocketStream(socket, in, out);
/*    */     }
/* 61 */     catch (Exception e) {
/* 62 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */   
/* 66 */   private static final Primitive SOCKET_STREAM = new socket_stream();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/socket_stream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */