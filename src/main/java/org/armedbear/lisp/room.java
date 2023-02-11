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
/*    */ public final class room
/*    */   extends Primitive
/*    */ {
/*    */   private room() {
/* 43 */     super("room", "&optional x");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject[] args) {
/* 49 */     if (args.length > 1)
/* 50 */       return Lisp.error(new WrongNumberOfArgumentsException(this, -1, 1)); 
/* 51 */     Runtime runtime = Runtime.getRuntime();
/* 52 */     long total = runtime.totalMemory();
/* 53 */     long free = runtime.freeMemory();
/*    */     
/* 55 */     long used = total - free;
/* 56 */     Stream out = Lisp.getStandardOutput();
/* 57 */     StringBuffer sb = new StringBuffer("Total memory ");
/* 58 */     sb.append(total);
/* 59 */     sb.append(" bytes");
/* 60 */     sb.append(System.getProperty("line.separator"));
/* 61 */     sb.append(used);
/* 62 */     sb.append(" bytes used");
/* 63 */     sb.append(System.getProperty("line.separator"));
/* 64 */     sb.append(free);
/* 65 */     sb.append(" bytes free");
/* 66 */     sb.append(System.getProperty("line.separator"));
/* 67 */     out._writeString(sb.toString());
/* 68 */     out._finishOutput();
/* 69 */     return LispThread.currentThread().setValues(Lisp.number(used), 
/* 70 */         Lisp.number(total), Lisp.number(runtime.maxMemory()));
/*    */   }
/*    */   
/* 73 */   private static final Primitive ROOM = new room();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/room.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */