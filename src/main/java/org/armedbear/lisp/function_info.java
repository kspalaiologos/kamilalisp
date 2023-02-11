/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.Collections;
/*     */ import java.util.Map;
/*     */ import java.util.WeakHashMap;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class function_info
/*     */ {
/*  45 */   static final Map<LispObject, LispObject> symbolToFunctionMap = Collections.synchronizedMap(new WeakHashMap<>());
/*     */ 
/*     */   
/*  48 */   private static final Primitive FUNCTION_INFO = new Primitive("function-info", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  54 */         LispObject info = function_info.symbolToFunctionMap.get(arg);
/*  55 */         return (info != null) ? info : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  60 */   private static final Primitive _SET_FUNCTION_INFO = new Primitive("%set-function-info", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject name, LispObject info)
/*     */       {
/*  67 */         if (info == Lisp.NIL) {
/*  68 */           function_info.symbolToFunctionMap.remove(name);
/*     */         } else {
/*  70 */           function_info.symbolToFunctionMap.put(name, info);
/*  71 */         }  return info;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  76 */   private static final Primitive GET_FUNCTION_INFO_VALUE = new Primitive("get-function-info-value", Lisp.PACKAGE_SYS, true, "name indicator")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject name, LispObject indicator)
/*     */       {
/*  85 */         LispObject info = function_info.symbolToFunctionMap.get(name);
/*  86 */         if (info != null) {
/*  87 */           while (info != Lisp.NIL) {
/*  88 */             LispObject cons = info.car();
/*  89 */             if (cons instanceof Cons) {
/*  90 */               if (cons.car().eql(indicator))
/*     */               {
/*  92 */                 return LispThread.currentThread().setValues(cons.cdr(), Lisp.T);
/*     */               }
/*  94 */             } else if (cons != Lisp.NIL) {
/*  95 */               Lisp.type_error(cons, Symbol.LIST);
/*  96 */             }  info = info.cdr();
/*     */           } 
/*     */         }
/*  99 */         return LispThread.currentThread().setValues(Lisp.NIL, Lisp.NIL);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 104 */   private static final Primitive SET_FUNCTION_INFO_VALUE = new Primitive("set-function-info-value", Lisp.PACKAGE_SYS, true, "name indicator value")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject name, LispObject indicator, LispObject value)
/*     */       {
/* 114 */         LispObject info = function_info.symbolToFunctionMap.get(name);
/* 115 */         if (info == null)
/* 116 */           info = Lisp.NIL; 
/* 117 */         LispObject alist = info;
/* 118 */         while (alist != Lisp.NIL) {
/* 119 */           LispObject cons = alist.car();
/* 120 */           if (cons instanceof Cons) {
/* 121 */             if (cons.car().eql(indicator)) {
/*     */               
/* 123 */               cons.setCdr(value);
/* 124 */               return value;
/*     */             } 
/* 126 */           } else if (cons != Lisp.NIL) {
/* 127 */             Lisp.type_error(cons, Symbol.LIST);
/* 128 */           }  alist = alist.cdr();
/*     */         } 
/*     */         
/* 131 */         function_info.symbolToFunctionMap.put(name, info.push(new Cons(indicator, value)));
/* 132 */         return value;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/function_info.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */