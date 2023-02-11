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
/*     */ 
/*     */ public final class CharacterFunctions
/*     */ {
/*  41 */   private static final Primitive CHAR_EQUALS = new Primitive("char=", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/*  47 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/*  52 */         if (arg instanceof LispCharacter)
/*  53 */           return Lisp.T; 
/*  54 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/*  60 */         return (LispCharacter.getValue(first) == LispCharacter.getValue(second)) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] array) {
/*  65 */         int length = array.length;
/*  66 */         char c0 = LispCharacter.getValue(array[0]);
/*  67 */         for (int i = 1; i < length; i++) {
/*  68 */           if (c0 != LispCharacter.getValue(array[i]))
/*  69 */             return Lisp.NIL; 
/*     */         } 
/*  71 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  76 */   private static final Primitive CHAR_EQUAL = new Primitive("char-equal", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/*  82 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/*  87 */         if (arg instanceof LispCharacter)
/*  88 */           return Lisp.T; 
/*  89 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/*  96 */         char c1 = LispCharacter.getValue(first);
/*  97 */         char c2 = LispCharacter.getValue(second);
/*  98 */         if (c1 == c2)
/*  99 */           return Lisp.T; 
/* 100 */         if (LispCharacter.toUpperCase(c1) == LispCharacter.toUpperCase(c2))
/* 101 */           return Lisp.T; 
/* 102 */         if (LispCharacter.toLowerCase(c1) == LispCharacter.toLowerCase(c2))
/* 103 */           return Lisp.T; 
/* 104 */         return Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] array) {
/* 109 */         int length = array.length;
/* 110 */         char c0 = LispCharacter.getValue(array[0]);
/* 111 */         for (int i = 1; i < length; i++) {
/* 112 */           char c = LispCharacter.getValue(array[i]);
/* 113 */           if (c0 != c)
/*     */           {
/* 115 */             if (LispCharacter.toUpperCase(c0) != LispCharacter.toUpperCase(c))
/*     */             {
/* 117 */               if (LispCharacter.toLowerCase(c0) != LispCharacter.toLowerCase(c))
/*     */               {
/* 119 */                 return Lisp.NIL; }  }  } 
/*     */         } 
/* 121 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 126 */   private static final Primitive CHAR_GREATERP = new Primitive("char-greaterp", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 132 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 137 */         if (arg instanceof LispCharacter)
/* 138 */           return Lisp.T; 
/* 139 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 145 */         char c1 = LispCharacter.toUpperCase(LispCharacter.getValue(first));
/* 146 */         char c2 = LispCharacter.toUpperCase(LispCharacter.getValue(second));
/* 147 */         return (c1 > c2) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] array) {
/* 152 */         int length = array.length;
/* 153 */         char[] chars = new char[length]; int i;
/* 154 */         for (i = 0; i < length; i++)
/* 155 */           chars[i] = LispCharacter.toUpperCase(LispCharacter.getValue(array[i])); 
/* 156 */         for (i = 1; i < length; i++) {
/* 157 */           if (chars[i - 1] <= chars[i])
/* 158 */             return Lisp.NIL; 
/*     */         } 
/* 160 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 165 */   private static final Primitive CHAR_NOT_GREATERP = new Primitive("char-not-greaterp", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 171 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 176 */         if (arg instanceof LispCharacter)
/* 177 */           return Lisp.T; 
/* 178 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 184 */         char c1 = LispCharacter.toUpperCase(LispCharacter.getValue(first));
/* 185 */         char c2 = LispCharacter.toUpperCase(LispCharacter.getValue(second));
/* 186 */         return (c1 <= c2) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] array) {
/* 191 */         int length = array.length;
/* 192 */         char[] chars = new char[length]; int i;
/* 193 */         for (i = 0; i < length; i++)
/* 194 */           chars[i] = LispCharacter.toUpperCase(LispCharacter.getValue(array[i])); 
/* 195 */         for (i = 1; i < length; i++) {
/* 196 */           if (chars[i] < chars[i - 1])
/* 197 */             return Lisp.NIL; 
/*     */         } 
/* 199 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 204 */   private static final Primitive CHAR_LESS_THAN = new Primitive("char<", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 210 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 215 */         if (arg instanceof LispCharacter)
/* 216 */           return Lisp.T; 
/* 217 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 223 */         return (LispCharacter.getValue(first) < LispCharacter.getValue(second)) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args) {
/* 228 */         int length = args.length;
/* 229 */         char[] chars = new char[length]; int i;
/* 230 */         for (i = 0; i < length; i++) {
/* 231 */           chars[i] = LispCharacter.getValue(args[i]);
/*     */         }
/* 233 */         for (i = 1; i < length; i++) {
/* 234 */           if (chars[i - 1] >= chars[i])
/* 235 */             return Lisp.NIL; 
/*     */         } 
/* 237 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 242 */   private static final Primitive CHAR_LE = new Primitive("char<=", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 248 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 253 */         if (arg instanceof LispCharacter)
/* 254 */           return Lisp.T; 
/* 255 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 261 */         return (LispCharacter.getValue(first) <= LispCharacter.getValue(second)) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 268 */         if (LispCharacter.getValue(first) > LispCharacter.getValue(second))
/* 269 */           return Lisp.NIL; 
/* 270 */         if (LispCharacter.getValue(second) > LispCharacter.getValue(third))
/* 271 */           return Lisp.NIL; 
/* 272 */         return Lisp.T;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args) {
/* 277 */         int length = args.length;
/* 278 */         char[] chars = new char[length]; int i;
/* 279 */         for (i = 0; i < length; i++) {
/* 280 */           chars[i] = LispCharacter.getValue(args[i]);
/*     */         }
/* 282 */         for (i = 1; i < length; i++) {
/* 283 */           if (chars[i - 1] > chars[i])
/* 284 */             return Lisp.NIL; 
/*     */         } 
/* 286 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 291 */   private static final Primitive CHAR_LESSP = new Primitive("char-lessp", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 297 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 302 */         if (arg instanceof LispCharacter)
/* 303 */           return Lisp.T; 
/* 304 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 310 */         char c1 = LispCharacter.toUpperCase(LispCharacter.getValue(first));
/* 311 */         char c2 = LispCharacter.toUpperCase(LispCharacter.getValue(second));
/* 312 */         return (c1 < c2) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] array) {
/* 317 */         int length = array.length;
/* 318 */         char[] chars = new char[length]; int i;
/* 319 */         for (i = 0; i < length; i++)
/* 320 */           chars[i] = LispCharacter.toUpperCase(LispCharacter.getValue(array[i])); 
/* 321 */         for (i = 1; i < length; i++) {
/* 322 */           if (chars[i - 1] >= chars[i])
/* 323 */             return Lisp.NIL; 
/*     */         } 
/* 325 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 330 */   private static final Primitive CHAR_NOT_LESSP = new Primitive("char-not-lessp", "&rest characters")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 336 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 341 */         if (arg instanceof LispCharacter)
/* 342 */           return Lisp.T; 
/* 343 */         return Lisp.type_error(arg, Symbol.CHARACTER);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 349 */         char c1 = LispCharacter.toUpperCase(LispCharacter.getValue(first));
/* 350 */         char c2 = LispCharacter.toUpperCase(LispCharacter.getValue(second));
/* 351 */         return (c1 >= c2) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] array) {
/* 356 */         int length = array.length;
/* 357 */         char[] chars = new char[length]; int i;
/* 358 */         for (i = 0; i < length; i++)
/* 359 */           chars[i] = LispCharacter.toUpperCase(LispCharacter.getValue(array[i])); 
/* 360 */         for (i = 1; i < length; i++) {
/* 361 */           if (chars[i] > chars[i - 1])
/* 362 */             return Lisp.NIL; 
/*     */         } 
/* 364 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CharacterFunctions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */