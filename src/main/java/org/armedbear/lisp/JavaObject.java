/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.lang.reflect.Array;
/*     */ import java.lang.reflect.Field;
/*     */ import java.math.BigInteger;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Collection;
/*     */ import java.util.HashMap;
/*     */ import java.util.HashSet;
/*     */ import java.util.LinkedList;
/*     */ import java.util.List;
/*     */ import java.util.Map;
/*     */ import java.util.Set;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class JavaObject
/*     */   extends LispObject
/*     */   implements Serializable
/*     */ {
/*     */   final Object obj;
/*     */   private final Class<?> intendedClass;
/*     */   
/*     */   public JavaObject(Object obj) {
/*  49 */     this.obj = obj;
/*  50 */     this
/*  51 */       .intendedClass = (obj != null) ? Java.maybeBoxClass(obj.getClass()) : null;
/*     */   }
/*     */   
/*  54 */   public static final Symbol JAVA_CLASS_JCLASS = Lisp.PACKAGE_JAVA.intern("JAVA-CLASS-JCLASS");
/*  55 */   public static final Symbol JAVA_CLASS = Lisp.PACKAGE_JAVA.intern("JAVA-CLASS");
/*  56 */   public static final Symbol ENSURE_JAVA_CLASS = Lisp.PACKAGE_JAVA.intern("ENSURE-JAVA-CLASS");
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public JavaObject(Object obj, Class<?> intendedClass) {
/*  66 */     if (obj != null && intendedClass == null) {
/*  67 */       intendedClass = obj.getClass();
/*     */     }
/*  69 */     if (intendedClass != null) {
/*  70 */       intendedClass = Java.maybeBoxClass(intendedClass);
/*  71 */       if (!intendedClass.isInstance(obj)) {
/*  72 */         if (intendedClass.equals(Byte.class) && obj instanceof Number) {
/*     */ 
/*     */ 
/*     */           
/*  76 */           this.obj = Byte.valueOf(((Number)obj).byteValue());
/*  77 */           this.intendedClass = intendedClass;
/*     */           return;
/*     */         } 
/*  80 */         throw new ClassCastException(obj + " can not be cast to " + intendedClass);
/*     */       } 
/*     */     } 
/*  83 */     this.obj = obj;
/*  84 */     this.intendedClass = intendedClass;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  90 */     return Symbol.JAVA_OBJECT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  96 */     if (this.obj == null) {
/*  97 */       return BuiltInClass.JAVA_OBJECT;
/*     */     }
/*  99 */     return ENSURE_JAVA_CLASS.execute(new JavaObject(this.obj.getClass()));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 105 */     if (type == Symbol.JAVA_OBJECT)
/* 106 */       return Lisp.T; 
/* 107 */     if (type == BuiltInClass.JAVA_OBJECT)
/* 108 */       return Lisp.T; 
/* 109 */     LispObject cls = Lisp.NIL;
/* 110 */     if (type instanceof Symbol) {
/* 111 */       cls = LispClass.findClass(type, false);
/*     */     }
/* 113 */     if (cls == Lisp.NIL) {
/* 114 */       cls = type;
/*     */     }
/* 116 */     if (cls.typep(LispClass.findClass(JAVA_CLASS, false)) != Lisp.NIL) {
/* 117 */       if (this.obj != null) {
/* 118 */         Class c = (Class)JAVA_CLASS_JCLASS.execute(cls).javaInstance();
/* 119 */         return c.isAssignableFrom(this.obj.getClass()) ? Lisp.T : Lisp.NIL;
/*     */       } 
/* 121 */       return Lisp.T;
/*     */     } 
/* 123 */     if (cls == BuiltInClass.SEQUENCE)
/*     */     {
/*     */       
/* 126 */       if (List.class.isInstance(this.obj) || Set.class
/* 127 */         .isInstance(this.obj)) {
/* 128 */         return Lisp.T;
/*     */       }
/*     */     }
/* 131 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject STRING() {
/* 137 */     return new SimpleString((this.obj != null) ? this.obj.toString() : "null");
/*     */   }
/*     */ 
/*     */   
/*     */   public final Object getObject() {
/* 142 */     return this.obj;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject getInstance(Object obj) {
/* 152 */     if (obj == null) {
/* 153 */       return new JavaObject(null);
/*     */     }
/* 155 */     if (obj instanceof LispObject) {
/* 156 */       return (LispObject)obj;
/*     */     }
/* 158 */     return new JavaObject(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject getInstance(Object obj, Class<?> intendedClass) {
/* 170 */     if (obj == null) {
/* 171 */       return new JavaObject(null);
/*     */     }
/* 173 */     if (obj instanceof LispObject) {
/* 174 */       return (LispObject)obj;
/*     */     }
/* 176 */     return new JavaObject(obj, intendedClass);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject getInstance(Object obj, boolean translated) {
/* 189 */     return getInstance(obj, translated, (obj != null) ? obj.getClass() : null);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject getInstance(Object obj, boolean translated, Class<?> intendedClass) {
/* 209 */     if (!translated) {
/* 210 */       return getInstance(obj, intendedClass);
/*     */     }
/* 212 */     if (obj == null) return Lisp.NIL;
/*     */     
/* 214 */     if (obj instanceof LispObject) {
/* 215 */       return (LispObject)obj;
/*     */     }
/* 217 */     if (obj instanceof String) {
/* 218 */       return new SimpleString((String)obj);
/*     */     }
/* 220 */     if (obj instanceof Number) {
/*     */ 
/*     */ 
/*     */       
/* 224 */       if (obj instanceof Integer) {
/* 225 */         return Fixnum.getInstance(((Integer)obj).intValue());
/*     */       }
/* 227 */       if (obj instanceof Float) {
/* 228 */         return new SingleFloat(((Float)obj).floatValue());
/*     */       }
/* 230 */       if (obj instanceof Double) {
/* 231 */         return new DoubleFloat(((Double)obj).doubleValue());
/*     */       }
/* 233 */       if (obj instanceof Long) {
/* 234 */         return LispInteger.getInstance(((Long)obj).longValue());
/*     */       }
/* 236 */       if (obj instanceof BigInteger) {
/* 237 */         return Bignum.getInstance((BigInteger)obj);
/*     */       }
/* 239 */       if (obj instanceof Short) {
/* 240 */         return Fixnum.getInstance(((Short)obj).shortValue());
/*     */       }
/* 242 */       if (obj instanceof Byte) {
/* 243 */         return Fixnum.getInstance(((Byte)obj).byteValue());
/*     */       }
/*     */     } 
/*     */     
/* 247 */     if (obj instanceof Boolean) {
/* 248 */       return ((Boolean)obj).booleanValue() ? Lisp.T : Lisp.NIL;
/*     */     }
/* 250 */     if (obj instanceof Character) {
/* 251 */       return LispCharacter.getInstance(((Character)obj).charValue());
/*     */     }
/* 253 */     if (obj instanceof Object[]) {
/* 254 */       Object[] array = (Object[])obj;
/* 255 */       SimpleVector v = new SimpleVector(array.length);
/* 256 */       for (int i = array.length; i-- > 0;)
/* 257 */         v.aset(i, getInstance(array[i], translated)); 
/* 258 */       return v;
/*     */     } 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 264 */     return new JavaObject(obj, intendedClass);
/*     */   }
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/* 269 */     return this.obj;
/*     */   }
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class<?> c) {
/* 274 */     if (this.obj == null) {
/* 275 */       if (c.isPrimitive()) {
/* 276 */         throw new NullPointerException("Cannot assign null to " + c);
/*     */       }
/* 278 */       return this.obj;
/*     */     } 
/* 280 */     c = Java.maybeBoxClass(c);
/* 281 */     if (c.isAssignableFrom(this.intendedClass) || c.isInstance(this.obj))
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 291 */       return this.obj; } 
/* 292 */     if (c.isArray() && this.obj.getClass().isArray())
/*     */     {
/*     */ 
/*     */       
/* 296 */       return this.obj;
/*     */     }
/* 298 */     return Lisp.error(new TypeError(this.intendedClass.getName() + " is not assignable to " + c.getName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Object lockableInstance() {
/* 310 */     return this.obj;
/*     */   }
/*     */   
/*     */   public Class<?> getIntendedClass() {
/* 314 */     return this.intendedClass;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static final Object getObject(LispObject o) {
/* 320 */     if (o instanceof JavaObject)
/* 321 */       return ((JavaObject)o).obj; 
/* 322 */     return 
/* 323 */       Lisp.type_error(o, Symbol.JAVA_OBJECT);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean equal(LispObject other) {
/* 329 */     if (this == other)
/* 330 */       return true; 
/* 331 */     if (other instanceof JavaObject)
/* 332 */       return (this.obj == ((JavaObject)other).obj); 
/* 333 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean equalp(LispObject other) {
/* 339 */     return equal(other);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int sxhash() {
/* 345 */     return (this.obj == null) ? 0 : (this.obj.hashCode() & 0x7FFFFFF);
/*     */   }
/*     */ 
/*     */   
/* 349 */   public static LispObject JAVA_OBJECT_TO_STRING_LENGTH = LispInteger.getInstance(32);
/*     */ 
/*     */   
/* 352 */   public static final Symbol _JAVA_OBJECT_TO_STRING_LENGTH = Lisp.exportSpecial("*JAVA-OBJECT-TO-STRING-LENGTH*", Lisp.PACKAGE_JAVA, JAVA_OBJECT_TO_STRING_LENGTH);
/*     */ 
/*     */   
/*     */   static {
/* 356 */     String doc = "Length to truncate toString() PRINT-OBJECT output for an otherwise unspecialized JAVA-OBJECT.  Can be set to NIL to indicate no limit.";
/*     */     
/* 358 */     _JAVA_OBJECT_TO_STRING_LENGTH
/* 359 */       .setDocumentation(Symbol.VARIABLE, new SimpleString(doc));
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/*     */     String s;
/* 365 */     if (this.obj instanceof ControlTransfer) {
/* 366 */       return this.obj.toString();
/*     */     }
/* 368 */     if (this.obj != null) {
/* 369 */       Class<?> c = this.obj.getClass();
/*     */       
/* 371 */       StringBuilder sb = new StringBuilder(c.isArray() ? "jarray" : c.getName());
/* 372 */       sb.append(' ');
/*     */       try {
/* 374 */         String ts = this.obj.toString();
/* 375 */         int length = -1;
/* 376 */         LispObject stringLength = _JAVA_OBJECT_TO_STRING_LENGTH.symbolValueNoThrow();
/* 377 */         if (stringLength instanceof Fixnum) {
/* 378 */           length = Fixnum.getValue(stringLength);
/*     */         }
/* 380 */         if (length < 0) {
/* 381 */           sb.append(ts);
/* 382 */         } else if (ts.length() > length) {
/*     */           
/* 384 */           sb.append(ts.substring(0, length)).append("....");
/*     */         } else {
/* 386 */           sb.append(ts);
/*     */         } 
/* 388 */         s = sb.toString();
/* 389 */       } catch (Exception e) {
/* 390 */         return Lisp.serror(new JavaException(e));
/*     */       } 
/*     */     } else {
/* 393 */       s = "null";
/*     */     } 
/* 395 */     return unreadableString(s);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/* 400 */     return new SimpleString(describeJavaObject(this));
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 405 */     if (this.obj != null) {
/* 406 */       LispObject parts = Lisp.NIL;
/* 407 */       parts = parts.push(new Cons("Java class", new JavaObject(this.obj
/* 408 */               .getClass())));
/* 409 */       if (this.intendedClass != null) {
/* 410 */         parts = parts.push(new Cons("intendedClass", new SimpleString(this.intendedClass.getCanonicalName())));
/*     */       }
/* 412 */       if (this.obj.getClass().isArray()) {
/* 413 */         int length = Array.getLength(this.obj);
/* 414 */         for (int i = 0; i < length; i++)
/*     */         {
/* 416 */           parts = parts.push(new Cons(new SimpleString(String.valueOf(i)), 
/* 417 */                 getInstance(Array.get(this.obj, i))));
/*     */         }
/*     */       } else {
/* 420 */         parts = Symbol.NCONC.execute(parts, getInspectedFields());
/*     */       } 
/* 422 */       if (this.obj instanceof Class) {
/* 423 */         Class o = (Class)this.obj;
/*     */         try {
/* 425 */           Class[] classes = o.getClasses();
/* 426 */           LispObject classesList = Lisp.NIL;
/* 427 */           for (int j = 0; j < classes.length; j++) {
/* 428 */             classesList = classesList.push(getInstance(classes[j]));
/*     */           }
/* 430 */           if (!classesList.equals(Lisp.NIL))
/*     */           {
/* 432 */             parts = parts.push(new Cons("Member classes", classesList.nreverse()));
/*     */           }
/* 434 */         } catch (SecurityException e) {
/* 435 */           Debug.trace(e);
/*     */         } 
/* 437 */         Class[] interfaces = o.getInterfaces();
/* 438 */         LispObject interfacesList = Lisp.NIL;
/* 439 */         for (int i = 0; i < interfaces.length; i++) {
/* 440 */           interfacesList = interfacesList.push(getInstance(interfaces[i]));
/*     */         }
/* 442 */         if (!interfacesList.equals(Lisp.NIL))
/*     */         {
/* 444 */           parts = parts.push(new Cons("Interfaces", interfacesList.nreverse()));
/*     */         }
/* 446 */         LispObject superclassList = Lisp.NIL;
/* 447 */         Class superclass = o.getSuperclass();
/* 448 */         while (superclass != null) {
/* 449 */           superclassList = superclassList.push(getInstance(superclass));
/* 450 */           superclass = superclass.getSuperclass();
/*     */         } 
/* 452 */         if (!superclassList.equals(Lisp.NIL))
/*     */         {
/* 454 */           parts = parts.push(new Cons("Superclasses", superclassList.nreverse()));
/*     */         }
/*     */       } 
/* 457 */       return parts.nreverse();
/*     */     } 
/* 459 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private LispObject getInspectedFields() {
/* 465 */     final LispObject[] acc = { Lisp.NIL };
/* 466 */     doClassHierarchy(this.obj.getClass(), new Function()
/*     */         {
/*     */ 
/*     */           
/*     */           public LispObject execute(LispObject arg)
/*     */           {
/* 472 */             Class<?> c = (Class)arg.javaInstance();
/* 473 */             for (Field f : c.getDeclaredFields()) {
/* 474 */               LispObject value = Lisp.NIL;
/*     */               try {
/* 476 */                 if (!f.isAccessible()) {
/* 477 */                   f.setAccessible(true);
/*     */                 }
/* 479 */                 value = JavaObject.getInstance(f.get(JavaObject.this.obj));
/* 480 */               } catch (Exception exception) {}
/* 481 */               acc[0] = acc[0].push(new Cons(f.getName(), value));
/*     */             } 
/* 483 */             return acc[0];
/*     */           }
/*     */         });
/* 486 */     return acc[0].nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static void doClassHierarchy(Collection<Class<?>> classes, LispObject callback, Set<Class<?>> visited) {
/* 497 */     Collection<Class<?>> newClasses = new LinkedList<>();
/* 498 */     for (Class<?> clss : classes) {
/* 499 */       if (clss == null) {
/*     */         continue;
/*     */       }
/* 502 */       if (!visited.contains(clss)) {
/* 503 */         callback.execute(getInstance(clss, true));
/* 504 */         visited.add(clss);
/*     */       } 
/* 506 */       if (!visited.contains(clss.getSuperclass())) {
/* 507 */         newClasses.add(clss.getSuperclass());
/*     */       }
/* 509 */       for (Class<?> iface : clss.getInterfaces()) {
/* 510 */         if (!visited.contains(iface)) {
/* 511 */           newClasses.add(iface);
/*     */         }
/*     */       } 
/*     */     } 
/* 515 */     if (!newClasses.isEmpty()) {
/* 516 */       doClassHierarchy(newClasses, callback, visited);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static void doClassHierarchy(Class<?> clss, LispObject callback) {
/* 526 */     if (clss != null) {
/* 527 */       Set<Class<?>> visited = new HashSet<>();
/* 528 */       Collection<Class<?>> classes = new ArrayList<>(1);
/* 529 */       classes.add(clss);
/* 530 */       doClassHierarchy(classes, callback, visited);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static LispObject mapcarClassHierarchy(Class<?> clss, final LispObject fn) {
/* 537 */     final LispObject[] acc = { Lisp.NIL };
/* 538 */     doClassHierarchy(clss, new Function()
/*     */         {
/*     */           public LispObject execute(LispObject arg)
/*     */           {
/* 542 */             acc[0] = acc[0].push(fn.execute(arg));
/* 543 */             return acc[0];
/*     */           }
/*     */         });
/* 546 */     return acc[0].nreverse();
/*     */   }
/*     */ 
/*     */   
/*     */   public static String describeJavaObject(JavaObject javaObject) {
/* 551 */     Object obj = javaObject.getObject();
/*     */     
/* 553 */     StringBuilder sb = new StringBuilder(javaObject.princToString());
/* 554 */     sb.append(" is an object of type ");
/* 555 */     sb.append(Symbol.JAVA_OBJECT.princToString());
/* 556 */     sb.append(".");
/* 557 */     sb.append(System.getProperty("line.separator"));
/* 558 */     sb.append("The wrapped Java object is ");
/* 559 */     if (obj == null) {
/* 560 */       sb.append("null.");
/*     */     } else {
/* 562 */       sb.append("an ");
/* 563 */       Class<?> c = obj.getClass();
/* 564 */       String className = c.getName();
/* 565 */       if (c.isArray()) {
/* 566 */         sb.append("array of ");
/* 567 */         if (className.startsWith("[L") && className.endsWith(";")) {
/* 568 */           className = className.substring(1, className.length() - 1);
/* 569 */           sb.append(className);
/* 570 */           sb.append(" objects");
/* 571 */         } else if (className.startsWith("[") && className.length() > 1) {
/* 572 */           String type; char descriptor = className.charAt(1);
/*     */           
/* 574 */           switch (descriptor) { case 'B':
/* 575 */               type = "bytes"; break;
/* 576 */             case 'C': type = "chars"; break;
/* 577 */             case 'D': type = "doubles"; break;
/* 578 */             case 'F': type = "floats"; break;
/* 579 */             case 'I': type = "ints"; break;
/* 580 */             case 'J': type = "longs"; break;
/* 581 */             case 'S': type = "shorts"; break;
/* 582 */             case 'Z': type = "booleans"; break;
/*     */             default:
/* 584 */               type = "unknown type"; break; }
/*     */           
/* 586 */           sb.append(type);
/*     */         } 
/* 588 */         sb.append(" with ");
/* 589 */         int length = Array.getLength(obj);
/* 590 */         sb.append(length);
/* 591 */         sb.append(" element");
/* 592 */         if (length != 1)
/* 593 */           sb.append('s'); 
/* 594 */         sb.append('.');
/*     */       } else {
/* 596 */         sb.append("instance of ");
/* 597 */         sb.append(className);
/* 598 */         sb.append(':');
/* 599 */         sb.append(System.getProperty("line.separator"));
/* 600 */         sb.append("  \"");
/* 601 */         sb.append(obj.toString());
/* 602 */         sb.append('"');
/*     */       } 
/*     */     } 
/* 605 */     return sb.toString();
/*     */   }
/*     */   
/* 608 */   private static final Primitive DESCRIBE_JAVA_OBJECT = new pf_describe_java_object();
/*     */ 
/*     */   
/*     */   @DocString(name = "describe-java-object", args = "object stream", doc = "Print a human friendly description of Java OBJECT to STREAM.")
/*     */   private static final class pf_describe_java_object
/*     */     extends Primitive
/*     */   {
/*     */     pf_describe_java_object() {
/* 616 */       super("describe-java-object", Lisp.PACKAGE_JAVA, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 620 */       if (!(first instanceof JavaObject))
/* 621 */         return Lisp.type_error(first, Symbol.JAVA_OBJECT); 
/* 622 */       Stream stream = Lisp.checkStream(second);
/* 623 */       JavaObject javaObject = (JavaObject)first;
/* 624 */       stream._writeString(JavaObject.describeJavaObject(javaObject));
/* 625 */       return LispThread.currentThread().nothing();
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 634 */   private static final Map<Class<?>, LispObject> javaClassMap = new HashMap<>();
/*     */   
/*     */   public static LispObject registerJavaClass(Class<?> javaClass, LispObject classMetaObject) {
/* 637 */     synchronized (javaClassMap) {
/* 638 */       javaClassMap.put(javaClass, classMetaObject);
/* 639 */       return classMetaObject;
/*     */     } 
/*     */   }
/*     */   
/*     */   public static LispObject findJavaClass(Class<?> javaClass) {
/* 644 */     synchronized (javaClassMap) {
/* 645 */       LispObject c = javaClassMap.get(javaClass);
/* 646 */       if (c != null) {
/* 647 */         return c;
/*     */       }
/* 649 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/* 654 */   private static final Primitive _FIND_JAVA_CLASS = new Primitive("%find-java-class", Lisp.PACKAGE_JAVA, false, "class-name-or-class") {
/*     */       public LispObject execute(LispObject arg) {
/*     */         try {
/* 657 */           if (arg instanceof AbstractString) {
/* 658 */             return JavaObject.findJavaClass(Class.forName(arg.getStringValue()));
/*     */           }
/* 660 */           return JavaObject.findJavaClass((Class)arg.javaInstance());
/*     */         }
/* 662 */         catch (ClassNotFoundException e) {
/* 663 */           return Lisp.error(new LispError("Cannot find Java class " + arg.getStringValue()));
/*     */         } 
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 669 */   private static final Primitive _REGISTER_JAVA_CLASS = new Primitive("%register-java-class", Lisp.PACKAGE_JAVA, false, "jclass class-metaobject") {
/*     */       public LispObject execute(LispObject jclass, LispObject classMetaObject) {
/* 671 */         return JavaObject.registerJavaClass((Class)jclass.javaInstance(), classMetaObject);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 678 */   public static final Symbol NULL = Lisp.exportConstant("+NULL+", Lisp.PACKAGE_JAVA, new JavaObject(null));
/*     */   static {
/* 680 */     doc = "The JVM null object reference.";
/* 681 */     NULL.setDocumentation(Symbol.VARIABLE, new SimpleString(doc));
/*     */   }
/*     */ 
/*     */   
/* 685 */   public static final Symbol TRUE = Lisp.exportConstant("+TRUE+", Lisp.PACKAGE_JAVA, new JavaObject(Boolean.valueOf(true)));
/*     */   static {
/* 687 */     doc = "The JVM primitive value for boolean true.";
/* 688 */     TRUE.setDocumentation(Symbol.VARIABLE, new SimpleString(doc));
/*     */   }
/*     */ 
/*     */   
/* 692 */   public static final Symbol FALSE = Lisp.exportConstant("+FALSE+", Lisp.PACKAGE_JAVA, new JavaObject(Boolean.valueOf(false)));
/*     */   static {
/* 694 */     doc = "The JVM primitive value for boolean false.";
/* 695 */     FALSE.setDocumentation(Symbol.VARIABLE, new SimpleString(doc));
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JavaObject.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */