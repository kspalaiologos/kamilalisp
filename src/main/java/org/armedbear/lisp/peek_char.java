/*     */ package org.armedbear.lisp;
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
/*     */ public final class peek_char
/*     */   extends Primitive
/*     */ {
/*  41 */   private static LispObject internalEOF = new LispObject();
/*     */ 
/*     */   
/*     */   private peek_char() {
/*  45 */     super("peek-char", "&optional peek-type input-stream eof-error-p eof-value recursive-p");
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/*  52 */     int length = args.length;
/*  53 */     if (length > 5)
/*  54 */       Lisp.error(new WrongNumberOfArgumentsException(this, -1, 5)); 
/*  55 */     LispObject peekType = (length > 0) ? args[0] : Lisp.NIL;
/*  56 */     Stream stream = (length > 1) ? Lisp.inSynonymOf(args[1]) : Lisp.getStandardInput();
/*  57 */     boolean eofError = (length > 2) ? ((args[2] != Lisp.NIL)) : true;
/*  58 */     LispObject eofValue = (length > 3) ? args[3] : Lisp.NIL;
/*     */ 
/*     */     
/*  61 */     if (peekType == Lisp.NIL) {
/*     */       Stream in;
/*     */ 
/*     */ 
/*     */       
/*  66 */       if (stream instanceof EchoStream) {
/*     */ 
/*     */ 
/*     */         
/*  70 */         in = ((EchoStream)stream).getInputStream();
/*     */       } else {
/*  72 */         in = stream;
/*  73 */       }  LispObject result = in.readChar(eofError, internalEOF);
/*  74 */       if (result == internalEOF)
/*  75 */         return eofValue; 
/*  76 */       if (result instanceof LispCharacter)
/*  77 */         in.unreadChar((LispCharacter)result); 
/*  78 */       return result;
/*     */     } 
/*  80 */     if (peekType == Lisp.T) {
/*     */       LispObject result;
/*     */ 
/*     */       
/*  84 */       Readtable rt = Lisp.currentReadtable();
/*     */       while (true) {
/*  86 */         result = stream.readChar(eofError, internalEOF);
/*  87 */         if (result == internalEOF) {
/*  88 */           return eofValue;
/*     */         }
/*  90 */         if (result instanceof LispCharacter) {
/*  91 */           char c = ((LispCharacter)result).value;
/*  92 */           if (!rt.isWhitespace(c)) {
/*  93 */             stream.unreadChar((LispCharacter)result);
/*  94 */             return result;
/*     */           }  continue;
/*     */         }  break;
/*  97 */       }  return result;
/*     */     } 
/*     */     
/* 100 */     if (peekType instanceof LispCharacter) {
/*     */       LispObject result;
/*     */ 
/*     */       
/* 104 */       char c = ((LispCharacter)peekType).value;
/*     */       while (true) {
/* 106 */         result = stream.readChar(eofError, internalEOF);
/* 107 */         if (result == internalEOF) {
/* 108 */           return eofValue;
/*     */         }
/* 110 */         if (result instanceof LispCharacter) {
/* 111 */           if (((LispCharacter)result).value == c) {
/* 112 */             stream.unreadChar((LispCharacter)result);
/* 113 */             return result;
/*     */           }  continue;
/*     */         }  break;
/* 116 */       }  return result;
/*     */     } 
/*     */     
/* 119 */     return Lisp.error(new SimpleError(String.valueOf(peekType) + " is an illegal peek-type."));
/*     */   }
/*     */ 
/*     */   
/* 123 */   private static final Primitive PEEK_CHAR = new peek_char();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/peek_char.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */