/*     */ package org.armedbear.lisp.util;
/*     */ 
/*     */

import org.armedbear.lisp.Lisp;
import org.armedbear.lisp.LispObject;
import org.armedbear.lisp.SimpleError;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.channels.FileChannel;
import java.nio.charset.*;
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
/*     */ public class RandomAccessCharacterFile
/*     */ {
/*     */   private class RandomAccessInputStream
/*     */     extends PushbackInputStream
/*     */   {
/*     */     private byte[] read_buf;
/*     */     
/*     */     public RandomAccessInputStream() {
/*  68 */       super(null);
/*     */ 
/*     */       
/*  71 */       this.read_buf = new byte[1];
/*     */     }
/*     */     
/*     */     public final int read() throws IOException {
/*  75 */       int len = read(this.read_buf);
/*  76 */       if (len == 1)
/*     */       {
/*     */         
/*  79 */         return 0xFF & this.read_buf[0];
/*     */       }
/*  81 */       return -1;
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public final int read(byte[] b, int off, int len) throws IOException {
/*  89 */       return RandomAccessCharacterFile.this.read(b, off, len);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void unread(int b) throws IOException {
/*  94 */       RandomAccessCharacterFile.this.unreadByte((byte)b);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void unread(byte[] b, int off, int len) throws IOException {
/*  99 */       for (int i = 0; i < len; i++) {
/* 100 */         unread(b[off + i]);
/*     */       }
/*     */     }
/*     */     
/*     */     public final void unread(byte[] b) throws IOException {
/* 105 */       unread(b, 0, b.length);
/*     */     }
/*     */ 
/*     */     
/*     */     public final int available() throws IOException {
/* 110 */       return 
/* 111 */         (int)(RandomAccessCharacterFile.this.length() - RandomAccessCharacterFile.this.position());
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public final synchronized void mark(int readlimit) {}
/*     */ 
/*     */     
/*     */     public final boolean markSupported() {
/* 120 */       return false;
/*     */     }
/*     */ 
/*     */     
/*     */     public final synchronized void reset() throws IOException {
/* 125 */       throw new IOException("Operation not supported");
/*     */     }
/*     */ 
/*     */     
/*     */     public final long skip(long n) throws IOException {
/* 130 */       RandomAccessCharacterFile.this.position(RandomAccessCharacterFile.this.position() + n);
/* 131 */       return n;
/*     */     }
/*     */ 
/*     */     
/*     */     public final int read(byte[] b) throws IOException {
/* 136 */       return read(b, 0, b.length);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void close() throws IOException {
/* 141 */       RandomAccessCharacterFile.this.close();
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private class RandomAccessOutputStream
/*     */     extends OutputStream
/*     */   {
/* 150 */     private byte[] buf = new byte[1];
/*     */     public final void write(int b) throws IOException {
/* 152 */       this.buf[0] = (byte)b;
/* 153 */       RandomAccessCharacterFile.this.write(this.buf, 0, 1);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void write(byte[] b) throws IOException {
/* 158 */       RandomAccessCharacterFile.this.write(b, 0, b.length);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void write(byte[] b, int off, int len) throws IOException {
/* 163 */       RandomAccessCharacterFile.this.write(b, off, len);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void flush() throws IOException {
/* 168 */       RandomAccessCharacterFile.this.flush();
/*     */     }
/*     */ 
/*     */     
/*     */     public final void close() throws IOException {
/* 173 */       RandomAccessCharacterFile.this.close();
/*     */     } } static final int BUFSIZ = 4096; private RandomAccessWriter writer; private RandomAccessReader reader; private RandomAccessInputStream inputStream;
/*     */   private RandomAccessOutputStream outputStream;
/*     */   private FileChannel fcn;
/*     */   private Charset cset;
/*     */   private CharsetEncoder cenc;
/* 179 */   static Reader staticReader = new StringReader(""); private CharsetDecoder cdec; private ByteBuffer bbuf; private boolean bbufIsDirty;
/*     */   private boolean bbufIsReadable;
/*     */   private long bbufpos;
/*     */   private CharBuffer singleCharBuf;
/*     */   private ByteBuffer shortByteBuf;
/*     */   
/*     */   private class RandomAccessReader extends PushbackReader { RandomAccessReader() {
/* 186 */       super(RandomAccessCharacterFile.staticReader);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 194 */       this.read_buf = new char[1];
/*     */     } private char[] read_buf; public final void close() throws IOException {
/*     */       RandomAccessCharacterFile.this.close();
/*     */     } public final int read() throws IOException {
/* 198 */       int n = read(this.read_buf);
/*     */       
/* 200 */       if (n == 1) {
/* 201 */         return this.read_buf[0];
/*     */       }
/* 203 */       return -1;
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public final void unread(int c) throws IOException {
/* 210 */       RandomAccessCharacterFile.this.unreadChar((char)c);
/*     */     }
/*     */ 
/*     */     
/*     */     public final void unread(char[] cbuf, int off, int len) throws IOException {
/* 215 */       for (int i = 0; i < len; i++) {
/* 216 */         unread(cbuf[off + i]);
/*     */       }
/*     */     }
/*     */     
/*     */     public final void unread(char[] cbuf) throws IOException {
/* 221 */       unread(cbuf, 0, cbuf.length);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public final int read(CharBuffer target) throws IOException {
/* 227 */       throw new IOException("Not implemented");
/*     */     }
/*     */ 
/*     */     
/*     */     public final int read(char[] cbuf) throws IOException {
/* 232 */       return RandomAccessCharacterFile.this.read(cbuf, 0, cbuf.length);
/*     */     }
/*     */ 
/*     */     
/*     */     public final int read(char[] cb, int off, int len) throws IOException {
/* 237 */       return RandomAccessCharacterFile.this.read(cb, off, len);
/*     */     }
/*     */ 
/*     */     
/*     */     public final boolean ready() throws IOException {
/* 242 */       return true;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private class RandomAccessWriter
/*     */     extends Writer
/*     */   {
/*     */     public final void close() throws IOException {
/* 252 */       RandomAccessCharacterFile.this.close();
/*     */     }
/*     */     
/*     */     public final void flush() throws IOException {
/* 256 */       RandomAccessCharacterFile.this.flush();
/*     */     }
/*     */ 
/*     */     
/*     */     public final void write(char[] cb, int off, int len) throws IOException {
/* 261 */       RandomAccessCharacterFile.this.write(cb, off, len);
/*     */     }
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
/*     */   public RandomAccessCharacterFile(RandomAccessFile raf, String encoding) throws IOException {
/* 294 */     this.fcn = raf.getChannel();
/*     */     
/* 296 */     setEncoding(encoding);
/* 297 */     this.bbuf = ByteBuffer.allocate(4096);
/*     */ 
/*     */     
/* 300 */     this.bbuf.flip();
/*     */ 
/*     */     
/* 303 */     this.bbufIsDirty = false;
/*     */     
/* 305 */     this.bbufIsReadable = true;
/*     */     
/* 307 */     this.bbufpos = this.fcn.position();
/*     */     
/* 309 */     this.reader = new RandomAccessReader();
/* 310 */     this.writer = new RandomAccessWriter();
/* 311 */     this.inputStream = new RandomAccessInputStream();
/* 312 */     this.outputStream = new RandomAccessOutputStream();
/*     */   }
/*     */   
/*     */   public void setEncoding(String encoding) {
/* 316 */     if (encoding == null) {
/* 317 */       this.cset = Charset.defaultCharset();
/*     */     } else {
/*     */       try {
/* 320 */         this.cset = Charset.forName(encoding);
/* 321 */       } catch (UnsupportedCharsetException e) {
/* 322 */         Lisp.error((LispObject)new SimpleError("Undefined encoding: " + encoding));
/*     */       } 
/*     */     } 
/* 325 */     this.cdec = this.cset.newDecoder();
/* 326 */     this.cdec.onMalformedInput(CodingErrorAction.REPLACE);
/* 327 */     this.cdec.onUnmappableCharacter(CodingErrorAction.REPLACE);
/* 328 */     this.cenc = this.cset.newEncoder();
/*     */   }
/*     */   
/*     */   public Writer getWriter() {
/* 332 */     return this.writer;
/*     */   }
/*     */   
/*     */   public PushbackReader getReader() {
/* 336 */     return this.reader;
/*     */   }
/*     */   
/*     */   public PushbackInputStream getInputStream() {
/* 340 */     return this.inputStream;
/*     */   }
/*     */   
/*     */   public OutputStream getOutputStream() {
/* 344 */     return this.outputStream;
/*     */   }
/*     */   
/*     */   public final void close() throws IOException {
/* 348 */     internalFlush(true);
/* 349 */     this.fcn.close();
/*     */   }
/*     */   
/*     */   public final void flush() throws IOException {
/* 353 */     internalFlush(false);
/*     */   }
/*     */   
/*     */   private final boolean ensureReadBbuf(boolean force) throws IOException {
/* 357 */     boolean bufReady = true;
/*     */     
/* 359 */     if (this.bbuf.remaining() == 0 || force || !this.bbufIsReadable) {
/*     */ 
/*     */       
/* 362 */       if (this.bbufIsDirty) {
/* 363 */         flushBbuf(false);
/* 364 */         this.bbuf.clear();
/* 365 */         this.bbufIsReadable = false;
/*     */       }
/*     */       else {
/*     */         
/* 369 */         int bbufEnd = this.bbufIsReadable ? this.bbuf.limit() : this.bbuf.position();
/* 370 */         this.fcn.position(this.bbufpos + bbufEnd);
/* 371 */         this.bbufpos += this.bbuf.position();
/* 372 */         if (this.bbufIsReadable) {
/* 373 */           this.bbuf.compact();
/* 374 */           this.bbufIsReadable = false;
/*     */         } else {
/* 376 */           this.bbuf.clear();
/*     */         } 
/*     */       } 
/* 379 */       bufReady = (this.fcn.read(this.bbuf) != -1);
/* 380 */       this.bbuf.flip();
/* 381 */       this.bbufIsReadable = true;
/*     */     } 
/*     */     
/* 384 */     return bufReady;
/*     */   }
/*     */ 
/*     */   
/*     */   final int read(char[] cb, int off, int len) throws IOException {
/* 389 */     CharBuffer cbuf = CharBuffer.wrap(cb, off, len);
/* 390 */     this.cdec.reset();
/* 391 */     boolean decodeWasUnderflow = false;
/* 392 */     boolean atEof = false;
/* 393 */     while (cbuf.remaining() > 0 && !atEof) {
/* 394 */       CoderResult r; int oldRemaining = cbuf.remaining();
/* 395 */       atEof = !ensureReadBbuf(decodeWasUnderflow);
/*     */       
/*     */       try {
/* 398 */         r = this.cdec.decode(this.bbuf, cbuf, atEof);
/* 399 */       } catch (IllegalStateException e) {
/* 400 */         throw new IOException("CharsetDecoder failed", e);
/* 401 */       } catch (CoderMalfunctionError e) {
/* 402 */         throw new IOException("CharsetDecoder malfunction", e);
/*     */       } 
/*     */       
/* 405 */       if (oldRemaining == cbuf.remaining() && CoderResult.OVERFLOW == r) {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */         
/* 415 */         cbuf.put('?');
/* 416 */         this.bbuf.get();
/*     */       } 
/* 418 */       decodeWasUnderflow = (CoderResult.UNDERFLOW == r);
/*     */     } 
/* 420 */     if (cbuf.remaining() == len) {
/* 421 */       return -1;
/*     */     }
/* 423 */     return len - cbuf.remaining();
/*     */   }
/*     */ 
/*     */   
/*     */   final void write(char[] cb, int off, int len) throws IOException {
/* 428 */     CharBuffer cbuf = CharBuffer.wrap(cb, off, len);
/* 429 */     encodeAndWrite(cbuf, false, false);
/*     */   }
/*     */   
/*     */   private final void internalFlush(boolean endOfFile) throws IOException {
/* 433 */     if (endOfFile) {
/* 434 */       CharBuffer cbuf = CharBuffer.allocate(0);
/* 435 */       encodeAndWrite(cbuf, true, endOfFile);
/*     */     } else {
/* 437 */       flushBbuf(false);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   private final void encodeAndWrite(CharBuffer cbuf, boolean flush, boolean endOfFile) throws IOException {
/* 443 */     while (cbuf.remaining() > 0) {
/* 444 */       CoderResult r = this.cenc.encode(cbuf, this.bbuf, endOfFile);
/* 445 */       this.bbufIsDirty = true;
/* 446 */       if (CoderResult.OVERFLOW == r || this.bbuf.remaining() == 0) {
/* 447 */         flushBbuf(false);
/* 448 */         this.bbuf.clear();
/* 449 */         this.bbufIsReadable = false;
/*     */       } 
/* 451 */       if (r.isUnmappable()) {
/* 452 */         throw new RACFUnmappableCharacterException(cbuf.position(), cbuf
/* 453 */             .charAt(cbuf.position()), this.cset
/* 454 */             .name());
/*     */       }
/* 456 */       if (r.isMalformed())
/*     */       {
/*     */         
/* 459 */         throw new RACFMalformedInputException(cbuf.position(), cbuf
/* 460 */             .charAt(cbuf.position()), this.cset
/* 461 */             .name());
/*     */       }
/*     */     } 
/*     */ 
/*     */     
/* 466 */     if (this.bbuf.position() > 0 && this.bbufIsDirty && flush) {
/* 467 */       flushBbuf(false);
/*     */     }
/*     */   }
/*     */   
/*     */   public final void position(long newPosition) throws IOException {
/* 472 */     flushBbuf(true);
/*     */ 
/*     */ 
/*     */     
/* 476 */     long bbufend = this.bbufpos + (this.bbufIsReadable ? this.bbuf.limit() : this.bbuf.position());
/* 477 */     if (newPosition >= this.bbufpos && newPosition < bbufend) {
/*     */       
/* 479 */       if (!this.bbufIsReadable) {
/* 480 */         this.bbuf.limit(this.bbuf.position());
/* 481 */         this.bbufIsReadable = true;
/*     */       } 
/* 483 */       this.bbuf.position((int)(newPosition - this.bbufpos));
/*     */     } else {
/* 485 */       this.fcn.position(newPosition);
/*     */       
/* 487 */       this.bbuf.clear();
/* 488 */       this.bbuf.flip();
/* 489 */       this.bbufIsReadable = true;
/* 490 */       this.bbufpos = newPosition;
/*     */     } 
/*     */   }
/*     */   
/*     */   public final long position() throws IOException {
/* 495 */     return this.bbufpos + this.bbuf.position();
/*     */   }
/*     */   
/*     */   public final long length() throws IOException {
/* 499 */     flushBbuf(true);
/* 500 */     return this.fcn.size();
/*     */   }
/*     */   
/*     */   final void flushBbuf(boolean commitOnly) throws IOException {
/* 504 */     if (commitOnly && !this.bbufIsDirty) {
/*     */       return;
/*     */     }
/*     */     
/* 508 */     this.fcn.position(this.bbufpos);
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 513 */     if (commitOnly) {
/* 514 */       ByteBuffer dup = this.bbuf.duplicate();
/* 515 */       dup.flip();
/* 516 */       this.fcn.write(dup);
/*     */ 
/*     */       
/* 519 */       this.bbufIsDirty = false;
/*     */       
/*     */       return;
/*     */     } 
/* 523 */     if (this.bbufIsDirty) {
/* 524 */       this.bbuf.flip();
/* 525 */       this.fcn.write(this.bbuf);
/*     */     } 
/*     */     
/* 528 */     this.bbufpos += this.bbuf.position();
/* 529 */     this.bbuf.clear();
/* 530 */     this.bbuf.flip();
/* 531 */     this.bbufIsDirty = false;
/* 532 */     this.bbufIsReadable = true;
/*     */   }
/*     */   
/*     */   public final int read(byte[] b, int off, int len) throws IOException {
/* 536 */     int pos = off;
/* 537 */     boolean atEof = false;
/* 538 */     while (pos - off < len && !atEof) {
/*     */       
/* 540 */       atEof = !ensureReadBbuf(false);
/* 541 */       int want = Math.min(off + len - pos, this.bbuf.remaining());
/* 542 */       this.bbuf.get(b, pos, want);
/* 543 */       pos += want;
/*     */     } 
/* 545 */     return pos - off;
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
/*     */   public final void unreadChar(char c) throws IOException {
/* 569 */     if (this.singleCharBuf == null) {
/* 570 */       this.singleCharBuf = CharBuffer.allocate(1);
/* 571 */       this.shortByteBuf = ByteBuffer.allocate((int)this.cenc.maxBytesPerChar());
/*     */     } 
/* 573 */     this.singleCharBuf.clear();
/* 574 */     this.singleCharBuf.append(c);
/* 575 */     this.singleCharBuf.flip();
/* 576 */     this.shortByteBuf.clear();
/* 577 */     this.cenc.encode(this.singleCharBuf, this.shortByteBuf, false);
/* 578 */     int n = this.shortByteBuf.position();
/* 579 */     long pos = position() - n;
/* 580 */     position(pos);
/*     */   }
/*     */   
/*     */   public final void unreadByte(byte b) throws IOException {
/* 584 */     long pos = position() - 1L;
/* 585 */     position(pos);
/*     */   }
/*     */   
/*     */   final void write(byte[] b, int off, int len) throws IOException {
/* 589 */     int pos = off;
/* 590 */     while (pos < off + len) {
/* 591 */       if (this.bbuf.remaining() == 0) {
/* 592 */         flushBbuf(false);
/* 593 */         this.bbuf.clear();
/* 594 */         this.bbufIsReadable = false;
/*     */       } 
/* 596 */       int thisBatchLen = Math.min(off + len - pos, this.bbuf.remaining());
/* 597 */       this.bbuf.put(b, pos, thisBatchLen);
/* 598 */       pos += thisBatchLen;
/* 599 */       this.bbufIsDirty = true;
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/util/RandomAccessCharacterFile.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */