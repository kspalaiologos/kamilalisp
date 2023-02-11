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
/*     */ public final class dolist
/*     */   extends SpecialOperator
/*     */ {
/*     */   private dolist() {
/*  43 */     super(Symbol.DOLIST);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject args, Environment env) {
/*  50 */     LispObject bodyForm = args.cdr();
/*  51 */     args = args.car();
/*  52 */     Symbol var = Lisp.checkSymbol(args.car());
/*  53 */     LispObject listForm = args.cadr();
/*  54 */     LispThread thread = LispThread.currentThread();
/*  55 */     LispObject resultForm = args.cdr().cdr().car();
/*  56 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */     
/*  58 */     LispObject bodyAndDecls = Lisp.parseBody(bodyForm, false);
/*  59 */     LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/*  60 */     bodyForm = bodyAndDecls.car();
/*     */     
/*  62 */     LispObject blockId = new LispObject();
/*  63 */     Environment ext = new Environment(env);
/*  64 */     thread.envStack.push(ext);
/*     */     try {
/*     */       Object binding;
/*  67 */       ext.addBlock(Lisp.NIL, blockId);
/*     */       
/*  69 */       LispObject list = Lisp.checkList(Lisp.eval(listForm, ext, thread));
/*     */       
/*  71 */       LispObject remaining = bodyForm;
/*  72 */       LispObject localTags = Lisp.preprocessTagBody(bodyForm, ext);
/*     */ 
/*     */       
/*  75 */       if (specials != Lisp.NIL && Lisp.memq(var, specials)) {
/*     */         
/*  77 */         thread.bindSpecial(var, null);
/*  78 */         binding = thread.getSpecialBinding(var);
/*  79 */         ext.declareSpecial(var);
/*     */       }
/*  81 */       else if (var.isSpecialVariable()) {
/*     */         
/*  83 */         thread.bindSpecial(var, null);
/*  84 */         binding = thread.getSpecialBinding(var);
/*     */       }
/*     */       else {
/*     */         
/*  88 */         ext.bind(var, null);
/*  89 */         binding = ext.getBinding(var);
/*     */       } 
/*  91 */       while (specials != Lisp.NIL) {
/*     */         
/*  93 */         ext.declareSpecial(Lisp.checkSymbol(specials.car()));
/*  94 */         specials = specials.cdr();
/*     */       } 
/*  96 */       while (list != Lisp.NIL) {
/*     */         
/*  98 */         if (binding instanceof SpecialBinding) {
/*  99 */           ((SpecialBinding)binding).value = list.car();
/*     */         } else {
/* 101 */           ((Binding)binding).value = list.car();
/*     */         } 
/* 103 */         Lisp.processTagBody(bodyForm, localTags, ext);
/*     */         
/* 105 */         list = list.cdr();
/* 106 */         if (Lisp.interrupted)
/* 107 */           Lisp.handleInterrupt(); 
/*     */       } 
/* 109 */       if (binding instanceof SpecialBinding) {
/* 110 */         ((SpecialBinding)binding).value = Lisp.NIL;
/*     */       } else {
/* 112 */         ((Binding)binding).value = Lisp.NIL;
/* 113 */       }  LispObject result = Lisp.eval(resultForm, ext, thread);
/* 114 */       return result;
/*     */     }
/* 116 */     catch (Return ret) {
/*     */       
/* 118 */       if (ret.getBlock() == blockId)
/*     */       {
/* 120 */         return ret.getResult();
/*     */       }
/* 122 */       throw ret;
/*     */     }
/*     */     finally {
/*     */       
/* 126 */       while (thread.envStack.pop() != ext);
/* 127 */       thread.resetSpecialBindings(mark);
/* 128 */       ext.inactive = true;
/*     */     } 
/*     */   }
/*     */   
/* 132 */   private static final dolist DOLIST = new dolist();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/dolist.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */