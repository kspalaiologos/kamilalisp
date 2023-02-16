/*     */ package org.armedbear.lisp.util;
/*     */ 
/*     */ import palaiologos.kamilalisp.runtime.cas.meta.FriCAS;

import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.PushbackInputStream;
/*     */ import java.io.PushbackReader;
/*     */ import java.io.Reader;
/*     */ import java.io.StringReader;
/*     */ import java.nio.ByteBuffer;
/*     */ import java.nio.CharBuffer;
/*     */ import java.nio.charset.Charset;
/*     */ import java.nio.charset.CharsetDecoder;
/*     */ import java.nio.charset.CharsetEncoder;
/*     */ import java.nio.charset.CoderResult;
/*     */ import java.nio.charset.CodingErrorAction;
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
/*     */ public class DecodingReader
/*     */   extends PushbackReader
/*     */ {
/*  63 */   private static Reader staticReader = new StringReader("");
/*     */ 
/*     */   public boolean isStdin = false;
/*     */   private ByteBuffer bbuf;
/*     */ 
/*     */   
/*     */   private PushbackInputStream stream;
/*     */ 
/*     */   
/*     */   private CharsetDecoder cd;
/*     */   
/*     */   private CharsetEncoder ce;
/*     */ 
/*     */   
/*     */   public DecodingReader(InputStream stream, int size, Charset cs) {
/*  78 */     super(staticReader);
/*     */ 
/*     */     
/*  81 */     this.stream = new PushbackInputStream(stream, size);
/*  82 */     this.cd = cs.newDecoder();
/*  83 */     this.cd.onUnmappableCharacter(CodingErrorAction.REPLACE);
/*  84 */     this.cd.onMalformedInput(CodingErrorAction.REPLACE);
/*  85 */     this.ce = cs.newEncoder();
/*  86 */     this.bbuf = ByteBuffer.allocate(size);
/*  87 */     this.bbuf.flip();

                if(stream == FriCAS.nis) {
                    this.isStdin = true;
                }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setCharset(Charset cs) {
/*  94 */     this.cd = cs.newDecoder();
/*  95 */     this.cd.onUnmappableCharacter(CodingErrorAction.REPLACE);
/*  96 */     this.cd.onMalformedInput(CodingErrorAction.REPLACE);
/*  97 */     this.ce = cs.newEncoder();
/*     */   }
/*     */ 
/*     */   
/*     */   public final Charset getCharset() {
/* 102 */     return this.cd.charset();
/*     */   }
/*     */ 
/*     */   
/*     */   public final void close() throws IOException {
/* 107 */     this.stream.close();
/*     */   }
/*     */ 
/*     */   
/*     */   public final void mark(int readAheadLimit) throws IOException {
/* 112 */     throw new IOException("mark/reset not supported.");
/*     */   }
/*     */ 
/*     */   
/*     */   public final boolean markSupported() {
/* 117 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public final boolean ready() throws IOException {
/* 122 */     return (this.stream.available() != 0 || this.bbuf.remaining() != 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public final void reset() throws IOException {
/* 127 */     throw new IOException("reset/mark not supported.");
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final long skip(long n) throws IOException {
/* 137 */     char[] cbuf = new char[(int)Math.min(4096L, n)];
/* 138 */     long m = n;
/*     */     
/* 140 */     while (m > 0L) {
/* 141 */       int r = read(cbuf, 0, (int)Math.min(cbuf.length, m));
/*     */       
/* 143 */       if (r < 0) {
/* 144 */         return n - m;
/*     */       }
/* 146 */       m += Math.min(cbuf.length, m);
/*     */     } 
/*     */     
/* 149 */     return n;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final void unread(int c) throws IOException {
/* 160 */     char[] ch = Character.toChars(c);
/* 161 */     unread(ch, 0, ch.length);
/*     */   }
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
/*     */   public final void unread(char[] cbuf, int off, int len) throws IOException {
/* 174 */     ByteBuffer tb = this.ce.encode(CharBuffer.wrap(cbuf, off, len));
/*     */     
/* 176 */     if (tb.limit() > this.bbuf.position()) {
/*     */ 
/*     */       
/* 179 */       for (int i = this.bbuf.limit(); i-- > this.bbuf.position();) {
/* 180 */         this.stream.unread(this.bbuf.get(i));
/*     */       }
/* 182 */       this.bbuf.clear();
/* 183 */       this.ce.encode(CharBuffer.wrap(cbuf, off, len), this.bbuf, true);
/* 184 */       this.bbuf.flip();
/*     */     }
/*     */     else {
/*     */       
/* 188 */       int j = this.bbuf.position() - 1;
/* 189 */       for (int i = tb.limit(); i-- > 0; j--) {
/* 190 */         this.bbuf.put(j, tb.get(i));
/*     */       }
/* 192 */       this.bbuf.position(j + 1);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public final void unread(char[] cbuf) throws IOException {
/* 198 */     unread(cbuf, 0, cbuf.length);
/*     */   }
/*     */ 
/*     */   
/*     */   private boolean ensureBbuf(boolean force) throws IOException {
/* 203 */     if (this.bbuf.remaining() == 0 || force) {
/* 204 */       this.bbuf.compact();
/*     */       
/* 206 */       int size = this.stream.available();
/* 207 */       if (size > this.bbuf.remaining() || size == 0)
/*     */       {
/*     */ 
/*     */         
/* 211 */         size = this.bbuf.remaining();
/*     */       }
/* 213 */       byte[] by = new byte[size];
/* 214 */       int c = this.stream.read(by);
/*     */       
/* 216 */       if (c < 0) {
/* 217 */         this.bbuf.flip();
/* 218 */         return false;
/*     */       } 
/*     */       
/* 221 */       this.bbuf.put(by, 0, c);
/* 222 */       this.bbuf.flip();
/*     */     } 
/* 224 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int read() throws IOException {
/* 230 */     char[] ch = new char[1];
/*     */     
/* 232 */     int i = read(ch, 0, 1);
/* 233 */     if (i < 0) {
/* 234 */       return i;
/*     */     }
/*     */ 
/*     */     
/* 238 */     if (!Character.isHighSurrogate(ch[0])) {
/* 239 */       return ch[0];
/*     */     }
/*     */     
/* 242 */     char high = ch[0];
/* 243 */     i = read(ch, 0, 1);
/* 244 */     if (i < 0) {
/* 245 */       return i;
/*     */     }
/*     */     
/* 248 */     return Character.toCodePoint(high, ch[0]);
/*     */   }
/*     */ 
/*     */   
/*     */   public final int read(char[] cbuf, int off, int len) throws IOException {
/* 253 */     CharBuffer cb = CharBuffer.wrap(cbuf, off, len);
/* 254 */     return read(cb);
/*     */   }
/*     */ 
/*     */   
/*     */   public final int read(CharBuffer cb) throws IOException {
/* 259 */     int len = cb.remaining();
/* 260 */     boolean notEof = true;
/* 261 */     boolean forceRead = false;
/*     */ 
/*     */     
/* 264 */     while (cb.remaining() > 0 && notEof) {
/* 265 */       int oldRemaining = cb.remaining();
/* 266 */       notEof = ensureBbuf(forceRead);
/* 267 */       CoderResult r = this.cd.decode(this.bbuf, cb, !notEof);
/* 268 */       if (oldRemaining == cb.remaining() && CoderResult.OVERFLOW == r) {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */         
/* 278 */         cb.put('?');
/* 279 */         this.bbuf.get();
/*     */       } 
/* 281 */       forceRead = (CoderResult.UNDERFLOW == r);
/*     */     } 
/* 283 */     if (cb.remaining() == len) {
/* 284 */       return -1;
/*     */     }
/* 286 */     return len - cb.remaining();
/*     */   }
/*     */ 
/*     */   
/*     */   public final int read(char[] cbuf) throws IOException {
/* 291 */     return read(cbuf, 0, cbuf.length);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/util/DecodingReader.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */