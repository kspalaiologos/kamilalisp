/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.HashMap;
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
/*     */ public final class JHandler
/*     */ {
/*  44 */   static final Map<Object, Map<String, Entry>> table = new WeakHashMap<>();
/*     */ 
/*     */ 
/*     */   
/*     */   public static void callLisp(String s, Object o) {
/*  49 */     callLisp(s, o, "");
/*     */   }
/*     */ 
/*     */   
/*     */   public static void callLisp(String s, Object o, String s1) {
/*  54 */     callLisp(s, o, s1, new int[0]);
/*     */   }
/*     */   
/*     */   public static void callLisp(String s, Object o, String s1, int[] ai) {
/*  58 */     callLisp(s, o, new String[] { s1 }, ai);
/*     */   }
/*     */ 
/*     */   
/*     */   public static void callLisp(String s, Object o, String[] as) {
/*  63 */     callLisp(s, o, as, new int[0]);
/*     */   }
/*     */ 
/*     */   
/*     */   public static void callLisp(String s, Object o, String[] as, int[] ai) {
/*  68 */     if (table.containsKey(o)) {
/*  69 */       Map<String, Entry> entryTable = table.get(o);
/*  70 */       if (entryTable.containsKey(s)) {
/*  71 */         Entry entry = entryTable.get(s);
/*  72 */         Function f = entry.getHandler();
/*  73 */         LispObject data = entry.getData();
/*  74 */         Fixnum count = entry.getCount();
/*  75 */         Fixnum[] lispAi = new Fixnum[ai.length];
/*  76 */         for (int i = 0; i < ai.length; i++) {
/*  77 */           lispAi[i] = Fixnum.getInstance(ai[i]);
/*     */         }
/*  79 */         LispObject lispAiVector = new SimpleVector((LispObject[])lispAi);
/*  80 */         SimpleString[] lispAs = new SimpleString[as.length];
/*  81 */         for (int j = 0; j < as.length; j++) {
/*  82 */           lispAs[j] = new SimpleString(as[j]);
/*     */         }
/*  84 */         LispObject lispAsVector = new SimpleVector((LispObject[])lispAs);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */         
/*  91 */         LispObject[] args = { data, new JavaObject(o), lispAiVector, lispAsVector, Lisp.internKeyword(s), count };
/*     */         
/*  93 */         f.execute(args);
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*  99 */   private static final Primitive _JREGISTER_HANDLER = new Primitive("%jregister-handler", Lisp.PACKAGE_JAVA)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 105 */         if (args.length != 5)
/* 106 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 5)); 
/* 107 */         Map<String, JHandler.Entry> entryTable = null;
/* 108 */         Object object = args[0].javaInstance();
/* 109 */         String event = ((Symbol)args[1]).getName();
/* 110 */         if (!JHandler.table.containsKey(object)) {
/* 111 */           entryTable = new HashMap<>();
/* 112 */           JHandler.table.put(object, entryTable);
/*     */         } else {
/* 114 */           entryTable = JHandler.table.get(object);
/*     */         } 
/* 116 */         JHandler.Entry entry = new JHandler.Entry((Function)args[2], args[3], event, entryTable);
/* 117 */         if (args[4] != Lisp.NIL)
/* 118 */           entry.addCount(((Fixnum)args[4]).value); 
/* 119 */         entryTable.put(event, entry);
/* 120 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */   
/*     */   private static class Entry
/*     */   {
/*     */     Function handler;
/*     */     LispObject data;
/* 128 */     int count = -1;
/*     */     
/*     */     Map<String, Entry> entryTable;
/*     */     
/*     */     String event;
/*     */     
/*     */     public Entry(Function handler, LispObject data, String event, Map<String, Entry> entryTable) {
/* 135 */       this.entryTable = entryTable;
/* 136 */       this.event = event;
/* 137 */       this.handler = handler;
/* 138 */       this.data = data;
/*     */     }
/*     */ 
/*     */     
/*     */     public Function getHandler() {
/* 143 */       return this.handler;
/*     */     }
/*     */ 
/*     */     
/*     */     public void addData(LispObject data) {
/* 148 */       this.data = data;
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject getData() {
/* 153 */       return this.data;
/*     */     }
/*     */ 
/*     */     
/*     */     public void addCount(int count) {
/* 158 */       this.count = count;
/*     */     }
/*     */ 
/*     */     
/*     */     public Fixnum getCount() {
/* 163 */       if (this.count == 0)
/* 164 */         this.entryTable.remove(this.event); 
/* 165 */       return Fixnum.getInstance(this.count--);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JHandler.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */