/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import org.armedbear.lisp.protocol.Inspectable;
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
/*     */ public class JavaStackFrame
/*     */   extends StackFrame
/*     */   implements Inspectable
/*     */ {
/*     */   public final StackTraceElement javaFrame;
/*     */   
/*     */   public JavaStackFrame(StackTraceElement javaFrame) {
/*  48 */     this.javaFrame = javaFrame;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  53 */     return Symbol.JAVA_STACK_FRAME;
/*     */   }
/*     */   
/*     */   public LispObject classOf() {
/*  57 */     return BuiltInClass.JAVA_STACK_FRAME;
/*     */   }
/*     */   
/*     */   public String printObject() {
/*  61 */     String JAVA_STACK_FRAME = "JAVA-STACK-FRAME";
/*  62 */     return unreadableString("JAVA-STACK-FRAME " + 
/*  63 */         toLispString().toString());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  70 */     if (typeSpecifier == Symbol.JAVA_STACK_FRAME)
/*  71 */       return Lisp.T; 
/*  72 */     if (typeSpecifier == BuiltInClass.JAVA_STACK_FRAME)
/*  73 */       return Lisp.T; 
/*  74 */     return super.typep(typeSpecifier);
/*     */   }
/*     */   
/*  77 */   static final Symbol CLASS = Lisp.internKeyword("CLASS");
/*  78 */   static final Symbol METHOD = Lisp.internKeyword("METHOD");
/*  79 */   static final Symbol FILE = Lisp.internKeyword("FILE");
/*  80 */   static final Symbol LINE = Lisp.internKeyword("LINE");
/*  81 */   static final Symbol NATIVE_METHOD = Lisp.internKeyword("NATIVE-METHOD");
/*     */ 
/*     */   
/*     */   public LispObject toLispList() {
/*  85 */     LispObject result = Lisp.NIL;
/*     */ 
/*     */     
/*  88 */     if (this.javaFrame == null) {
/*  89 */       return result;
/*     */     }
/*  91 */     result = result.push(CLASS);
/*  92 */     result = result.push(new SimpleString(this.javaFrame.getClassName()));
/*  93 */     result = result.push(METHOD);
/*  94 */     result = result.push(new SimpleString(this.javaFrame.getMethodName()));
/*  95 */     result = result.push(FILE);
/*  96 */     String fileName = this.javaFrame.getFileName();
/*  97 */     if (fileName == null) {
/*  98 */       result.push(new SimpleString("(Unkown source)"));
/*     */     } else {
/* 100 */       result = result.push(new SimpleString(fileName));
/* 101 */     }  result = result.push(LINE);
/* 102 */     result = result.push(Fixnum.getInstance(this.javaFrame.getLineNumber()));
/* 103 */     if (this.javaFrame.isNativeMethod()) {
/* 104 */       result = result.push(NATIVE_METHOD);
/* 105 */       result = result.push(Symbol.T);
/*     */     } 
/*     */     
/* 108 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleString toLispString() {
/* 115 */     return new SimpleString(this.javaFrame.toString());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 122 */     LispObject result = Lisp.NIL;
/* 123 */     result = result.push(new Cons("CLASS", new SimpleString(this.javaFrame
/* 124 */             .getClassName())));
/* 125 */     result = result.push(new Cons("METHOD", new SimpleString(this.javaFrame
/* 126 */             .getMethodName())));
/* 127 */     result = result.push(new Cons("FILE", new SimpleString(this.javaFrame
/* 128 */             .getFileName())));
/* 129 */     result = result.push(new Cons("LINE", 
/* 130 */           Fixnum.getInstance(this.javaFrame.getLineNumber())));
/* 131 */     result = result.push(new Cons("NATIVE-METHOD", 
/* 132 */           LispObject.getInstance(this.javaFrame.isNativeMethod())));
/* 133 */     return result.nreverse();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JavaStackFrame.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */