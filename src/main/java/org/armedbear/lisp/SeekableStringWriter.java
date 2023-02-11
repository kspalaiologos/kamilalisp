/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.IOException;
/*     */ import java.io.Writer;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class SeekableStringWriter
/*     */   extends Writer
/*     */ {
/*     */   private final StringBuffer stringBuffer;
/*  43 */   private int offset = 0;
/*     */   
/*     */   public SeekableStringWriter() {
/*  46 */     this.stringBuffer = new StringBuffer();
/*     */   }
/*     */   
/*     */   public SeekableStringWriter(int initialSize) {
/*  50 */     this.stringBuffer = new StringBuffer(initialSize);
/*     */   }
/*     */   
/*     */   public SeekableStringWriter append(char c) {
/*  54 */     write(c);
/*  55 */     return this;
/*     */   }
/*     */   
/*     */   public SeekableStringWriter append(CharSequence csq) {
/*  59 */     write(csq.toString());
/*  60 */     return this;
/*     */   }
/*     */   
/*     */   public SeekableStringWriter append(CharSequence csq, int start, int end) {
/*  64 */     write(csq.subSequence(start, end).toString());
/*  65 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public void write(char[] cbuf) {
/*  70 */     _write(cbuf, 0, cbuf.length);
/*     */   }
/*     */ 
/*     */   
/*     */   public void write(char[] cbuf, int off, int len) {
/*  75 */     int bufLen = cbuf.length;
/*     */     
/*  77 */     if (off < 0 || off > bufLen || len < 0 || off + len > bufLen) {
/*  78 */       throw new IllegalArgumentException();
/*     */     }
/*  80 */     _write(cbuf, off, len);
/*     */   }
/*     */ 
/*     */   
/*     */   public void write(int c) {
/*     */     try {
/*  86 */       if (this.offset == this.stringBuffer.length()) {
/*  87 */         this.stringBuffer.append((char)c);
/*     */       } else {
/*  89 */         this.stringBuffer.setCharAt(this.offset, (char)c);
/*  90 */       }  this.offset++;
/*  91 */     } catch (IndexOutOfBoundsException e) {
/*  92 */       Lisp.error(new JavaException(e));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void write(String str) {
/*  98 */     write(str, 0, str.length());
/*     */   }
/*     */ 
/*     */   
/*     */   public void write(String str, int off, int len) {
/* 103 */     write(str.toCharArray(), off, len);
/*     */   }
/*     */   
/*     */   private void _write(char[] cbuf, int off, int len) {
/* 107 */     int strLen = this.stringBuffer.length();
/* 108 */     int space = strLen - this.offset;
/*     */     
/* 110 */     int written = Math.min(len, space);
/*     */     
/* 112 */     if (written > 0) {
/* 113 */       this.stringBuffer.replace(this.offset, this.offset + written, new String(cbuf, off, written));
/*     */     }
/* 115 */     if (written < len) {
/* 116 */       this.stringBuffer.append(cbuf, off + written, len - written);
/*     */     }
/* 118 */     this.offset += len;
/*     */   }
/*     */   
/*     */   public void seek(int offset) {
/* 122 */     if (offset < 0 || offset > this.stringBuffer.length())
/* 123 */       throw new IllegalArgumentException(); 
/* 124 */     this.offset = offset;
/*     */   }
/*     */   
/*     */   public StringBuffer getBuffer() {
/* 128 */     return this.stringBuffer;
/*     */   }
/*     */   
/*     */   public int getOffset() {
/* 132 */     return this.offset;
/*     */   }
/*     */ 
/*     */   
/*     */   public String toString() {
/* 137 */     return this.stringBuffer.toString();
/*     */   }
/*     */ 
/*     */   
/*     */   public void close() {}
/*     */ 
/*     */   
/*     */   public void flush() {}
/*     */   
/*     */   public String toStringAndClear() {
/* 147 */     String result = this.stringBuffer.toString();
/* 148 */     this.stringBuffer.delete(0, this.stringBuffer.length());
/* 149 */     this.offset = 0;
/* 150 */     return result;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SeekableStringWriter.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */