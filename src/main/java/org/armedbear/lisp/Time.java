/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.Date;
/*     */ import java.util.TimeZone;
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
/*     */ public final class Time
/*     */ {
/*  45 */   public static final Primitive _TIME = new pf__time();
/*     */   
/*     */   private static final class pf__time extends Primitive { pf__time() {
/*  48 */       super("%time", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/*  52 */       Cons.setCount(0L);
/*  53 */       long realStart = System.currentTimeMillis();
/*     */       try {
/*  55 */         return arg.execute();
/*     */       } finally {
/*  57 */         long realElapsed = System.currentTimeMillis() - realStart;
/*  58 */         long count = Cons.getCount();
/*     */         
/*  60 */         Stream out = Lisp.checkCharacterOutputStream(Symbol.TRACE_OUTPUT.symbolValue());
/*  61 */         out.freshLine();
/*  62 */         StringBuilder sb = new StringBuilder();
/*  63 */         sb.append(String.valueOf((float)realElapsed / 1000.0F));
/*  64 */         sb.append(" seconds real time");
/*  65 */         sb.append(System.getProperty("line.separator"));
/*  66 */         sb.append(count);
/*  67 */         sb.append(" cons cell");
/*  68 */         if (count != 1L)
/*  69 */           sb.append('s'); 
/*  70 */         sb.append(System.getProperty("line.separator"));
/*  71 */         out._writeString(sb.toString());
/*  72 */         out._finishOutput();
/*     */       } 
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  78 */   private static final Primitive GET_INTERNAL_REAL_TIME = new pf_get_internal_real_time();
/*     */   
/*     */   private static final class pf_get_internal_real_time extends Primitive { pf_get_internal_real_time() {
/*  81 */       super("get-internal-real-time", "");
/*     */     }
/*     */     
/*     */     public LispObject execute() {
/*  85 */       return Lisp.number(System.currentTimeMillis());
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  90 */   private static final Primitive GET_INTERNAL_RUN_TIME = new pf_get_internal_run_time();
/*     */   
/*     */   private static final class pf_get_internal_run_time extends Primitive { pf_get_internal_run_time() {
/*  93 */       super("get-internal-run-time", "");
/*     */     }
/*     */     
/*     */     public LispObject execute() {
/*  97 */       return Lisp.number(System.currentTimeMillis());
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 102 */   private static final Primitive GET_UNIVERSAL_TIME = new pf_get_universal_time();
/*     */   
/*     */   private static final class pf_get_universal_time extends Primitive { pf_get_universal_time() {
/* 105 */       super("get-universal-time", "");
/*     */     }
/*     */     
/*     */     public LispObject execute() {
/* 109 */       return Lisp.number(System.currentTimeMillis() / 1000L + 2208988800L);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 114 */   private static final Primitive DEFAULT_TIME_ZONE = new pf_default_time_zone();
/*     */   
/*     */   private static final class pf_default_time_zone extends Primitive { pf_default_time_zone() {
/* 117 */       super("default-time-zone", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */     
/*     */     public LispObject execute() {
/* 121 */       return Time.getTimeZone(System.currentTimeMillis());
/*     */     } }
/*     */ 
/*     */   
/*     */   private static final LispObject getTimeZone(long unixTimeMillis) {
/* 126 */     TimeZone tz = TimeZone.getDefault();
/*     */ 
/*     */     
/* 129 */     int rawOffset = tz.getRawOffset();
/*     */     
/* 131 */     boolean inDaylightTime = tz.inDaylightTime(new Date(unixTimeMillis));
/* 132 */     if (inDaylightTime) {
/* 133 */       rawOffset += tz.getDSTSavings();
/*     */     }
/*     */     
/* 136 */     return LispThread.currentThread()
/* 137 */       .setValues(Fixnum.getInstance(-rawOffset).divideBy(Fixnum.getInstance(3600000)), inDaylightTime ? Lisp.T : Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 142 */   private static final Primitive GET_TIME_ZONE = new pf_get_time_zone();
/*     */   
/*     */   @DocString(name = "get-time-zone", args = "time-in-millis", returns = "hours-west daylight-p", doc = "Returns as the first value the timezone difference in hours from the Greenwich meridian for TIME-IN-MILLIS via the Daylight Savings Time assumptions that were in place at the instant's occurance.  Returns as the second value a boolean as to whether daylight savings time was in effect at the occurance.")
/*     */   private static final class pf_get_time_zone
/*     */     extends Primitive
/*     */   {
/*     */     pf_get_time_zone() {
/* 149 */       super("get-time-zone", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 153 */       return Time.getTimeZone((arg.longValue() - 2208988800L) * 1000L);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Time.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */