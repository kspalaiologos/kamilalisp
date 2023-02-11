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
/*     */ public final class cxr
/*     */ {
/*  40 */   private static final Primitive SET_CAR = new pf_set_car();
/*     */   
/*     */   private static final class pf_set_car extends Primitive { pf_set_car() {
/*  43 */       super("set-car", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/*  50 */       first.setCar(second);
/*  51 */       return second;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  56 */   private static final Primitive SET_CDR = new pf_set_cdr();
/*     */   
/*     */   private static final class pf_set_cdr extends Primitive { pf_set_cdr() {
/*  59 */       super("set-cdr", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/*  66 */       first.setCdr(second);
/*  67 */       return second;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  72 */   private static final Primitive CAR = new pf_car();
/*     */   
/*     */   private static final class pf_car extends Primitive { pf_car() {
/*  75 */       super(Symbol.CAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/*  80 */       return arg.car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  85 */   private static final Primitive CDR = new pf_cdr();
/*     */   
/*     */   private static final class pf_cdr extends Primitive { pf_cdr() {
/*  88 */       super(Symbol.CDR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/*  93 */       return arg.cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  98 */   private static final Primitive CAAR = new pf_caar();
/*     */   
/*     */   private static final class pf_caar extends Primitive { pf_caar() {
/* 101 */       super(Symbol.CAAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 106 */       return arg.car().car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 111 */   private static final Primitive CADR = new pf_cadr();
/*     */   
/*     */   private static final class pf_cadr extends Primitive { pf_cadr() {
/* 114 */       super(Symbol.CADR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 119 */       return arg.cadr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 124 */   private static final Primitive CDAR = new pf_cdar();
/*     */   
/*     */   private static final class pf_cdar extends Primitive { pf_cdar() {
/* 127 */       super(Symbol.CDAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 132 */       return arg.car().cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 137 */   private static final Primitive CDDR = new pf_cddr();
/*     */   
/*     */   private static final class pf_cddr extends Primitive { pf_cddr() {
/* 140 */       super(Symbol.CDDR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 145 */       return arg.cdr().cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 150 */   private static final Primitive CADDR = new pf_caddr();
/*     */   
/*     */   private static final class pf_caddr extends Primitive { pf_caddr() {
/* 153 */       super(Symbol.CADDR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 158 */       return arg.caddr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 163 */   private static final Primitive CAADR = new pf_caadr();
/*     */   
/*     */   private static final class pf_caadr extends Primitive { pf_caadr() {
/* 166 */       super(Symbol.CAADR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 171 */       return arg.cdr().car().car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 176 */   private static final Primitive CAAAR = new pf_caaar();
/*     */   
/*     */   private static final class pf_caaar extends Primitive { pf_caaar() {
/* 179 */       super(Symbol.CAAAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 184 */       return arg.car().car().car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 189 */   private static final Primitive CDAAR = new pf_cdaar();
/*     */   
/*     */   private static final class pf_cdaar extends Primitive { pf_cdaar() {
/* 192 */       super(Symbol.CDAAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 197 */       return arg.car().car().cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 202 */   private static final Primitive CDDAR = new pf_cddar();
/*     */   
/*     */   private static final class pf_cddar extends Primitive { pf_cddar() {
/* 205 */       super(Symbol.CDDAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 210 */       return arg.car().cdr().cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 215 */   private static final Primitive CDDDR = new pf_cdddr();
/*     */   
/*     */   private static final class pf_cdddr extends Primitive { pf_cdddr() {
/* 218 */       super(Symbol.CDDDR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 223 */       return arg.cdr().cdr().cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 228 */   private static final Primitive CADAR = new pf_cadar();
/*     */   
/*     */   private static final class pf_cadar extends Primitive { pf_cadar() {
/* 231 */       super(Symbol.CADAR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 236 */       return arg.car().cdr().car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 241 */   private static final Primitive CDADR = new pf_cdadr();
/*     */   
/*     */   private static final class pf_cdadr extends Primitive { pf_cdadr() {
/* 244 */       super(Symbol.CDADR, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 249 */       return arg.cdr().car().cdr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 254 */   private static final Primitive FIRST = new pf_first();
/*     */   
/*     */   private static final class pf_first extends Primitive { pf_first() {
/* 257 */       super(Symbol.FIRST, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 262 */       return arg.car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 267 */   private static final Primitive SECOND = new pf_second();
/*     */   
/*     */   private static final class pf_second extends Primitive { pf_second() {
/* 270 */       super(Symbol.SECOND, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 275 */       return arg.cadr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 280 */   private static final Primitive THIRD = new pf_third();
/*     */   
/*     */   private static final class pf_third extends Primitive { pf_third() {
/* 283 */       super(Symbol.THIRD, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 288 */       return arg.caddr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 293 */   private static final Primitive FOURTH = new pf_fourth();
/*     */   
/*     */   private static final class pf_fourth extends Primitive { pf_fourth() {
/* 296 */       super(Symbol.FOURTH, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 301 */       return arg.cdr().cdr().cadr();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 306 */   private static final Primitive REST = new pf_rest();
/*     */   
/*     */   private static final class pf_rest extends Primitive { pf_rest() {
/* 309 */       super(Symbol.REST, "list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 314 */       return arg.cdr();
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/cxr.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */