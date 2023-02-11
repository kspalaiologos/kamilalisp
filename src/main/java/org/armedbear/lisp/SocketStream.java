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
/*    */ public final class SocketStream
/*    */   extends TwoWayStream
/*    */ {
/*    */   private final Socket socket;
/*    */   
/*    */   public SocketStream(Socket socket, Stream in, Stream out) {
/* 46 */     super(in, out);
/* 47 */     this.socket = socket;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 53 */     return Symbol.SOCKET_STREAM;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 59 */     return BuiltInClass.SOCKET_STREAM;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 65 */     if (type == Symbol.SOCKET_STREAM)
/* 66 */       return Lisp.T; 
/* 67 */     if (type == BuiltInClass.SOCKET_STREAM)
/* 68 */       return Lisp.T; 
/* 69 */     return super.typep(type);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject close(LispObject abort) {
/*    */     try {
/* 76 */       this.socket.close();
/* 77 */       setOpen(false);
/* 78 */       return Lisp.T;
/* 79 */     } catch (Exception e) {
/* 80 */       return Lisp.error(new LispError(e.getMessage()));
/*    */     } 
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SocketStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */