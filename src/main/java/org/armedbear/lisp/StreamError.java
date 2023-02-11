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
/*     */ public class StreamError
/*     */   extends LispError
/*     */ {
/*     */   private final Throwable cause;
/*     */   
/*     */   protected StreamError(LispClass cls) {
/*  44 */     super(cls);
/*  45 */     this.cause = null;
/*     */   }
/*     */ 
/*     */   
/*     */   public StreamError(String message) {
/*  50 */     super(StandardClass.STREAM_ERROR);
/*  51 */     setFormatControl(message.replaceAll("~", "~~"));
/*  52 */     setFormatArguments(Lisp.NIL);
/*  53 */     setStream(Lisp.NIL);
/*  54 */     this.cause = null;
/*     */   }
/*     */ 
/*     */   
/*     */   public StreamError(Stream stream) {
/*  59 */     super(StandardClass.STREAM_ERROR);
/*  60 */     setStream((stream != null) ? stream : Lisp.NIL);
/*  61 */     this.cause = null;
/*     */   }
/*     */ 
/*     */   
/*     */   public StreamError(String message, Stream stream) {
/*  66 */     super(StandardClass.STREAM_ERROR);
/*  67 */     setFormatControl(message.replaceAll("~", "~~"));
/*  68 */     setFormatArguments(Lisp.NIL);
/*  69 */     setStream((stream != null) ? stream : Lisp.NIL);
/*  70 */     this.cause = null;
/*     */   }
/*     */ 
/*     */   
/*     */   public StreamError(LispObject initArgs) {
/*  75 */     super(StandardClass.STREAM_ERROR);
/*  76 */     initialize(initArgs);
/*  77 */     this.cause = null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  83 */     super.initialize(initArgs);
/*  84 */     while (initArgs != Lisp.NIL) {
/*  85 */       LispObject first = initArgs.car();
/*  86 */       initArgs = initArgs.cdr();
/*  87 */       if (first == Keyword.STREAM) {
/*  88 */         setStream(initArgs.car());
/*     */         break;
/*     */       } 
/*  91 */       initArgs = initArgs.cdr();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public StreamError(Stream stream, String message) {
/*  97 */     super(StandardClass.STREAM_ERROR);
/*  98 */     setFormatControl(message.replaceAll("~", "~~"));
/*  99 */     setFormatArguments(Lisp.NIL);
/* 100 */     setStream((stream != null) ? stream : Lisp.NIL);
/* 101 */     this.cause = null;
/*     */   }
/*     */ 
/*     */   
/*     */   public StreamError(Stream stream, Throwable cause) {
/* 106 */     super(StandardClass.STREAM_ERROR);
/* 107 */     setStream((stream != null) ? stream : Lisp.NIL);
/* 108 */     String message = cause.getMessage();
/* 109 */     setFormatControl((message != null) ? message.replaceAll("~", "~~") : cause.toString().replaceAll("~", "~~"));
/* 110 */     setFormatArguments(Lisp.NIL);
/* 111 */     this.cause = cause;
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getStream() {
/* 116 */     return getInstanceSlotValue(Symbol.STREAM);
/*     */   }
/*     */ 
/*     */   
/*     */   protected final void setStream(LispObject stream) {
/* 121 */     setInstanceSlotValue(Symbol.STREAM, stream);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 127 */     return Symbol.STREAM_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 133 */     return StandardClass.STREAM_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 139 */     if (type == Symbol.STREAM_ERROR)
/* 140 */       return Lisp.T; 
/* 141 */     if (type == StandardClass.STREAM_ERROR)
/* 142 */       return Lisp.T; 
/* 143 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/* 149 */     if (this.cause != null) {
/* 150 */       String s = this.cause.getMessage();
/* 151 */       if (s != null && s.length() > 0)
/* 152 */         return s; 
/*     */     } 
/* 154 */     return null;
/*     */   }
/*     */ 
/*     */   
/* 158 */   private static final Primitive STREAM_ERROR_STREAM = new Primitive("stream-error-stream", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 164 */         if (arg.typep(Symbol.STREAM_ERROR) == Lisp.NIL) {
/* 165 */           return Lisp.type_error(arg, Symbol.STREAM_ERROR);
/*     */         }
/*     */         
/* 168 */         StandardObject obj = (StandardObject)arg;
/* 169 */         return obj.getInstanceSlotValue(Symbol.STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StreamError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */