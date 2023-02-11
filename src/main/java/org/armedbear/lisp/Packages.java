/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.HashMap;
/*     */ import java.util.Iterator;
/*     */ import java.util.List;
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
/*     */ public final class Packages
/*     */ {
/*  45 */   private static final ArrayList<Package> packages = new ArrayList<>();
/*  46 */   private static final HashMap<String, Package> map = new HashMap<>();
/*     */ 
/*     */   
/*     */   public static final synchronized Package createPackage(String name) {
/*  50 */     return createPackage(name, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final synchronized Package createPackage(String name, int size) {
/*  55 */     Package pkg = map.get(name);
/*  56 */     if (pkg == null) {
/*     */       
/*  58 */       pkg = (size != 0) ? new Package(name, size) : new Package(name);
/*  59 */       packages.add(pkg);
/*  60 */       map.put(name, pkg);
/*     */     } else {
/*     */       
/*  63 */       Debug.trace("package " + name + " already exists");
/*  64 */     }  return pkg;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static final synchronized void addPackage(Package pkg) {
/*  70 */     String name = pkg.getName();
/*  71 */     if (map.get(name) != null) {
/*     */       
/*  73 */       Lisp.error(new LispError("A package named " + name + " already exists."));
/*     */       return;
/*     */     } 
/*  76 */     packages.add(pkg);
/*  77 */     map.put(name, pkg);
/*  78 */     List nicknames = pkg.getNicknames();
/*  79 */     if (nicknames != null)
/*     */     {
/*  81 */       for (Iterator<String> it = nicknames.iterator(); it.hasNext(); ) {
/*     */         
/*  83 */         String nickname = it.next();
/*  84 */         addNickname(pkg, nickname);
/*     */       } 
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final synchronized Package findPackage(String name) {
/*  96 */     return Lisp.getCurrentPackage().findPackage(name);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final synchronized Package findPackageGlobally(String name) {
/* 104 */     return map.get(name);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static final synchronized Package makePackage(String name) {
/* 110 */     if (map.get(name) != null) {
/*     */       
/* 112 */       Lisp.error(new LispError("A package named " + name + " already exists."));
/*     */       
/* 114 */       return null;
/*     */     } 
/* 116 */     Package pkg = new Package(name);
/* 117 */     packages.add(pkg);
/* 118 */     map.put(name, pkg);
/* 119 */     return pkg;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static final synchronized void addNickname(Package pkg, String nickname) {
/* 125 */     Object obj = map.get(nickname);
/* 126 */     if (obj != null && obj != pkg) {
/*     */       
/* 128 */       Lisp.error(new PackageError("A package named " + nickname + " already exists.", new SimpleString(nickname)));
/*     */       return;
/*     */     } 
/* 131 */     map.put(nickname, pkg);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static final synchronized boolean deletePackage(Package pkg) {
/* 137 */     String name = pkg.getName();
/* 138 */     if (name != null) {
/*     */       
/* 140 */       map.remove(name);
/* 141 */       List nicknames = pkg.getNicknames();
/* 142 */       if (nicknames != null)
/*     */       {
/* 144 */         for (Iterator<String> it = nicknames.iterator(); it.hasNext(); ) {
/*     */           
/* 146 */           String nickname = it.next();
/* 147 */           map.remove(nickname);
/*     */         } 
/*     */       }
/* 150 */       packages.remove(pkg);
/* 151 */       return true;
/*     */     } 
/* 153 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public static final synchronized LispObject listAllPackages() {
/* 158 */     LispObject result = Lisp.NIL;
/* 159 */     for (Package pkg : packages) {
/* 160 */       result = new Cons(pkg, result);
/*     */     }
/* 162 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public static final synchronized Package[] getAllPackages() {
/* 167 */     Package[] array = new Package[packages.size()];
/* 168 */     packages.toArray(array);
/* 169 */     return array;
/*     */   }
/*     */ 
/*     */   
/*     */   public static final synchronized LispObject getPackagesNicknamingPackage(Package thePackage) {
/* 174 */     LispObject result = Lisp.NIL;
/* 175 */     for (Package pkg : packages) {
/* 176 */       for (Package nicknamedPackage : pkg.getLocallyNicknamedPackages()) {
/* 177 */         if (thePackage.equals(nicknamedPackage)) {
/* 178 */           result = new Cons(pkg, result);
/*     */         }
/*     */       } 
/*     */     } 
/* 182 */     return result;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Packages.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */