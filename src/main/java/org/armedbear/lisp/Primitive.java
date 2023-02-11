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
/*     */ public class Primitive
/*     */   extends Function
/*     */ {
/*     */   public Primitive(LispObject name) {
/*  40 */     super(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(String name) {
/*  45 */     super(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(Symbol symbol) {
/*  50 */     super(symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(Symbol symbol, String arglist) {
/*  55 */     super(symbol, arglist);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(Symbol symbol, String arglist, String docstring) {
/*  60 */     super(symbol, arglist, docstring);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(String name, String arglist) {
/*  65 */     super(name, arglist);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(LispObject name, LispObject lambdaList) {
/*  70 */     super(name, lambdaList);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(String name, Package pkg) {
/*  75 */     super(name, pkg);
/*     */   }
/*     */ 
/*     */   
/*     */   public Primitive(String name, Package pkg, boolean exported) {
/*  80 */     super(name, pkg, exported);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Primitive(String name, Package pkg, boolean exported, String arglist) {
/*  86 */     super(name, pkg, exported, arglist);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Primitive(String name, Package pkg, boolean exported, String arglist, String docstring) {
/*  92 */     super(name, pkg, exported, arglist, docstring);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  98 */     return Symbol.COMPILED_FUNCTION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/* 104 */     LispObject[] args = new LispObject[0];
/* 105 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 111 */     LispObject[] args = new LispObject[1];
/* 112 */     args[0] = arg;
/* 113 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 120 */     LispObject[] args = new LispObject[2];
/* 121 */     args[0] = first;
/* 122 */     args[1] = second;
/* 123 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 131 */     LispObject[] args = new LispObject[3];
/* 132 */     args[0] = first;
/* 133 */     args[1] = second;
/* 134 */     args[2] = third;
/* 135 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 143 */     LispObject[] args = new LispObject[4];
/* 144 */     args[0] = first;
/* 145 */     args[1] = second;
/* 146 */     args[2] = third;
/* 147 */     args[3] = fourth;
/* 148 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 157 */     LispObject[] args = new LispObject[5];
/* 158 */     args[0] = first;
/* 159 */     args[1] = second;
/* 160 */     args[2] = third;
/* 161 */     args[3] = fourth;
/* 162 */     args[4] = fifth;
/* 163 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 172 */     LispObject[] args = new LispObject[6];
/* 173 */     args[0] = first;
/* 174 */     args[1] = second;
/* 175 */     args[2] = third;
/* 176 */     args[3] = fourth;
/* 177 */     args[4] = fifth;
/* 178 */     args[5] = sixth;
/* 179 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 189 */     LispObject[] args = new LispObject[7];
/* 190 */     args[0] = first;
/* 191 */     args[1] = second;
/* 192 */     args[2] = third;
/* 193 */     args[3] = fourth;
/* 194 */     args[4] = fifth;
/* 195 */     args[5] = sixth;
/* 196 */     args[6] = seventh;
/* 197 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 207 */     LispObject[] args = new LispObject[8];
/* 208 */     args[0] = first;
/* 209 */     args[1] = second;
/* 210 */     args[2] = third;
/* 211 */     args[3] = fourth;
/* 212 */     args[4] = fifth;
/* 213 */     args[5] = sixth;
/* 214 */     args[6] = seventh;
/* 215 */     args[7] = eighth;
/* 216 */     return execute(args);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Primitive.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */