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
/*     */ public class BuiltInClass
/*     */   extends LispClass
/*     */ {
/*     */   private BuiltInClass(Symbol symbol) {
/*  42 */     super(symbol);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  48 */     return Symbol.BUILT_IN_CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  54 */     return StandardClass.BUILT_IN_CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isFinalized() {
/*  60 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  66 */     if (type == Symbol.BUILT_IN_CLASS)
/*  67 */       return Lisp.T; 
/*  68 */     if (type == StandardClass.BUILT_IN_CLASS)
/*  69 */       return Lisp.T; 
/*  70 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/*  76 */     return new SimpleString(princToString());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*  82 */     return unreadableString(getName().princToString());
/*     */   }
/*     */ 
/*     */   
/*     */   private static BuiltInClass addClass(Symbol symbol) {
/*  87 */     BuiltInClass c = new BuiltInClass(symbol);
/*  88 */     addClass(symbol, c);
/*  89 */     return c;
/*     */   }
/*     */   
/*  92 */   public static final BuiltInClass CLASS_T = addClass(Lisp.T);
/*     */   
/*  94 */   public static final BuiltInClass ARRAY = addClass(Symbol.ARRAY);
/*  95 */   public static final BuiltInClass BIGNUM = addClass(Symbol.BIGNUM);
/*  96 */   public static final BuiltInClass BASE_STRING = addClass(Symbol.BASE_STRING);
/*  97 */   public static final BuiltInClass BIT_VECTOR = addClass(Symbol.BIT_VECTOR);
/*  98 */   public static final BuiltInClass CHARACTER = addClass(Symbol.CHARACTER);
/*  99 */   public static final BuiltInClass COMPLEX = addClass(Symbol.COMPLEX);
/* 100 */   public static final BuiltInClass CONS = addClass(Symbol.CONS);
/* 101 */   public static final BuiltInClass DOUBLE_FLOAT = addClass(Symbol.DOUBLE_FLOAT);
/* 102 */   public static final BuiltInClass ENVIRONMENT = addClass(Symbol.ENVIRONMENT);
/* 103 */   public static final BuiltInClass FIXNUM = addClass(Symbol.FIXNUM);
/* 104 */   public static final BuiltInClass FLOAT = addClass(Symbol.FLOAT);
/* 105 */   public static final BuiltInClass FUNCTION = addClass(Symbol.FUNCTION);
/* 106 */   public static final BuiltInClass HASH_TABLE = addClass(Symbol.HASH_TABLE);
/* 107 */   public static final BuiltInClass INTEGER = addClass(Symbol.INTEGER);
/* 108 */   public static final BuiltInClass JAVA_OBJECT = addClass(Symbol.JAVA_OBJECT);
/* 109 */   public static final BuiltInClass LIST = addClass(Symbol.LIST);
/* 110 */   public static final BuiltInClass LOGICAL_PATHNAME = addClass(Symbol.LOGICAL_PATHNAME);
/* 111 */   public static final BuiltInClass MAILBOX = addClass(Symbol.MAILBOX);
/* 112 */   public static final BuiltInClass MUTEX = addClass(Symbol.MUTEX);
/* 113 */   public static final BuiltInClass NIL_VECTOR = addClass(Symbol.NIL_VECTOR);
/* 114 */   public static final BuiltInClass NULL = addClass(Symbol.NULL);
/* 115 */   public static final BuiltInClass NUMBER = addClass(Symbol.NUMBER);
/* 116 */   public static final BuiltInClass PACKAGE = addClass(Symbol.PACKAGE);
/* 117 */   public static final BuiltInClass PATHNAME = addClass(Symbol.PATHNAME);
/* 118 */   public static final BuiltInClass JAR_PATHNAME = addClass(Symbol.JAR_PATHNAME);
/* 119 */   public static final BuiltInClass URL_PATHNAME = addClass(Symbol.URL_PATHNAME);
/* 120 */   public static final BuiltInClass RANDOM_STATE = addClass(Symbol.RANDOM_STATE);
/* 121 */   public static final BuiltInClass RATIO = addClass(Symbol.RATIO);
/* 122 */   public static final BuiltInClass RATIONAL = addClass(Symbol.RATIONAL);
/* 123 */   public static final BuiltInClass READTABLE = addClass(Symbol.READTABLE);
/* 124 */   public static final BuiltInClass REAL = addClass(Symbol.REAL);
/* 125 */   public static final BuiltInClass RESTART = addClass(Symbol.RESTART);
/* 126 */   public static final BuiltInClass SEQUENCE = addClass(Symbol.SEQUENCE);
/* 127 */   public static final BuiltInClass SIMPLE_ARRAY = addClass(Symbol.SIMPLE_ARRAY);
/* 128 */   public static final BuiltInClass SIMPLE_BASE_STRING = addClass(Symbol.SIMPLE_BASE_STRING);
/* 129 */   public static final BuiltInClass SIMPLE_BIT_VECTOR = addClass(Symbol.SIMPLE_BIT_VECTOR);
/* 130 */   public static final BuiltInClass SIMPLE_STRING = addClass(Symbol.SIMPLE_STRING);
/* 131 */   public static final BuiltInClass SIMPLE_VECTOR = addClass(Symbol.SIMPLE_VECTOR);
/* 132 */   public static final BuiltInClass SINGLE_FLOAT = addClass(Symbol.SINGLE_FLOAT);
/* 133 */   public static final BuiltInClass STRING = addClass(Symbol.STRING);
/* 134 */   public static final BuiltInClass SYMBOL = addClass(Symbol.SYMBOL);
/* 135 */   public static final BuiltInClass THREAD = addClass(Symbol.THREAD);
/* 136 */   public static final BuiltInClass VECTOR = addClass(Symbol.VECTOR);
/* 137 */   public static final BuiltInClass STACK_FRAME = addClass(Symbol.STACK_FRAME);
/* 138 */   public static final BuiltInClass LISP_STACK_FRAME = addClass(Symbol.LISP_STACK_FRAME);
/* 139 */   public static final BuiltInClass JAVA_STACK_FRAME = addClass(Symbol.JAVA_STACK_FRAME);
/* 140 */   public static final BuiltInClass WEAK_REFERENCE = addClass(Symbol.WEAK_REFERENCE);
/*     */ 
/*     */ 
/*     */   
/* 144 */   public static final StructureClass STRUCTURE_OBJECT = addClass(Symbol.STRUCTURE_OBJECT, new StructureClass(Symbol.STRUCTURE_OBJECT, 
/* 145 */         Lisp.list(CLASS_T, new LispObject[0])));
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 154 */   public static final LispClass STREAM = addClass(Symbol.STREAM, new StructureClass(Symbol.STREAM, 
/* 155 */         Lisp.list(STRUCTURE_OBJECT, new LispObject[0])));
/*     */   
/* 157 */   public static final LispClass SYSTEM_STREAM = addClass(Symbol.SYSTEM_STREAM, new StructureClass(Symbol.SYSTEM_STREAM, 
/* 158 */         Lisp.list(STREAM, new LispObject[0])));
/*     */   
/* 160 */   public static final LispClass TWO_WAY_STREAM = addClass(Symbol.TWO_WAY_STREAM, new StructureClass(Symbol.TWO_WAY_STREAM, 
/* 161 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 163 */   public static final LispClass BROADCAST_STREAM = addClass(Symbol.BROADCAST_STREAM, new StructureClass(Symbol.BROADCAST_STREAM, 
/* 164 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 166 */   public static final LispClass ECHO_STREAM = addClass(Symbol.ECHO_STREAM, new StructureClass(Symbol.ECHO_STREAM, 
/* 167 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 169 */   public static final LispClass CASE_FROB_STREAM = addClass(Symbol.CASE_FROB_STREAM, new StructureClass(Symbol.CASE_FROB_STREAM, 
/* 170 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 172 */   public static final LispClass STRING_STREAM = addClass(Symbol.STRING_STREAM, new StructureClass(Symbol.STRING_STREAM, 
/* 173 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 175 */   public static final LispClass STRING_INPUT_STREAM = addClass(Symbol.STRING_INPUT_STREAM, new StructureClass(Symbol.STRING_INPUT_STREAM, 
/* 176 */         Lisp.list(STRING_STREAM, new LispObject[0])));
/*     */   
/* 178 */   public static final LispClass STRING_OUTPUT_STREAM = addClass(Symbol.STRING_OUTPUT_STREAM, new StructureClass(Symbol.STRING_OUTPUT_STREAM, 
/* 179 */         Lisp.list(STRING_STREAM, new LispObject[0])));
/*     */   
/* 181 */   public static final LispClass SYNONYM_STREAM = addClass(Symbol.SYNONYM_STREAM, new StructureClass(Symbol.SYNONYM_STREAM, 
/* 182 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 184 */   public static final LispClass FILE_STREAM = addClass(Symbol.FILE_STREAM, new StructureClass(Symbol.FILE_STREAM, 
/* 185 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 187 */   public static final LispClass JAR_STREAM = addClass(Symbol.JAR_STREAM, new StructureClass(Symbol.JAR_STREAM, 
/* 188 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 190 */   public static final LispClass URL_STREAM = addClass(Symbol.URL_STREAM, new StructureClass(Symbol.URL_STREAM, 
/* 191 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */   
/* 193 */   public static final LispClass CONCATENATED_STREAM = addClass(Symbol.CONCATENATED_STREAM, new StructureClass(Symbol.CONCATENATED_STREAM, 
/* 194 */         Lisp.list(SYSTEM_STREAM, new LispObject[0])));
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 200 */   public static final LispClass SOCKET_STREAM = addClass(Symbol.SOCKET_STREAM, new StructureClass(Symbol.SOCKET_STREAM, 
/* 201 */         Lisp.list(TWO_WAY_STREAM, new LispObject[0])));
/*     */   
/* 203 */   public static final LispClass SLIME_INPUT_STREAM = addClass(Symbol.SLIME_INPUT_STREAM, new StructureClass(Symbol.SLIME_INPUT_STREAM, 
/* 204 */         Lisp.list(STRING_STREAM, new LispObject[0])));
/*     */   
/* 206 */   public static final LispClass SLIME_OUTPUT_STREAM = addClass(Symbol.SLIME_OUTPUT_STREAM, new StructureClass(Symbol.SLIME_OUTPUT_STREAM, 
/* 207 */         Lisp.list(STRING_STREAM, new LispObject[0])));
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static {
/* 213 */     ARRAY.setDirectSuperclass(CLASS_T);
/* 214 */     ARRAY.setCPL(new LispObject[] { ARRAY, CLASS_T });
/* 215 */     BASE_STRING.setDirectSuperclass(STRING);
/* 216 */     BASE_STRING.setCPL(new LispObject[] { BASE_STRING, STRING, VECTOR, ARRAY, SEQUENCE, CLASS_T });
/* 217 */     BIGNUM.setDirectSuperclass(INTEGER);
/* 218 */     BIGNUM.setCPL(new LispObject[] { BIGNUM, INTEGER, RATIONAL, REAL, NUMBER, CLASS_T });
/* 219 */     BIT_VECTOR.setDirectSuperclass(VECTOR);
/* 220 */     BIT_VECTOR.setCPL(new LispObject[] { BIT_VECTOR, VECTOR, ARRAY, SEQUENCE, CLASS_T });
/* 221 */     BROADCAST_STREAM.setCPL(new LispObject[] { BROADCAST_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 223 */     CASE_FROB_STREAM.setCPL(new LispObject[] { CASE_FROB_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 225 */     CHARACTER.setDirectSuperclass(CLASS_T);
/* 226 */     CHARACTER.setCPL(new LispObject[] { CHARACTER, CLASS_T });
/* 227 */     CLASS_T.setCPL(new LispObject[] { CLASS_T });
/* 228 */     COMPLEX.setDirectSuperclass(NUMBER);
/* 229 */     COMPLEX.setCPL(new LispObject[] { COMPLEX, NUMBER, CLASS_T });
/* 230 */     CONCATENATED_STREAM.setCPL(new LispObject[] { CONCATENATED_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 232 */     CONS.setDirectSuperclass(LIST);
/* 233 */     CONS.setCPL(new LispObject[] { CONS, LIST, SEQUENCE, CLASS_T });
/* 234 */     DOUBLE_FLOAT.setDirectSuperclass(FLOAT);
/* 235 */     DOUBLE_FLOAT.setCPL(new LispObject[] { DOUBLE_FLOAT, FLOAT, REAL, NUMBER, CLASS_T });
/* 236 */     ECHO_STREAM.setCPL(new LispObject[] { ECHO_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 238 */     ENVIRONMENT.setDirectSuperclass(CLASS_T);
/* 239 */     ENVIRONMENT.setCPL(new LispObject[] { ENVIRONMENT, CLASS_T });
/* 240 */     FIXNUM.setDirectSuperclass(INTEGER);
/* 241 */     FIXNUM.setCPL(new LispObject[] { FIXNUM, INTEGER, RATIONAL, REAL, NUMBER, CLASS_T });
/* 242 */     FILE_STREAM.setCPL(new LispObject[] { FILE_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 244 */     JAR_STREAM.setCPL(new LispObject[] { JAR_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 246 */     URL_STREAM.setCPL(new LispObject[] { URL_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 248 */     FLOAT.setDirectSuperclass(REAL);
/* 249 */     FLOAT.setCPL(new LispObject[] { FLOAT, REAL, NUMBER, CLASS_T });
/* 250 */     FUNCTION.setDirectSuperclass(CLASS_T);
/* 251 */     FUNCTION.setCPL(new LispObject[] { FUNCTION, CLASS_T });
/* 252 */     HASH_TABLE.setDirectSuperclass(CLASS_T);
/* 253 */     HASH_TABLE.setCPL(new LispObject[] { HASH_TABLE, CLASS_T });
/* 254 */     INTEGER.setDirectSuperclass(RATIONAL);
/* 255 */     INTEGER.setCPL(new LispObject[] { INTEGER, RATIONAL, REAL, NUMBER, CLASS_T });
/* 256 */     JAVA_OBJECT.setDirectSuperclass(CLASS_T);
/* 257 */     JAVA_OBJECT.setCPL(new LispObject[] { JAVA_OBJECT, CLASS_T });
/* 258 */     LIST.setDirectSuperclass(SEQUENCE);
/* 259 */     LIST.setCPL(new LispObject[] { LIST, SEQUENCE, CLASS_T });
/* 260 */     LOGICAL_PATHNAME.setDirectSuperclass(PATHNAME);
/* 261 */     LOGICAL_PATHNAME.setCPL(new LispObject[] { LOGICAL_PATHNAME, PATHNAME, CLASS_T });
/* 262 */     MAILBOX.setDirectSuperclass(CLASS_T);
/* 263 */     MAILBOX.setCPL(new LispObject[] { MAILBOX, CLASS_T });
/* 264 */     MUTEX.setDirectSuperclass(CLASS_T);
/* 265 */     MUTEX.setCPL(new LispObject[] { MUTEX, CLASS_T });
/* 266 */     NIL_VECTOR.setDirectSuperclass(STRING);
/* 267 */     NIL_VECTOR.setCPL(new LispObject[] { NIL_VECTOR, STRING, VECTOR, ARRAY, SEQUENCE, CLASS_T });
/* 268 */     NULL.setDirectSuperclass(LIST);
/* 269 */     NULL.setCPL(new LispObject[] { NULL, SYMBOL, LIST, SEQUENCE, CLASS_T });
/* 270 */     NUMBER.setDirectSuperclass(CLASS_T);
/* 271 */     NUMBER.setCPL(new LispObject[] { NUMBER, CLASS_T });
/* 272 */     PACKAGE.setDirectSuperclass(CLASS_T);
/* 273 */     PACKAGE.setCPL(new LispObject[] { PACKAGE, CLASS_T });
/* 274 */     PATHNAME.setDirectSuperclass(CLASS_T);
/* 275 */     PATHNAME.setCPL(new LispObject[] { PATHNAME, CLASS_T });
/* 276 */     JAR_PATHNAME.setDirectSuperclass(PATHNAME);
/* 277 */     JAR_PATHNAME.setCPL(new LispObject[] { JAR_PATHNAME, PATHNAME, CLASS_T });
/* 278 */     URL_PATHNAME.setDirectSuperclass(PATHNAME);
/* 279 */     URL_PATHNAME.setCPL(new LispObject[] { URL_PATHNAME, PATHNAME, CLASS_T });
/* 280 */     RANDOM_STATE.setDirectSuperclass(CLASS_T);
/* 281 */     RANDOM_STATE.setCPL(new LispObject[] { RANDOM_STATE, CLASS_T });
/* 282 */     RATIO.setDirectSuperclass(RATIONAL);
/* 283 */     RATIO.setCPL(new LispObject[] { RATIO, RATIONAL, REAL, NUMBER, CLASS_T });
/* 284 */     RATIONAL.setDirectSuperclass(REAL);
/* 285 */     RATIONAL.setCPL(new LispObject[] { RATIONAL, REAL, NUMBER, CLASS_T });
/* 286 */     READTABLE.setDirectSuperclass(CLASS_T);
/* 287 */     READTABLE.setCPL(new LispObject[] { READTABLE, CLASS_T });
/* 288 */     REAL.setDirectSuperclass(NUMBER);
/* 289 */     REAL.setCPL(new LispObject[] { REAL, NUMBER, CLASS_T });
/* 290 */     RESTART.setDirectSuperclass(CLASS_T);
/* 291 */     RESTART.setCPL(new LispObject[] { RESTART, CLASS_T });
/* 292 */     SEQUENCE.setDirectSuperclass(CLASS_T);
/* 293 */     SEQUENCE.setCPL(new LispObject[] { SEQUENCE, CLASS_T });
/* 294 */     SIMPLE_ARRAY.setDirectSuperclass(ARRAY);
/* 295 */     SIMPLE_ARRAY.setCPL(new LispObject[] { SIMPLE_ARRAY, ARRAY, CLASS_T });
/* 296 */     SIMPLE_BASE_STRING.setDirectSuperclasses(Lisp.list(BASE_STRING, new LispObject[] { SIMPLE_STRING }));
/* 297 */     SIMPLE_BASE_STRING.setCPL(new LispObject[] { SIMPLE_BASE_STRING, BASE_STRING, SIMPLE_STRING, STRING, VECTOR, SIMPLE_ARRAY, ARRAY, SEQUENCE, CLASS_T });
/*     */ 
/*     */     
/* 300 */     SIMPLE_BIT_VECTOR.setDirectSuperclasses(Lisp.list(BIT_VECTOR, new LispObject[] { SIMPLE_ARRAY }));
/* 301 */     SIMPLE_BIT_VECTOR.setCPL(new LispObject[] { SIMPLE_BIT_VECTOR, BIT_VECTOR, VECTOR, SIMPLE_ARRAY, ARRAY, SEQUENCE, CLASS_T });
/*     */     
/* 303 */     SIMPLE_STRING.setDirectSuperclasses(Lisp.list(BASE_STRING, new LispObject[] { STRING, SIMPLE_ARRAY }));
/* 304 */     SIMPLE_STRING.setCPL(new LispObject[] { SIMPLE_STRING, BASE_STRING, STRING, VECTOR, SIMPLE_ARRAY, ARRAY, SEQUENCE, CLASS_T });
/*     */     
/* 306 */     SIMPLE_VECTOR.setDirectSuperclasses(Lisp.list(VECTOR, new LispObject[] { SIMPLE_ARRAY }));
/* 307 */     SIMPLE_VECTOR.setCPL(new LispObject[] { SIMPLE_VECTOR, VECTOR, SIMPLE_ARRAY, ARRAY, SEQUENCE, CLASS_T });
/*     */     
/* 309 */     SINGLE_FLOAT.setDirectSuperclass(FLOAT);
/* 310 */     SINGLE_FLOAT.setCPL(new LispObject[] { SINGLE_FLOAT, FLOAT, REAL, NUMBER, CLASS_T });
/* 311 */     SLIME_INPUT_STREAM.setCPL(new LispObject[] { SLIME_INPUT_STREAM, STRING_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 313 */     SLIME_OUTPUT_STREAM.setCPL(new LispObject[] { SLIME_OUTPUT_STREAM, STRING_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 315 */     SOCKET_STREAM.setCPL(new LispObject[] { SOCKET_STREAM, TWO_WAY_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 317 */     STREAM.setCPL(new LispObject[] { STREAM, STRUCTURE_OBJECT, CLASS_T });
/* 318 */     STRING.setDirectSuperclass(VECTOR);
/* 319 */     STRING.setCPL(new LispObject[] { STRING, VECTOR, ARRAY, SEQUENCE, CLASS_T });
/* 320 */     STRING_INPUT_STREAM.setCPL(new LispObject[] { STRING_INPUT_STREAM, STRING_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 322 */     STRING_OUTPUT_STREAM.setCPL(new LispObject[] { STRING_OUTPUT_STREAM, STRING_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 324 */     STRING_STREAM.setCPL(new LispObject[] { STRING_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 326 */     STRUCTURE_OBJECT.setCPL(new LispObject[] { STRUCTURE_OBJECT, CLASS_T });
/* 327 */     SYMBOL.setDirectSuperclass(CLASS_T);
/* 328 */     SYMBOL.setCPL(new LispObject[] { SYMBOL, CLASS_T });
/* 329 */     SYNONYM_STREAM.setCPL(new LispObject[] { SYNONYM_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 331 */     SYSTEM_STREAM.setCPL(new LispObject[] { SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/* 332 */     THREAD.setDirectSuperclass(CLASS_T);
/* 333 */     THREAD.setCPL(new LispObject[] { THREAD, CLASS_T });
/* 334 */     TWO_WAY_STREAM.setCPL(new LispObject[] { TWO_WAY_STREAM, SYSTEM_STREAM, STREAM, STRUCTURE_OBJECT, CLASS_T });
/*     */     
/* 336 */     VECTOR.setDirectSuperclasses(Lisp.list(ARRAY, new LispObject[] { SEQUENCE }));
/* 337 */     VECTOR.setCPL(new LispObject[] { VECTOR, ARRAY, SEQUENCE, CLASS_T });
/* 338 */     STACK_FRAME.setDirectSuperclasses(CLASS_T);
/* 339 */     STACK_FRAME.setCPL(new LispObject[] { STACK_FRAME, CLASS_T });
/* 340 */     LISP_STACK_FRAME.setDirectSuperclasses(STACK_FRAME);
/* 341 */     LISP_STACK_FRAME.setCPL(new LispObject[] { LISP_STACK_FRAME, STACK_FRAME, CLASS_T });
/* 342 */     JAVA_STACK_FRAME.setDirectSuperclasses(STACK_FRAME);
/* 343 */     JAVA_STACK_FRAME.setCPL(new LispObject[] { JAVA_STACK_FRAME, STACK_FRAME, CLASS_T });
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 348 */     StandardClass.initializeStandardClasses();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BuiltInClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */