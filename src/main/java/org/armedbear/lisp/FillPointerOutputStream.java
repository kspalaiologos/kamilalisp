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
/*    */ public final class FillPointerOutputStream
/*    */   extends Stream
/*    */ {
/*    */   ComplexString string;
/*    */   
/*    */   FillPointerOutputStream(ComplexString string) {
/* 44 */     super(Symbol.SYSTEM_STREAM);
/* 45 */     this.elementType = Symbol.CHARACTER;
/* 46 */     this.isOutputStream = true;
/* 47 */     this.isInputStream = false;
/* 48 */     this.isCharacterStream = true;
/* 49 */     this.isBinaryStream = false;
/* 50 */     this.string = string;
/* 51 */     setWriter(new Writer());
/*    */   }
/*    */ 
/*    */   
/* 55 */   private static final Primitive MAKE_FILL_POINTER_OUTPUT_STREAM = new Primitive("make-fill-pointer-output-stream", Lisp.PACKAGE_SYS, true)
/*    */     {
/*    */ 
/*    */       
/*    */       public LispObject execute(LispObject arg)
/*    */       {
/* 61 */         if (arg instanceof ComplexString) {
/* 62 */           ComplexString string = (ComplexString)arg;
/* 63 */           if (string.getFillPointer() >= 0)
/* 64 */             return new FillPointerOutputStream(string); 
/*    */         } 
/* 66 */         return Lisp.type_error(arg, Lisp.list(Symbol.AND, new LispObject[] { Symbol.STRING, 
/* 67 */                 Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.ARRAY_HAS_FILL_POINTER_P }) }));
/*    */       }
/*    */     };
/*    */ 
/*    */ 
/*    */   
/*    */   class Writer
/*    */     extends java.io.Writer
/*    */   {
/*    */     public void write(char[] cbuf, int off, int len) {
/* 77 */       int fp = FillPointerOutputStream.this.string.getFillPointer();
/* 78 */       if (fp >= 0) {
/* 79 */         int limit = Math.min(cbuf.length, off + len);
/* 80 */         FillPointerOutputStream.this.string.ensureCapacity(fp + limit);
/* 81 */         for (int i = off; i < limit; i++) {
/* 82 */           FillPointerOutputStream.this.string.setCharAt(fp, cbuf[i]);
/* 83 */           fp++;
/*    */         } 
/*    */       } 
/* 86 */       FillPointerOutputStream.this.string.setFillPointer(fp);
/*    */     }
/*    */     
/*    */     public void flush() {}
/*    */     
/*    */     public void close() {}
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FillPointerOutputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */