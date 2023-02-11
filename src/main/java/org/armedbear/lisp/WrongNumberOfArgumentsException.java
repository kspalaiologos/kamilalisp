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
/*     */ public final class WrongNumberOfArgumentsException
/*     */   extends ProgramError
/*     */ {
/*     */   private Operator operator;
/*     */   private int expectedMinArgs;
/*     */   private int expectedMaxArgs;
/*     */   private LispObject actualArgs;
/*     */   private String message;
/*     */   
/*     */   public WrongNumberOfArgumentsException(Operator operator) {
/*  47 */     this(operator, -1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public WrongNumberOfArgumentsException(Operator operator, LispObject args, int expectedMin, int expectedMax) {
/*  54 */     super(StandardClass.PROGRAM_ERROR);
/*  55 */     this.operator = operator;
/*  56 */     this.expectedMinArgs = expectedMin;
/*  57 */     this.expectedMaxArgs = expectedMax;
/*  58 */     this.actualArgs = args;
/*  59 */     setFormatControl(getMessage().replaceAll("~", "~~"));
/*  60 */     setFormatArguments(Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   public WrongNumberOfArgumentsException(Operator operator, int expectedMin, int expectedMax) {
/*  65 */     this(operator, (LispObject)null, expectedMin, expectedMax);
/*     */   }
/*     */   
/*     */   public WrongNumberOfArgumentsException(Operator operator, int expectedArgs) {
/*  69 */     this(operator, expectedArgs, expectedArgs);
/*     */   }
/*     */ 
/*     */   
/*     */   public WrongNumberOfArgumentsException(Operator operator, LispObject args, int expectedArgs) {
/*  74 */     this(operator, args, expectedArgs, expectedArgs);
/*     */   }
/*     */   
/*     */   public WrongNumberOfArgumentsException(String message) {
/*  78 */     super(StandardClass.PROGRAM_ERROR);
/*  79 */     if (message == null) {
/*  80 */       throw new NullPointerException("message can not be null");
/*     */     }
/*  82 */     this.message = message;
/*  83 */     setFormatControl(getMessage().replaceAll("~", "~~"));
/*  84 */     setFormatArguments(Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/*  90 */     if (this.message != null) {
/*  91 */       return this.message;
/*     */     }
/*     */ 
/*     */     
/*  95 */     StringBuilder sb = new StringBuilder("Wrong number of arguments for " + this.operator.princToString());
/*  96 */     if (this.expectedMinArgs >= 0 || this.expectedMaxArgs >= 0) {
/*  97 */       sb.append("; ");
/*     */       
/*  99 */       if (this.expectedMinArgs == this.expectedMaxArgs) {
/* 100 */         sb.append(this.expectedMinArgs);
/* 101 */       } else if (this.expectedMaxArgs < 0) {
/* 102 */         sb.append("at least ");
/* 103 */         sb.append(this.expectedMinArgs);
/* 104 */       } else if (this.expectedMinArgs < 0) {
/* 105 */         sb.append("at most ");
/* 106 */         sb.append(this.expectedMaxArgs);
/*     */       } else {
/* 108 */         sb.append("between ").append(this.expectedMinArgs);
/* 109 */         sb.append(" and ").append(this.expectedMaxArgs);
/*     */       } 
/*     */       
/* 112 */       sb.append(" expected");
/*     */     } 
/* 114 */     if (this.actualArgs != null) {
/* 115 */       sb.append(" -- provided: ");
/* 116 */       sb.append(this.actualArgs.princToString());
/*     */     } 
/* 118 */     sb.append('.');
/* 119 */     return this.message = sb.toString();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/WrongNumberOfArgumentsException.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */