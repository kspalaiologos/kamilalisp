/*     */ package org.armedbear.lisp.scripting;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.Collections;
/*     */ import java.util.List;
/*     */ import javax.script.ScriptEngine;
/*     */ import javax.script.ScriptEngineFactory;
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
/*     */ public class AbclScriptEngineFactory
/*     */   implements ScriptEngineFactory
/*     */ {
/*  32 */   private static AbclScriptEngine THE_ONLY_ONE_ENGINE = null;
/*     */   
/*     */   public String getEngineName() {
/*  35 */     return "ABCL Script";
/*     */   }
/*     */   
/*     */   public String getEngineVersion() {
/*  39 */     return "0.1";
/*     */   }
/*     */   
/*     */   public List<String> getExtensions() {
/*  43 */     List<String> extensions = new ArrayList<>(1);
/*  44 */     extensions.add("lisp");
/*  45 */     return Collections.unmodifiableList(extensions);
/*     */   }
/*     */   
/*     */   public String getLanguageName() {
/*  49 */     return "ANSI Common Lisp";
/*     */   }
/*     */   
/*     */   public String getLanguageVersion() {
/*  53 */     return "ANSI X3.226:1994";
/*     */   }
/*     */   
/*     */   public static String escape(String raw) {
/*  57 */     StringBuilder sb = new StringBuilder();
/*  58 */     int len = raw.length();
/*     */     
/*  60 */     for (int i = 0; i < len; i++) {
/*  61 */       char c = raw.charAt(i);
/*  62 */       if (c != '"') {
/*  63 */         sb.append(c);
/*     */       } else {
/*  65 */         sb.append("\\\"");
/*     */       } 
/*     */     } 
/*  68 */     return sb.toString();
/*     */   }
/*     */   
/*     */   public String getMethodCallSyntax(String obj, String method, String... args) {
/*  72 */     StringBuilder sb = new StringBuilder();
/*  73 */     sb.append("(jcall \"");
/*  74 */     sb.append(method);
/*  75 */     sb.append("\" ");
/*  76 */     sb.append(obj);
/*  77 */     for (String arg : args) {
/*  78 */       sb.append(" ");
/*  79 */       sb.append(arg);
/*     */     } 
/*  81 */     sb.append(")");
/*  82 */     return sb.toString();
/*     */   }
/*     */   
/*     */   public List<String> getMimeTypes() {
/*  86 */     return Collections.unmodifiableList(new ArrayList<>());
/*     */   }
/*     */   
/*     */   public List<String> getNames() {
/*  90 */     List<String> names = new ArrayList<>(1);
/*  91 */     names.add("ABCL");
/*  92 */     names.add("cl");
/*  93 */     names.add("Lisp");
/*  94 */     names.add("Common Lisp");
/*  95 */     return Collections.unmodifiableList(names);
/*     */   }
/*     */   
/*     */   public String getOutputStatement(String str) {
/*  99 */     return "(cl:print \"" + str + "\")";
/*     */   }
/*     */ 
/*     */   
/*     */   public Object getParameter(String key) {
/* 104 */     return null;
/*     */   }
/*     */   
/*     */   public String getProgram(String... statements) {
/* 108 */     StringBuilder sb = new StringBuilder();
/* 109 */     sb.append("(cl:progn");
/* 110 */     for (String stmt : statements) {
/* 111 */       sb.append("\n\t");
/* 112 */       sb.append(stmt);
/*     */     } 
/* 114 */     sb.append(")");
/* 115 */     return sb.toString();
/*     */   }
/*     */   
/*     */   public synchronized ScriptEngine getScriptEngine() {
/* 119 */     if (THE_ONLY_ONE_ENGINE == null) {
/* 120 */       THE_ONLY_ONE_ENGINE = new AbclScriptEngine();
/*     */     }
/* 122 */     return THE_ONLY_ONE_ENGINE;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/scripting/AbclScriptEngineFactory.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */