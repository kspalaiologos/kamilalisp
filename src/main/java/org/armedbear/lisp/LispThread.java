/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.lang.ref.WeakReference;
/*      */ import java.lang.reflect.InvocationTargetException;
/*      */ import java.lang.reflect.Method;
/*      */ import java.text.MessageFormat;
/*      */ import java.util.Iterator;
/*      */ import java.util.Stack;
/*      */ import java.util.concurrent.ConcurrentHashMap;
/*      */ import java.util.concurrent.ConcurrentLinkedQueue;
/*      */ import java.util.concurrent.atomic.AtomicInteger;
/*      */ import org.armedbear.lisp.protocol.Inspectable;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ public final class LispThread
/*      */   extends LispObject
/*      */ {
/*   52 */   static final ConcurrentHashMap<Thread, LispThread> map = new ConcurrentHashMap<>();
/*      */ 
/*      */   
/*   55 */   LispObject threadValue = Lisp.NIL;
/*      */   
/*   57 */   private static ThreadLocal<LispThread> threads = new ThreadLocal<LispThread>()
/*      */     {
/*      */       public LispThread initialValue() {
/*   60 */         Thread thisThread = Thread.currentThread();
/*   61 */         LispThread thread = LispThread.map.get(thisThread);
/*   62 */         if (thread == null) {
/*   63 */           thread = new LispThread(thisThread);
/*   64 */           LispThread.map.put(thisThread, thread);
/*      */         } 
/*   66 */         return thread;
/*      */       }
/*      */     };
/*      */   final Thread javaThread; private boolean destroyed; final LispObject name; public LispObject[] _values; private boolean threadInterrupted;
/*      */   
/*      */   public static final LispThread currentThread() {
/*   72 */     return threads.get();
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*   80 */   private LispObject pending = Lisp.NIL;
/*   81 */   private Symbol wrapper = Lisp.PACKAGE_THREADS
/*   82 */     .intern("THREAD-FUNCTION-WRAPPER");
/*      */ 
/*      */   
/*   85 */   public Stack<Environment> envStack = new Stack<>();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static boolean virtualThreadingAvailable() {
/*      */     try {
/*   95 */       Class<?> clazz = Class.forName("java.lang.Thread");
/*   96 */       Class[] parameters = { Runnable.class };
/*   97 */       Method method = clazz.getDeclaredMethod("startVirtualThread", parameters);
/*   98 */       return true;
/*   99 */     } catch (ClassNotFoundException e1) {
/*  100 */       Debug.trace("Failed to get java.lang.Thread by name");
/*  101 */     } catch (NoSuchMethodException noSuchMethodException) {
/*      */     
/*  103 */     } catch (SecurityException e3) {
/*  104 */       Debug.trace("SecurityException caught introspecting threading interface: " + e3.toString());
/*      */     } 
/*  106 */     return false;
/*      */   }
/*      */   
/*  109 */   public static Symbol NATIVE_THREADS = Lisp.internKeyword("NATIVE");
/*  110 */   public static Symbol VIRTUAL_THREADS = Lisp.internKeyword("VIRTUAL");
/*      */   
/*      */   static {
/*  113 */     if (virtualThreadingAvailable()) {
/*  114 */       Symbol._THREADING_MODEL.initializeSpecial(VIRTUAL_THREADS);
/*      */     } else {
/*  116 */       Symbol._THREADING_MODEL.initializeSpecial(NATIVE_THREADS);
/*      */     } 
/*      */   }
/*      */   
/*  120 */   static Method threadBuilder = null;
/*  121 */   static Method builderName = null;
/*  122 */   static Method builderDaemon = null;
/*  123 */   static Method builderVirtual = null;
/*  124 */   static Method builderTask = null;
/*  125 */   static Method builderBuild = null; static final int UNASSIGNED_SPECIAL_INDEX = 0;
/*      */   
/*      */   static {
/*      */     try {
/*  129 */       Class<?> clazz = Class.forName("java.lang.Thread");
/*  130 */       threadBuilder = clazz.getDeclaredMethod("builder", new Class[0]);
/*  131 */       clazz = Class.forName("java.lang.Thread$Builder");
/*  132 */       builderDaemon = clazz.getDeclaredMethod("daemon", new Class[] { boolean.class });
/*  133 */       builderName = clazz.getDeclaredMethod("name", new Class[] { String.class });
/*  134 */       builderVirtual = clazz.getDeclaredMethod("virtual", new Class[0]);
/*  135 */       builderTask = clazz.getDeclaredMethod("task", new Class[] { Runnable.class });
/*  136 */       builderBuild = clazz.getDeclaredMethod("build", new Class[0]);
/*  137 */     } catch (Exception e) {
/*  138 */       if (virtualThreadingAvailable()) {
/*  139 */         Debug.trace("Failed to introspect virtual threading methods: " + e);
/*      */       }
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public StackTraceElement[] getJavaStackTrace() {
/*  215 */     return this.javaThread.getStackTrace();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject typeOf() {
/*  221 */     return Symbol.THREAD;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject classOf() {
/*  227 */     return BuiltInClass.THREAD;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject typep(LispObject typeSpecifier) {
/*  233 */     if (typeSpecifier == Symbol.THREAD)
/*  234 */       return Lisp.T; 
/*  235 */     if (typeSpecifier == BuiltInClass.THREAD)
/*  236 */       return Lisp.T; 
/*  237 */     return super.typep(typeSpecifier);
/*      */   }
/*      */ 
/*      */   
/*      */   public final synchronized boolean isDestroyed() {
/*  242 */     return this.destroyed;
/*      */   }
/*      */ 
/*      */   
/*      */   final synchronized boolean isInterrupted() {
/*  247 */     return this.threadInterrupted;
/*      */   }
/*      */ 
/*      */   
/*      */   final synchronized void setDestroyed(boolean b) {
/*  252 */     this.destroyed = b;
/*      */   }
/*      */ 
/*      */   
/*      */   final synchronized void interrupt(LispObject function, LispObject args) {
/*  257 */     this.pending = new Cons(args, this.pending);
/*  258 */     this.pending = new Cons(function, this.pending);
/*  259 */     this.threadInterrupted = true;
/*  260 */     this.javaThread.interrupt();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   final synchronized void processThreadInterrupts() {
/*  266 */     while (this.pending != Lisp.NIL) {
/*  267 */       LispObject function = this.pending.car();
/*  268 */       LispObject args = this.pending.cadr();
/*  269 */       this.pending = this.pending.cddr();
/*  270 */       Primitives.APPLY.execute(function, args);
/*      */     } 
/*  272 */     this.threadInterrupted = false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject[] getValues() {
/*  277 */     return this._values;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject[] getValues(LispObject result, int count) {
/*  282 */     if (this._values == null) {
/*  283 */       LispObject[] arrayOfLispObject = new LispObject[count];
/*  284 */       if (count > 0)
/*  285 */         arrayOfLispObject[0] = result; 
/*  286 */       for (int j = 1; j < count; j++)
/*  287 */         arrayOfLispObject[j] = Lisp.NIL; 
/*  288 */       return arrayOfLispObject;
/*      */     } 
/*      */ 
/*      */     
/*  292 */     if (count <= this._values.length) {
/*  293 */       return this._values;
/*      */     }
/*  295 */     LispObject[] values = new LispObject[count]; int i;
/*  296 */     for (i = this._values.length; i-- > 0;)
/*  297 */       values[i] = this._values[i]; 
/*  298 */     for (i = this._values.length; i < count; i++)
/*  299 */       values[i] = Lisp.NIL; 
/*  300 */     return values;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject[] accumulateValues(LispObject result, LispObject[] oldValues) {
/*  307 */     if (oldValues == null) {
/*  308 */       if (this._values != null)
/*  309 */         return this._values; 
/*  310 */       LispObject[] arrayOfLispObject = new LispObject[1];
/*  311 */       arrayOfLispObject[0] = result;
/*  312 */       return arrayOfLispObject;
/*      */     } 
/*  314 */     if (this._values != null) {
/*  315 */       if (this._values.length == 0)
/*  316 */         return oldValues; 
/*  317 */       int i = oldValues.length + this._values.length;
/*  318 */       LispObject[] arrayOfLispObject = new LispObject[i];
/*  319 */       System.arraycopy(oldValues, 0, arrayOfLispObject, 0, oldValues.length);
/*      */ 
/*      */       
/*  322 */       System.arraycopy(this._values, 0, arrayOfLispObject, oldValues.length, this._values.length);
/*      */ 
/*      */       
/*  325 */       return arrayOfLispObject;
/*      */     } 
/*      */     
/*  328 */     int totalLength = oldValues.length + 1;
/*  329 */     LispObject[] values = new LispObject[totalLength];
/*  330 */     System.arraycopy(oldValues, 0, values, 0, oldValues.length);
/*      */ 
/*      */     
/*  333 */     values[totalLength - 1] = result;
/*  334 */     return values;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject setValues() {
/*  339 */     this._values = new LispObject[0];
/*  340 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject setValues(LispObject value1) {
/*  345 */     this._values = null;
/*  346 */     return value1;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject setValues(LispObject value1, LispObject value2) {
/*  351 */     this._values = new LispObject[2];
/*  352 */     this._values[0] = value1;
/*  353 */     this._values[1] = value2;
/*  354 */     return value1;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject setValues(LispObject value1, LispObject value2, LispObject value3) {
/*  360 */     this._values = new LispObject[3];
/*  361 */     this._values[0] = value1;
/*  362 */     this._values[1] = value2;
/*  363 */     this._values[2] = value3;
/*  364 */     return value1;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject setValues(LispObject value1, LispObject value2, LispObject value3, LispObject value4) {
/*  370 */     this._values = new LispObject[4];
/*  371 */     this._values[0] = value1;
/*  372 */     this._values[1] = value2;
/*  373 */     this._values[2] = value3;
/*  374 */     this._values[3] = value4;
/*  375 */     return value1;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject setValues(LispObject[] values) {
/*  380 */     switch (values.length) {
/*      */       case 0:
/*  382 */         this._values = values;
/*  383 */         return Lisp.NIL;
/*      */       case 1:
/*  385 */         this._values = null;
/*  386 */         return values[0];
/*      */     } 
/*  388 */     this._values = values;
/*  389 */     return values[0];
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final void clearValues() {
/*  395 */     this._values = null;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject nothing() {
/*  400 */     this._values = new LispObject[0];
/*  401 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject value(LispObject obj) {
/*  410 */     this._values = null;
/*  411 */     return obj;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  424 */   static final AtomicInteger lastSpecial = new AtomicInteger(0);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  430 */   static final ConcurrentLinkedQueue<Integer> freeSpecialIndices = new ConcurrentLinkedQueue<>();
/*      */ 
/*      */ 
/*      */   
/*  434 */   static final int specialsInitialSize = Integer.valueOf(System.getProperty("abcl.specials.initialSize", "4096")).intValue();
/*      */ 
/*      */ 
/*      */   
/*      */   SpecialBinding[] specials;
/*      */ 
/*      */ 
/*      */   
/*      */   LispThread(Thread javaThread)
/*      */   {
/*  444 */     this.specials = new SpecialBinding[specialsInitialSize + 1];
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  460 */     this.savedSpecials = null;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  659 */     this.catchTags = Lisp.NIL;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  712 */     this.STACK_FRAME_EXTRA = 2;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  726 */     this.topStackSegment = new StackSegment(1024, null);
/*  727 */     this.stack = this.topStackSegment.stack;
/*  728 */     this.stackPtr = 0; this.javaThread = javaThread; this.name = new SimpleString(javaThread.getName()); } LispThread(final Function fun, LispObject name) { this.specials = new SpecialBinding[specialsInitialSize + 1]; this.savedSpecials = null; this.catchTags = Lisp.NIL; this.STACK_FRAME_EXTRA = 2; this.topStackSegment = new StackSegment(1024, null); this.stack = this.topStackSegment.stack; this.stackPtr = 0; Runnable r = new Runnable() {
/*      */         public void run() { try { LispThread.this.threadValue = Lisp.funcall(LispThread.this.wrapper, new LispObject[] { this.val$fun }, LispThread.this); } catch (ThreadDestroyed threadDestroyed) {  } catch (ProcessingTerminated e) { System.exit(e.getStatus()); } catch (Throwable t) { if (LispThread.this.isInterrupted()) LispThread.this.processThreadInterrupts();  String msg = MessageFormat.format("Ignoring uncaught exception {0}.", new Object[] { t.toString() }); Debug.warn(msg); } finally { LispThread.map.remove(Thread.currentThread()); }  }
/*      */       }; this.name = name; Thread thread = null; if (Symbol._THREADING_MODEL.getSymbolValue().equals(NATIVE_THREADS)) { thread = new Thread(r); if (name != Lisp.NIL) thread.setName(name.getStringValue());  thread.setDaemon(true); } else { synchronized (threadBuilder) { Object o = null; try { o = threadBuilder.invoke(null, new Object[0]); if (name != Lisp.NIL) o = builderName.invoke(o, new Object[] { name.getStringValue() });  o = builderDaemon.invoke(o, new Object[] { Boolean.valueOf(true) }); o = builderVirtual.invoke(o, new Object[0]); o = builderTask.invoke(o, new Object[] { r }); thread = (Thread)builderBuild.invoke(o, new Object[0]); } catch (IllegalAccessException e1) { Debug.trace("Use of reflection to start virtual thread failed: " + e1.toString()); } catch (InvocationTargetException e2) { Debug.trace("Failed to invoke method to start virtual thread: " + e2.toString()); }  }  }  if (thread == null) { Debug.trace("Failed to create java.lang.Thread"); this.javaThread = null; } else { this.javaThread = thread; map.put(this.javaThread, this); this.javaThread.start(); }  }
/*      */   static final ConcurrentHashMap<Integer, WeakReference<Symbol>> specialNames = new ConcurrentHashMap<>();
/*      */   static final int specialsDelta = Integer.valueOf(System.getProperty("abcl.specials.grow.delta", "1024")).intValue();
/*      */   private SpecialBindingsMark savedSpecials;
/*      */   private LispObject catchTags;
/*      */   public final SpecialBindingsMark markSpecialBindings() { return this.savedSpecials; }
/*      */   public final void resetSpecialBindings(SpecialBindingsMark mark) { SpecialBindingsMark c = this.savedSpecials; while (mark != c) { this.specials[c.idx] = c.binding; c = c.next; }  this.savedSpecials = c; } final void clearSpecialBindings() { resetSpecialBindings(null); } private void assignSpecialIndex(Symbol sym) { if (sym.specialIndex != 0) return;  synchronized (sym) { if (sym.specialIndex == 0) { Integer next = freeSpecialIndices.poll(); if (next == null && this.specials.length < lastSpecial.get() && null == System.getProperty("abcl.specials.grow.slowly")) { System.gc(); next = freeSpecialIndices.poll(); }  if (next == null) { sym.specialIndex = lastSpecial.incrementAndGet(); } else { sym.specialIndex = next.intValue(); }  }  }  } protected static void releaseSpecialIndex(Symbol sym) { int index = sym.specialIndex; if (index != 0) { Iterator<LispThread> it = map.values().iterator(); while (it.hasNext()) { LispThread thread = it.next(); SpecialBindingsMark savedSpecial = thread.savedSpecials; while (savedSpecial != null) { if (savedSpecial.idx == index) { savedSpecial.idx = 0; savedSpecial.binding = null; }  savedSpecial = savedSpecial.next; }  thread.specials[index] = null; }  freeSpecialIndices.add(Integer.valueOf(index)); }  } private void growSpecials() { SpecialBinding[] newSpecials = new SpecialBinding[this.specials.length + specialsDelta]; System.arraycopy(this.specials, 0, newSpecials, 0, this.specials.length); this.specials = newSpecials; } private SpecialBinding ensureSpecialBinding(int idx) { while (true) { SpecialBinding binding; boolean assigned; try { binding = this.specials[idx]; assigned = true; } catch (ArrayIndexOutOfBoundsException e) { assigned = false; binding = null; growSpecials(); }  if (assigned) return binding;  }  } public final SpecialBinding bindSpecial(Symbol name, LispObject value) { assignSpecialIndex(name); int idx; SpecialBinding binding = ensureSpecialBinding(idx = name.specialIndex); this.savedSpecials = new SpecialBindingsMark(idx, binding, this.savedSpecials); this.specials[idx] = new SpecialBinding(idx, value); return new SpecialBinding(idx, value); } public final SpecialBinding bindSpecialToCurrentValue(Symbol name) { assignSpecialIndex(name); int idx; SpecialBinding binding = ensureSpecialBinding(idx = name.specialIndex); this.savedSpecials = new SpecialBindingsMark(idx, binding, this.savedSpecials); this.specials[idx] = new SpecialBinding(idx, (binding == null) ? name.getSymbolValue() : binding.value); return new SpecialBinding(idx, (binding == null) ? name.getSymbolValue() : binding.value); } public final LispObject lookupSpecial(Symbol name) { SpecialBinding binding = ensureSpecialBinding(name.specialIndex); return (binding == null) ? null : binding.value; } public final SpecialBinding getSpecialBinding(Symbol name) { return ensureSpecialBinding(name.specialIndex); } public final LispObject setSpecialVariable(Symbol name, LispObject value) { SpecialBinding binding = ensureSpecialBinding(name.specialIndex); if (binding != null) return binding.value = value;  name.setSymbolValue(value); return value; } public final LispObject pushSpecial(Symbol name, LispObject thing) { SpecialBinding binding = ensureSpecialBinding(name.specialIndex); if (binding != null) return binding.value = new Cons(thing, binding.value);  LispObject value = name.getSymbolValue(); if (value != null) { LispObject newValue = new Cons(thing, value); name.setSymbolValue(newValue); return newValue; }  return Lisp.error(new UnboundVariable(name)); } public final LispObject safeSymbolValue(Symbol name) { SpecialBinding binding = ensureSpecialBinding(name.specialIndex); if (binding != null) return binding.value;  LispObject value = name.getSymbolValue(); return (value != null) ? value : Lisp.NIL; } public final void rebindSpecial(Symbol name, LispObject value) { SpecialBinding binding = getSpecialBinding(name); binding.value = value; } public void pushCatchTag(LispObject tag) { this.catchTags = new Cons(tag, this.catchTags); } public void popCatchTag() { if (this.catchTags != Lisp.NIL) { this.catchTags = this.catchTags.cdr(); } else { Debug.assertTrue(false); }  } public void throwToTag(LispObject tag, LispObject result) { LispObject rest = this.catchTags; while (rest != Lisp.NIL) { if (rest.car() == tag) throw new Throw(tag, result, this);  rest = rest.cdr(); }  Lisp.error(new ControlError("Attempt to throw to the nonexistent tag " + tag.princToString() + ".")); } private static class StackMarker {
/*      */     final int numArgs; StackMarker(int numArgs) { this.numArgs = numArgs; } int getNumArgs() { return this.numArgs; }
/*      */   } private static final StackMarker STACK_MARKER_0 = new StackMarker(0); private static final StackMarker STACK_MARKER_1 = new StackMarker(1); private static final StackMarker STACK_MARKER_2 = new StackMarker(2); private static final StackMarker STACK_MARKER_3 = new StackMarker(3); private static final StackMarker STACK_MARKER_4 = new StackMarker(4); private static final StackMarker STACK_MARKER_5 = new StackMarker(5); private static final StackMarker STACK_MARKER_6 = new StackMarker(6); private static final StackMarker STACK_MARKER_7 = new StackMarker(7); private static final StackMarker STACK_MARKER_8 = new StackMarker(8); private final int STACK_FRAME_EXTRA = 2; private StackSegment topStackSegment; private Object[] stack; private int stackPtr; private StackSegment spareStackSegment; private static final int INITIAL_SEGMENT_SIZE = 1024; private static final int SEGMENT_SIZE = 524284; private static class StackSegment implements Inspectable {
/*  739 */     final Object[] stack; StackSegment(int size, StackSegment next) { this.stack = new Object[size];
/*  740 */       this.next = next; }
/*      */      final StackSegment next; int stackPtr;
/*      */     public LispObject getParts() {
/*  743 */       Cons result = new Cons(Lisp.NIL);
/*  744 */       return result
/*  745 */         .push(new Symbol("INITIAL-SEGMENT-SIZE"))
/*  746 */         .push(LispInteger.getInstance(1024))
/*  747 */         .push(new Symbol("SEGMENT-SIZE"))
/*  748 */         .push(LispInteger.getInstance(524284)).nreverse();
/*      */     }
/*      */   }
/*      */   
/*      */   private void ensureStackCapacity(int itemsToPush) {
/*  753 */     if (this.stackPtr + itemsToPush - 1 >= this.stack.length) {
/*  754 */       grow(itemsToPush);
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private void grow(int numEntries) {
/*  761 */     this.topStackSegment.stackPtr = this.stackPtr;
/*  762 */     if (this.spareStackSegment != null) {
/*      */       
/*  764 */       if (this.stackPtr > 0 && this.spareStackSegment.stack.length >= numEntries) {
/*  765 */         this.topStackSegment = this.spareStackSegment;
/*  766 */         this.stack = this.topStackSegment.stack;
/*  767 */         this.spareStackSegment = null;
/*  768 */         this.stackPtr = 0;
/*      */         return;
/*      */       } 
/*  771 */       this.spareStackSegment = null;
/*      */     } 
/*  773 */     int newSize = this.stackPtr + numEntries;
/*  774 */     if (this.topStackSegment.stack.length < 524284 || this.stackPtr == 0) {
/*      */       
/*  776 */       int newLength = Math.max(newSize, Math.min(524284, this.stack.length * 2));
/*  777 */       StackSegment newSegment = new StackSegment(newLength, this.topStackSegment.next);
/*  778 */       System.arraycopy(this.stack, 0, newSegment.stack, 0, this.stackPtr);
/*  779 */       this.topStackSegment = newSegment;
/*  780 */       this.stack = this.topStackSegment.stack;
/*      */       
/*      */       return;
/*      */     } 
/*  784 */     this.topStackSegment = new StackSegment(Math.max(524284, numEntries), this.topStackSegment);
/*  785 */     this.stack = this.topStackSegment.stack;
/*  786 */     this.stackPtr = 0;
/*      */   }
/*      */   
/*      */   private StackFrame getStackTop() {
/*  790 */     this.topStackSegment.stackPtr = this.stackPtr;
/*  791 */     if (this.stackPtr == 0) {
/*  792 */       assert this.topStackSegment.next == null;
/*  793 */       return null;
/*      */     } 
/*  795 */     StackFrame prev = null;
/*  796 */     for (StackSegment segment = this.topStackSegment; segment != null; segment = segment.next) {
/*  797 */       Object[] stk = segment.stack;
/*  798 */       int framePos = segment.stackPtr;
/*  799 */       while (framePos > 0) {
/*  800 */         Object stackObj = stk[framePos - 1];
/*  801 */         if (stackObj instanceof StackFrame) {
/*  802 */           if (prev != null) {
/*  803 */             prev.setNext((StackFrame)stackObj);
/*      */           }
/*  805 */           return (StackFrame)this.stack[this.stackPtr - 1];
/*      */         } 
/*  807 */         StackMarker marker = (StackMarker)stackObj;
/*  808 */         int numArgs = marker.getNumArgs();
/*  809 */         LispStackFrame frame = new LispStackFrame(stk, framePos - numArgs - 2, numArgs);
/*  810 */         frame.thread = this;
/*  811 */         stk[framePos - 1] = frame;
/*  812 */         if (prev != null) {
/*  813 */           prev.setNext(frame);
/*      */         }
/*  815 */         prev = frame;
/*  816 */         framePos -= numArgs + 2;
/*      */       } 
/*      */     } 
/*  819 */     return (StackFrame)this.stack[this.stackPtr - 1];
/*      */   }
/*      */   
/*      */   public final void pushStackFrame(JavaStackFrame frame) {
/*  823 */     frame.setNext(getStackTop());
/*  824 */     ensureStackCapacity(1);
/*  825 */     this.stack[this.stackPtr] = frame;
/*  826 */     this.stackPtr++;
/*      */   }
/*      */ 
/*      */   
/*      */   private void popStackFrame(int numArgs) {
/*  831 */     Object stackObj = this.stack[this.stackPtr - 1];
/*  832 */     if (stackObj instanceof StackMarker) {
/*  833 */       assert numArgs == ((StackMarker)stackObj).getNumArgs();
/*      */     } else {
/*  835 */       while (stackObj instanceof JavaStackFrame) {
/*  836 */         this.stack[--this.stackPtr] = null;
/*  837 */         stackObj = this.stack[this.stackPtr - 1];
/*      */       } 
/*  839 */       if (stackObj instanceof StackMarker) {
/*  840 */         assert numArgs == ((StackMarker)stackObj).getNumArgs();
/*      */       } else {
/*  842 */         assert numArgs == ((LispStackFrame)stackObj).getNumArgs();
/*      */       } 
/*      */     } 
/*  845 */     this.stackPtr -= numArgs + 2;
/*  846 */     for (int i = 0; i < numArgs + 2; i++) {
/*  847 */       this.stack[this.stackPtr + i] = null;
/*      */     }
/*  849 */     if (this.stackPtr == 0) {
/*  850 */       popStackSegment();
/*      */     }
/*      */   }
/*      */   
/*      */   private void popStackSegment() {
/*  855 */     this.topStackSegment.stackPtr = 0;
/*  856 */     if (this.topStackSegment.next != null) {
/*  857 */       this.spareStackSegment = this.topStackSegment;
/*  858 */       this.topStackSegment = this.topStackSegment.next;
/*  859 */       this.stack = this.topStackSegment.stack;
/*      */     } 
/*  861 */     this.stackPtr = this.topStackSegment.stackPtr;
/*      */   }
/*      */   
/*      */   public final Environment setEnv(Environment env) {
/*  865 */     StackFrame stackTop = getStackTop();
/*  866 */     return (stackTop != null) ? stackTop.setEnv(env) : null;
/*      */   }
/*      */ 
/*      */   
/*      */   public void resetStack() {
/*  871 */     this.topStackSegment = new StackSegment(1024, null);
/*  872 */     this.stack = this.topStackSegment.stack;
/*  873 */     this.spareStackSegment = null;
/*  874 */     this.stackPtr = 0;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function) {
/*  880 */     ensureStackCapacity(2);
/*  881 */     this.stack[this.stackPtr] = function;
/*  882 */     this.stack[this.stackPtr + 1] = STACK_MARKER_0;
/*  883 */     this.stackPtr += 2;
/*      */     try {
/*  885 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/*  886 */       return function.execute();
/*      */     } finally {
/*      */       
/*  889 */       this.envStack.pop();
/*  890 */       popStackFrame(0);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject arg) {
/*  897 */     ensureStackCapacity(3);
/*  898 */     this.stack[this.stackPtr] = function;
/*  899 */     this.stack[this.stackPtr + 1] = arg;
/*  900 */     this.stack[this.stackPtr + 2] = STACK_MARKER_1;
/*  901 */     this.stackPtr += 3;
/*      */     try {
/*  903 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/*  904 */       return function.execute(arg);
/*      */     } finally {
/*      */       
/*  907 */       this.envStack.pop();
/*  908 */       popStackFrame(1);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second) {
/*  916 */     ensureStackCapacity(4);
/*  917 */     this.stack[this.stackPtr] = function;
/*  918 */     this.stack[this.stackPtr + 1] = first;
/*  919 */     this.stack[this.stackPtr + 2] = second;
/*  920 */     this.stack[this.stackPtr + 3] = STACK_MARKER_2;
/*  921 */     this.stackPtr += 4;
/*      */     try {
/*  923 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/*  924 */       return function.execute(first, second);
/*      */     } finally {
/*      */       
/*  927 */       this.envStack.pop();
/*  928 */       popStackFrame(2);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second, LispObject third) {
/*  936 */     ensureStackCapacity(5);
/*  937 */     this.stack[this.stackPtr] = function;
/*  938 */     this.stack[this.stackPtr + 1] = first;
/*  939 */     this.stack[this.stackPtr + 2] = second;
/*  940 */     this.stack[this.stackPtr + 3] = third;
/*  941 */     this.stack[this.stackPtr + 4] = STACK_MARKER_3;
/*  942 */     this.stackPtr += 5;
/*      */     try {
/*  944 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/*  945 */       return function.execute(first, second, third);
/*      */     } finally {
/*      */       
/*  948 */       this.envStack.pop();
/*  949 */       popStackFrame(3);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second, LispObject third, LispObject fourth) {
/*  958 */     ensureStackCapacity(6);
/*  959 */     this.stack[this.stackPtr] = function;
/*  960 */     this.stack[this.stackPtr + 1] = first;
/*  961 */     this.stack[this.stackPtr + 2] = second;
/*  962 */     this.stack[this.stackPtr + 3] = third;
/*  963 */     this.stack[this.stackPtr + 4] = fourth;
/*  964 */     this.stack[this.stackPtr + 5] = STACK_MARKER_4;
/*  965 */     this.stackPtr += 6;
/*      */     try {
/*  967 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/*  968 */       return function.execute(first, second, third, fourth);
/*      */     } finally {
/*      */       
/*  971 */       this.envStack.pop();
/*  972 */       popStackFrame(4);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/*  981 */     ensureStackCapacity(7);
/*  982 */     this.stack[this.stackPtr] = function;
/*  983 */     this.stack[this.stackPtr + 1] = first;
/*  984 */     this.stack[this.stackPtr + 2] = second;
/*  985 */     this.stack[this.stackPtr + 3] = third;
/*  986 */     this.stack[this.stackPtr + 4] = fourth;
/*  987 */     this.stack[this.stackPtr + 5] = fifth;
/*  988 */     this.stack[this.stackPtr + 6] = STACK_MARKER_5;
/*  989 */     this.stackPtr += 7;
/*      */     try {
/*  991 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/*  992 */       return function.execute(first, second, third, fourth, fifth);
/*      */     } finally {
/*      */       
/*  995 */       this.envStack.pop();
/*  996 */       popStackFrame(5);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 1006 */     ensureStackCapacity(8);
/* 1007 */     this.stack[this.stackPtr] = function;
/* 1008 */     this.stack[this.stackPtr + 1] = first;
/* 1009 */     this.stack[this.stackPtr + 2] = second;
/* 1010 */     this.stack[this.stackPtr + 3] = third;
/* 1011 */     this.stack[this.stackPtr + 4] = fourth;
/* 1012 */     this.stack[this.stackPtr + 5] = fifth;
/* 1013 */     this.stack[this.stackPtr + 6] = sixth;
/* 1014 */     this.stack[this.stackPtr + 7] = STACK_MARKER_6;
/* 1015 */     this.stackPtr += 8;
/*      */     try {
/* 1017 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/* 1018 */       return function.execute(first, second, third, fourth, fifth, sixth);
/*      */     } finally {
/*      */       
/* 1021 */       this.envStack.pop();
/* 1022 */       popStackFrame(6);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 1032 */     ensureStackCapacity(9);
/* 1033 */     this.stack[this.stackPtr] = function;
/* 1034 */     this.stack[this.stackPtr + 1] = first;
/* 1035 */     this.stack[this.stackPtr + 2] = second;
/* 1036 */     this.stack[this.stackPtr + 3] = third;
/* 1037 */     this.stack[this.stackPtr + 4] = fourth;
/* 1038 */     this.stack[this.stackPtr + 5] = fifth;
/* 1039 */     this.stack[this.stackPtr + 6] = sixth;
/* 1040 */     this.stack[this.stackPtr + 7] = seventh;
/* 1041 */     this.stack[this.stackPtr + 8] = STACK_MARKER_7;
/* 1042 */     this.stackPtr += 9;
/*      */     try {
/* 1044 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/* 1045 */       return function.execute(first, second, third, fourth, fifth, sixth, seventh);
/*      */     }
/*      */     finally {
/*      */       
/* 1049 */       this.envStack.pop();
/* 1050 */       popStackFrame(7);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 1060 */     ensureStackCapacity(10);
/* 1061 */     this.stack[this.stackPtr] = function;
/* 1062 */     this.stack[this.stackPtr + 1] = first;
/* 1063 */     this.stack[this.stackPtr + 2] = second;
/* 1064 */     this.stack[this.stackPtr + 3] = third;
/* 1065 */     this.stack[this.stackPtr + 4] = fourth;
/* 1066 */     this.stack[this.stackPtr + 5] = fifth;
/* 1067 */     this.stack[this.stackPtr + 6] = sixth;
/* 1068 */     this.stack[this.stackPtr + 7] = seventh;
/* 1069 */     this.stack[this.stackPtr + 8] = eighth;
/* 1070 */     this.stack[this.stackPtr + 9] = STACK_MARKER_8;
/* 1071 */     this.stackPtr += 10;
/*      */     try {
/* 1073 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/* 1074 */       return function.execute(first, second, third, fourth, fifth, sixth, seventh, eighth);
/*      */     }
/*      */     finally {
/*      */       
/* 1078 */       this.envStack.pop();
/* 1079 */       popStackFrame(8);
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject function, LispObject[] args) {
/* 1085 */     ensureStackCapacity(args.length + 2);
/* 1086 */     this.stack[this.stackPtr] = function;
/* 1087 */     System.arraycopy(args, 0, this.stack, this.stackPtr + 1, args.length);
/* 1088 */     this.stack[this.stackPtr + args.length + 1] = new StackMarker(args.length);
/* 1089 */     this.stackPtr += args.length + 2;
/*      */     try {
/* 1091 */       this.envStack.push(new Environment(null, Lisp.NIL, function));
/* 1092 */       return function.execute(args);
/*      */     } finally {
/*      */       
/* 1095 */       this.envStack.pop();
/* 1096 */       popStackFrame(args.length);
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public void printBacktrace() {
/* 1102 */     printBacktrace(0);
/*      */   }
/*      */ 
/*      */   
/*      */   public void printBacktrace(int limit) {
/* 1107 */     StackFrame stackTop = getStackTop();
/* 1108 */     if (stackTop != null) {
/* 1109 */       int count = 0;
/*      */       
/* 1111 */       Stream out = Lisp.checkCharacterOutputStream(Symbol.TRACE_OUTPUT.symbolValue());
/* 1112 */       out._writeLine("Evaluation stack:");
/* 1113 */       out._finishOutput();
/*      */       
/* 1115 */       StackFrame s = stackTop;
/* 1116 */       while (s != null) {
/* 1117 */         out._writeString("  ");
/* 1118 */         out._writeString(String.valueOf(count));
/* 1119 */         out._writeString(": ");
/*      */         
/* 1121 */         pprint(s.toLispList(), out.getCharPos(), out);
/* 1122 */         out.terpri();
/* 1123 */         out._finishOutput();
/* 1124 */         if (limit > 0 && ++count == limit)
/*      */           break; 
/* 1126 */         s = s.next;
/*      */       } 
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject backtrace(int limit) {
/* 1133 */     StackFrame stackTop = getStackTop();
/* 1134 */     LispObject result = Lisp.NIL;
/* 1135 */     if (stackTop != null) {
/* 1136 */       int count = 0;
/* 1137 */       StackFrame s = stackTop;
/* 1138 */       while (s != null) {
/* 1139 */         result = result.push(s);
/* 1140 */         if (limit > 0 && ++count == limit)
/*      */           break; 
/* 1142 */         s = s.getNext();
/*      */       } 
/*      */     } 
/* 1145 */     return result.nreverse();
/*      */   }
/*      */ 
/*      */   
/*      */   public void incrementCallCounts() {
/* 1150 */     this.topStackSegment.stackPtr = this.stackPtr;
/* 1151 */     int depth = 0;
/* 1152 */     for (StackSegment segment = this.topStackSegment; segment != null; segment = segment.next) {
/* 1153 */       Object[] stk = segment.stack;
/* 1154 */       int framePos = segment.stackPtr;
/* 1155 */       while (framePos > 0) {
/* 1156 */         int numArgs; depth++;
/* 1157 */         Object stackObj = stk[framePos - 1];
/*      */         
/* 1159 */         if (stackObj instanceof StackMarker) {
/* 1160 */           numArgs = ((StackMarker)stackObj).getNumArgs();
/* 1161 */         } else if (stackObj instanceof LispStackFrame) {
/* 1162 */           numArgs = ((LispStackFrame)stackObj).getNumArgs();
/*      */         } else {
/* 1164 */           assert stackObj instanceof JavaStackFrame;
/* 1165 */           framePos--;
/*      */           
/*      */           continue;
/*      */         } 
/* 1169 */         framePos -= numArgs + 2;
/* 1170 */         LispObject operator = (LispObject)this.stack[framePos];
/* 1171 */         if (operator != null) {
/* 1172 */           if (depth <= 8) {
/* 1173 */             operator.incrementHotCount();
/*      */           }
/* 1175 */           operator.incrementCallCount();
/*      */         } 
/*      */       } 
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private static void pprint(LispObject obj, int indentBy, Stream stream) {
/* 1184 */     if (stream.getCharPos() == 0) {
/* 1185 */       StringBuffer sb = new StringBuffer();
/* 1186 */       for (int i = 0; i < indentBy; i++)
/* 1187 */         sb.append(' '); 
/* 1188 */       stream._writeString(sb.toString());
/*      */     } 
/* 1190 */     String raw = obj.printObject();
/* 1191 */     if (stream.getCharPos() + raw.length() < 80) {
/*      */       
/* 1193 */       stream._writeString(raw);
/*      */       
/*      */       return;
/*      */     } 
/* 1197 */     if (obj instanceof Cons) {
/* 1198 */       boolean newlineBefore = false;
/* 1199 */       LispObject[] array = obj.copyToArray();
/* 1200 */       if (array.length > 0) {
/* 1201 */         LispObject first = array[0];
/* 1202 */         if (first == Symbol.LET) {
/* 1203 */           newlineBefore = true;
/*      */         }
/*      */       } 
/* 1206 */       int charPos = stream.getCharPos();
/* 1207 */       if (newlineBefore && charPos != indentBy) {
/* 1208 */         stream.terpri();
/* 1209 */         charPos = stream.getCharPos();
/*      */       } 
/* 1211 */       if (charPos < indentBy) {
/* 1212 */         StringBuffer sb = new StringBuffer();
/* 1213 */         for (int j = charPos; j < indentBy; j++)
/* 1214 */           sb.append(' '); 
/* 1215 */         stream._writeString(sb.toString());
/*      */       } 
/* 1217 */       stream.print('(');
/* 1218 */       for (int i = 0; i < array.length; i++) {
/* 1219 */         pprint(array[i], indentBy + 2, stream);
/* 1220 */         if (i < array.length - 1)
/* 1221 */           stream.print(' '); 
/*      */       } 
/* 1223 */       stream.print(')');
/*      */     } else {
/* 1225 */       stream.terpri();
/* 1226 */       StringBuffer sb = new StringBuffer();
/* 1227 */       for (int i = 0; i < indentBy; i++)
/* 1228 */         sb.append(' '); 
/* 1229 */       stream._writeString(sb.toString());
/* 1230 */       stream._writeString(raw);
/*      */       return;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public String printObject() {
/* 1238 */     StringBuffer sb = new StringBuffer("THREAD");
/* 1239 */     if (this.name != Lisp.NIL) {
/* 1240 */       sb.append(" \"");
/* 1241 */       sb.append(this.name.getStringValue());
/* 1242 */       sb.append("\"");
/*      */     } 
/* 1244 */     return unreadableString(sb.toString());
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "make-thread", args = "function &key name", doc = "Create a thread of execution running FUNCTION possibly named NAME")
/* 1250 */   private static final Primitive MAKE_THREAD = new Primitive("make-thread", Lisp.PACKAGE_THREADS, true, "function &key name")
/*      */     {
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject[] args)
/*      */       {
/* 1256 */         int length = args.length;
/* 1257 */         if (length == 0)
/* 1258 */           Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 1259 */         LispObject name = Lisp.NIL;
/* 1260 */         if (length > 1) {
/* 1261 */           if ((length - 1) % 2 != 0)
/* 1262 */             Lisp.program_error("Odd number of keyword arguments."); 
/* 1263 */           if (length > 3)
/* 1264 */             Lisp.error(new WrongNumberOfArgumentsException(this, -1, 2)); 
/* 1265 */           if (args[1] == Keyword.NAME) {
/* 1266 */             name = args[2].STRING();
/*      */           } else {
/* 1268 */             Lisp.program_error("Unrecognized keyword argument " + args[1]
/* 1269 */                 .princToString() + ".");
/*      */           } 
/* 1271 */         }  return new LispThread(Lisp.checkFunction(args[0]), name);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "threadp", args = "object", doc = "Boolean predicate returning non-nil if OBJECT is a lisp thread")
/* 1278 */   private static final Primitive THREADP = new Primitive("threadp", Lisp.PACKAGE_THREADS, true)
/*      */     {
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 1284 */         return (arg instanceof LispThread) ? Lisp.T : Lisp.NIL;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "thread-alive-p", args = "thread", doc = "Returns T if THREAD is alive.")
/* 1291 */   private static final Primitive THREAD_ALIVE_P = new Primitive("thread-alive-p", Lisp.PACKAGE_THREADS, true, "thread", "Boolean predicate whether THREAD is alive.")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/*      */         LispThread lispThread;
/*      */ 
/*      */ 
/*      */         
/* 1299 */         if (arg instanceof LispThread) {
/* 1300 */           lispThread = (LispThread)arg;
/*      */         } else {
/*      */           
/* 1303 */           return Lisp.type_error(arg, Symbol.THREAD);
/*      */         } 
/* 1305 */         return lispThread.javaThread.isAlive() ? Lisp.T : Lisp.NIL;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "thread-name", args = "thread", doc = "Return the name of THREAD, if it has one.")
/* 1312 */   private static final Primitive THREAD_NAME = new Primitive("thread-name", Lisp.PACKAGE_THREADS, true)
/*      */     {
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 1318 */         if (arg instanceof LispThread) {
/* 1319 */           return ((LispThread)arg).name;
/*      */         }
/* 1321 */         return Lisp.type_error(arg, Symbol.THREAD);
/*      */       }
/*      */     };
/*      */   
/* 1325 */   private static final Primitive THREAD_JOIN = new Primitive("thread-join", Lisp.PACKAGE_THREADS, true, "thread", "Waits for THREAD to die before resuming execution\nReturns the result of the joined thread as its primary value.\nReturns T if the joined thread finishes normally or NIL if it was interrupted.")
/*      */     {
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 1337 */         if (arg instanceof LispThread) {
/* 1338 */           LispThread joinedThread = (LispThread)arg;
/* 1339 */           LispThread waitingThread = LispThread.currentThread();
/*      */           try {
/* 1341 */             joinedThread.javaThread.join();
/* 1342 */             return waitingThread
/* 1343 */               .setValues(joinedThread.threadValue, Lisp.T);
/* 1344 */           } catch (InterruptedException e) {
/* 1345 */             waitingThread.processThreadInterrupts();
/* 1346 */             return waitingThread
/* 1347 */               .setValues(joinedThread.threadValue, Lisp.NIL);
/*      */           } 
/*      */         } 
/* 1350 */         return Lisp.type_error(arg, Symbol.THREAD);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 1355 */   static final DoubleFloat THOUSAND = new DoubleFloat(1000.0D);
/*      */ 
/*      */   
/*      */   static final long sleepMillisPart(LispObject seconds) {
/* 1359 */     double d = Lisp.checkDoubleFloat(seconds.multiplyBy(THOUSAND)).getValue();
/* 1360 */     if (d < 0.0D) {
/* 1361 */       Lisp.type_error(seconds, Lisp.list(Symbol.REAL, new LispObject[] { Fixnum.ZERO }));
/*      */     }
/* 1363 */     return (d < 9.223372036854776E18D) ? (long)d : Long.MAX_VALUE;
/*      */   }
/*      */ 
/*      */   
/*      */   static final int sleepNanosPart(LispObject seconds) {
/* 1368 */     double d = Lisp.checkDoubleFloat(seconds.multiplyBy(THOUSAND)).getValue();
/* 1369 */     double n = d * 1000000.0D;
/* 1370 */     d = 1000000.0D * (long)d;
/* 1371 */     n -= d;
/*      */     
/* 1373 */     return (n < 2.147483647E9D) ? (int)n : Integer.MAX_VALUE;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "sleep", args = "seconds", doc = "Causes the invoking thread to sleep for an interveral expressed in SECONDS.\nSECONDS may be specified as a fraction of a second, with intervals\nless than or equal to a nanosecond resulting in a yield of execution\nto other waiting threads rather than an actual sleep.\nA zero value of SECONDS *may* result in the JVM sleeping indefinitely,\ndepending on the implementation.")
/* 1384 */   private static final Primitive SLEEP = new Primitive("sleep", Lisp.PACKAGE_CL, true)
/*      */     {
/*      */       
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 1389 */         long millis = LispThread.sleepMillisPart(arg);
/* 1390 */         int nanos = LispThread.sleepNanosPart(arg);
/* 1391 */         boolean zeroArgP = (arg.ZEROP() != Lisp.NIL);
/*      */         
/*      */         try {
/* 1394 */           if (millis == 0L && nanos == 0) {
/* 1395 */             if (zeroArgP) {
/* 1396 */               Thread.sleep(0L, 0);
/*      */             } else {
/* 1398 */               Thread.sleep(0L, 1);
/*      */             } 
/*      */           } else {
/* 1401 */             Thread.sleep(millis, nanos);
/*      */           } 
/* 1403 */         } catch (InterruptedException e) {
/* 1404 */           LispThread.currentThread().processThreadInterrupts();
/*      */         } 
/* 1406 */         return Lisp.NIL;
/*      */       }
/*      */     };
/*      */ 
/*      */   
/*      */   @DocString(name = "mapcar-threads", args = "function", doc = "Applies FUNCTION to all existing threads.")
/* 1412 */   private static final Primitive MAPCAR_THREADS = new Primitive("mapcar-threads", Lisp.PACKAGE_THREADS, true)
/*      */     {
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 1418 */         Function fun = Lisp.checkFunction(arg);
/* 1419 */         LispThread thread = LispThread.currentThread();
/* 1420 */         LispObject result = Lisp.NIL;
/* 1421 */         Iterator<LispThread> it = LispThread.map.values().iterator();
/* 1422 */         while (it.hasNext()) {
/* 1423 */           LispObject[] args = new LispObject[1];
/* 1424 */           args[0] = it.next();
/* 1425 */           result = new Cons(Lisp.funcall(fun, args, thread), result);
/*      */         } 
/* 1427 */         return result;
/*      */       }
/*      */     };
/*      */   
/*      */   @DocString(name = "destroy-thread", args = "thread", doc = "Mark THREAD as destroyed")
/* 1432 */   private static final Primitive DESTROY_THREAD = new Primitive("destroy-thread", Lisp.PACKAGE_THREADS, true)
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/*      */         LispThread thread;
/*      */ 
/*      */         
/* 1439 */         if (arg instanceof LispThread) {
/* 1440 */           thread = (LispThread)arg;
/*      */         } else {
/*      */           
/* 1443 */           return Lisp.type_error(arg, Symbol.THREAD);
/*      */         } 
/* 1445 */         thread.setDestroyed(true);
/* 1446 */         return Lisp.T;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "interrupt-thread", args = "thread function &rest args", doc = "Interrupts thread and forces it to apply function to args. When the\nfunction returns, the thread's original computation continues. If\nmultiple interrupts are queued for a thread, they are all run, but the\norder is not guaranteed.")
/* 1456 */   private static final Primitive INTERRUPT_THREAD = new Primitive("interrupt-thread", Lisp.PACKAGE_THREADS, true, "thread function &rest args", "Interrupts THREAD and forces it to apply FUNCTION to ARGS.\nWhen the function returns, the thread's original computation continues. If  multiple interrupts are queued for a thread, they are all run, but the order is not guaranteed.")
/*      */     {
/*      */       public LispObject execute(LispObject[] args)
/*      */       {
/*      */         LispThread thread;
/*      */ 
/*      */ 
/*      */         
/* 1464 */         if (args.length < 2) {
/* 1465 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1));
/*      */         }
/* 1467 */         if (args[0] instanceof LispThread) {
/* 1468 */           thread = (LispThread)args[0];
/*      */         } else {
/*      */           
/* 1471 */           return Lisp.type_error(args[0], Symbol.THREAD);
/*      */         } 
/* 1473 */         LispObject fun = args[1];
/* 1474 */         LispObject funArgs = Lisp.NIL;
/* 1475 */         for (int i = args.length; i-- > 2;)
/* 1476 */           funArgs = new Cons(args[i], funArgs); 
/* 1477 */         thread.interrupt(fun, funArgs);
/* 1478 */         Lisp.setInterrupted(thread, true);
/* 1479 */         return Lisp.T;
/*      */       }
/*      */     };
/*      */   
/* 1483 */   public static final Primitive CURRENT_THREAD = new pf_current_thread();
/*      */   
/*      */   @DocString(name = "current-thread", doc = "Returns a reference to invoking thread.")
/*      */   private static final class pf_current_thread
/*      */     extends Primitive {
/*      */     pf_current_thread() {
/* 1489 */       super("current-thread", Lisp.PACKAGE_THREADS, true);
/*      */     }
/*      */     
/*      */     public LispObject execute() {
/* 1493 */       return LispThread.currentThread();
/*      */     }
/*      */   }
/*      */   
/* 1497 */   public static final Primitive BACKTRACE = new pf_backtrace();
/*      */   
/*      */   @DocString(name = "backtrace", doc = "Returns a Java backtrace of the invoking thread.")
/*      */   private static final class pf_backtrace
/*      */     extends Primitive {
/*      */     pf_backtrace() {
/* 1503 */       super("backtrace", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1507 */       if (args.length > 1)
/* 1508 */         return Lisp.error(new WrongNumberOfArgumentsException(this, -1, 1)); 
/* 1509 */       int limit = (args.length > 0) ? Fixnum.getValue(args[0]) : 0;
/* 1510 */       return LispThread.currentThread().backtrace(limit);
/*      */     }
/*      */   }
/*      */   
/* 1514 */   public static final Primitive FRAME_TO_STRING = new pf_frame_to_string();
/*      */   
/*      */   @DocString(name = "frame-to-string", args = "frame", doc = "Convert stack FRAME to a (potentially) readable string.")
/*      */   private static final class pf_frame_to_string
/*      */     extends Primitive
/*      */   {
/*      */     pf_frame_to_string() {
/* 1521 */       super("frame-to-string", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1525 */       if (args.length != 1)
/* 1526 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1)); 
/* 1527 */       return Lisp.checkStackFrame(args[0]).toLispString();
/*      */     }
/*      */   }
/*      */   
/* 1531 */   public static final Primitive FRAME_TO_LIST = new pf_frame_to_list();
/*      */   
/*      */   @DocString(name = "frame-to-list", args = "frame")
/*      */   private static final class pf_frame_to_list extends Primitive {
/*      */     pf_frame_to_list() {
/* 1536 */       super("frame-to-list", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1540 */       if (args.length != 1) {
/* 1541 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1));
/*      */       }
/* 1543 */       return Lisp.checkStackFrame(args[0]).toLispList();
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 1548 */   public static final SpecialOperator SYNCHRONIZED_ON = new so_synchronized_on();
/*      */   
/*      */   @DocString(name = "synchronized-on", args = "form &body body")
/*      */   private static final class so_synchronized_on extends SpecialOperator {
/*      */     so_synchronized_on() {
/* 1553 */       super("synchronized-on", Lisp.PACKAGE_THREADS, true, "form &body body");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 1557 */       if (args == Lisp.NIL) {
/* 1558 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1));
/*      */       }
/* 1560 */       LispThread thread = LispThread.currentThread();
/* 1561 */       synchronized (Lisp.eval(args.car(), env, thread).lockableInstance()) {
/* 1562 */         return Lisp.progn(args.cdr(), env, thread);
/*      */       } 
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 1568 */   public static final Primitive OBJECT_WAIT = new pf_object_wait();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "object-wait", args = "object &optional timeout", doc = "Causes the current thread to block until object-notify or object-notify-all is called on OBJECT.\nOptionally unblock execution after TIMEOUT seconds.  A TIMEOUT of zero\nmeans to wait indefinitely.\nA non-zero TIMEOUT of less than a nanosecond is interpolated as a nanosecond wait.\nSee the documentation of java.lang.Object.wait() for further\ninformation.\n")
/*      */   private static final class pf_object_wait
/*      */     extends Primitive
/*      */   {
/*      */     pf_object_wait() {
/* 1582 */       super("object-wait", Lisp.PACKAGE_THREADS, true);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject object) {
/*      */       try {
/* 1587 */         object.lockableInstance().wait();
/* 1588 */       } catch (InterruptedException e) {
/* 1589 */         LispThread.currentThread().processThreadInterrupts();
/* 1590 */       } catch (IllegalMonitorStateException e) {
/* 1591 */         return Lisp.error(new IllegalMonitorState(e.getMessage()));
/*      */       } 
/* 1593 */       return Lisp.NIL;
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject object, LispObject timeout) {
/* 1598 */       long millis = LispThread.sleepMillisPart(timeout);
/* 1599 */       int nanos = LispThread.sleepNanosPart(timeout);
/* 1600 */       boolean zeroArgP = (timeout.ZEROP() != Lisp.NIL);
/*      */       
/*      */       try {
/* 1603 */         if (millis == 0L && nanos == 0) {
/* 1604 */           if (zeroArgP) {
/* 1605 */             object.lockableInstance().wait(0L, 0);
/*      */           } else {
/* 1607 */             object.lockableInstance().wait(0L, 1);
/*      */           } 
/*      */         } else {
/* 1610 */           object.lockableInstance().wait(millis, nanos);
/*      */         } 
/* 1612 */       } catch (InterruptedException e) {
/* 1613 */         LispThread.currentThread().processThreadInterrupts();
/* 1614 */       } catch (IllegalMonitorStateException e) {
/* 1615 */         return Lisp.error(new IllegalMonitorState(e.getMessage()));
/*      */       } 
/* 1617 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/* 1621 */   public static final Primitive OBJECT_NOTIFY = new pf_object_notify();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "object-notify", args = "object", doc = "Wakes up a single thread that is waiting on OBJECT's monitor.\nIf any threads are waiting on this object, one of them is chosen to be awakened. The choice is arbitrary and occurs at the discretion of the implementation. A thread waits on an object's monitor by calling one of the wait methods.")
/*      */   private static final class pf_object_notify
/*      */     extends Primitive
/*      */   {
/*      */     pf_object_notify() {
/* 1632 */       super("object-notify", Lisp.PACKAGE_THREADS, true, "object");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject object) {
/*      */       try {
/* 1637 */         object.lockableInstance().notify();
/* 1638 */       } catch (IllegalMonitorStateException e) {
/* 1639 */         return Lisp.error(new IllegalMonitorState(e.getMessage()));
/*      */       } 
/* 1641 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/* 1645 */   public static final Primitive OBJECT_NOTIFY_ALL = new pf_object_notify_all();
/*      */ 
/*      */   
/*      */   @DocString(name = "object-notify-all", args = "object", doc = "Wakes up all threads that are waiting on this OBJECT's monitor.\nA thread waits on an object's monitor by calling one of the wait methods.")
/*      */   private static final class pf_object_notify_all
/*      */     extends Primitive
/*      */   {
/*      */     pf_object_notify_all() {
/* 1653 */       super("object-notify-all", Lisp.PACKAGE_THREADS, true);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject object) {
/*      */       try {
/* 1658 */         object.lockableInstance().notifyAll();
/* 1659 */       } catch (IllegalMonitorStateException e) {
/* 1660 */         return Lisp.error(new IllegalMonitorState(e.getMessage()));
/*      */       } 
/* 1662 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispThread.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */