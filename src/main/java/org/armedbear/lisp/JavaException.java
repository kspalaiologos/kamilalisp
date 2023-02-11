/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.PrintWriter;
/*     */ import java.io.StringWriter;
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
/*     */ public class JavaException
/*     */   extends LispError
/*     */ {
/*     */   private final Throwable throwable;
/*     */   
/*     */   public JavaException(Throwable throwable) {
/*  47 */     super(StandardClass.JAVA_EXCEPTION);
/*  48 */     Debug.assertTrue((this.slots.length == 3));
/*  49 */     Debug.assertTrue((throwable != null));
/*  50 */     this.throwable = throwable;
/*  51 */     setInstanceSlotValue(Symbol.CAUSE, new JavaObject(throwable));
/*  52 */     setFormatControl("Java exception: ~A.");
/*  53 */     setFormatArguments(new Cons(new JavaObject(throwable)));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  59 */     return Symbol.JAVA_EXCEPTION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  65 */     return StandardClass.JAVA_EXCEPTION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  71 */     if (type == Symbol.JAVA_EXCEPTION)
/*  72 */       return Lisp.T; 
/*  73 */     if (type == StandardClass.JAVA_EXCEPTION)
/*  74 */       return Lisp.T; 
/*  75 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/*  81 */     StringWriter sw = new StringWriter();
/*  82 */     PrintWriter pw = new PrintWriter(sw);
/*  83 */     this.throwable.printStackTrace(pw);
/*  84 */     String s = sw.toString();
/*  85 */     String separator = System.getProperty("line.separator");
/*  86 */     if (s.endsWith(separator))
/*  87 */       s = s.substring(0, s.length() - separator.length()); 
/*  88 */     return s;
/*     */   }
/*     */ 
/*     */   
/*  92 */   protected static final Primitive JAVA_EXCEPTION_CAUSE = new Primitive(Symbol.JAVA_EXCEPTION_CAUSE, "java-exception", "Returns the cause of JAVA-EXCEPTION. (The cause is the Java Throwable\n  object that caused JAVA-EXCEPTION to be signalled.)")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 100 */         return Symbol.STD_SLOT_VALUE.execute(arg, Symbol.CAUSE);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JavaException.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */