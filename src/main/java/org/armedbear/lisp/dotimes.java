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
/*     */ public final class dotimes
/*     */   extends SpecialOperator
/*     */ {
/*     */   private dotimes() {
/*  42 */     super(Symbol.DOTIMES);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject args, Environment env) {
/*  49 */     LispObject bodyForm = args.cdr();
/*  50 */     args = args.car();
/*  51 */     Symbol var = Lisp.checkSymbol(args.car());
/*  52 */     LispObject countForm = args.cadr();
/*  53 */     LispThread thread = LispThread.currentThread();
/*  54 */     LispObject resultForm = args.cdr().cdr().car();
/*  55 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */     
/*  57 */     LispObject bodyAndDecls = Lisp.parseBody(bodyForm, false);
/*  58 */     LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/*  59 */     bodyForm = bodyAndDecls.car();
/*     */     
/*  61 */     LispObject blockId = new LispObject();
/*  62 */     Environment ext = new Environment(env);
/*  63 */     thread.envStack.push(ext); try {
/*     */       LispObject result;
/*     */       Object binding;
/*  66 */       ext.addBlock(Lisp.NIL, blockId);
/*     */       
/*  68 */       LispObject limit = Lisp.eval(countForm, ext, thread);
/*  69 */       LispObject localTags = Lisp.preprocessTagBody(bodyForm, ext);
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*  74 */       if (specials != Lisp.NIL && Lisp.memq(var, specials)) {
/*     */         
/*  76 */         thread.bindSpecial(var, null);
/*  77 */         binding = thread.getSpecialBinding(var);
/*  78 */         ext.declareSpecial(var);
/*     */       }
/*  80 */       else if (var.isSpecialVariable()) {
/*     */         
/*  82 */         thread.bindSpecial(var, null);
/*  83 */         binding = thread.getSpecialBinding(var);
/*     */       }
/*     */       else {
/*     */         
/*  87 */         ext.bind(var, null);
/*  88 */         binding = ext.getBinding(var);
/*     */       } 
/*  90 */       while (specials != Lisp.NIL) {
/*     */         
/*  92 */         ext.declareSpecial(Lisp.checkSymbol(specials.car()));
/*  93 */         specials = specials.cdr();
/*     */       } 
/*  95 */       if (limit instanceof Fixnum) {
/*     */         
/*  97 */         int count = ((Fixnum)limit).value;
/*     */         int i;
/*  99 */         for (i = 0; i < count; i++) {
/*     */           
/* 101 */           if (binding instanceof SpecialBinding) {
/* 102 */             ((SpecialBinding)binding).value = Fixnum.getInstance(i);
/*     */           } else {
/* 104 */             ((Binding)binding).value = Fixnum.getInstance(i);
/*     */           } 
/* 106 */           Lisp.processTagBody(bodyForm, localTags, ext);
/*     */           
/* 108 */           if (Lisp.interrupted)
/* 109 */             Lisp.handleInterrupt(); 
/*     */         } 
/* 111 */         if (binding instanceof SpecialBinding) {
/* 112 */           ((SpecialBinding)binding).value = Fixnum.getInstance(i);
/*     */         } else {
/* 114 */           ((Binding)binding).value = Fixnum.getInstance(i);
/* 115 */         }  result = Lisp.eval(resultForm, ext, thread);
/*     */       }
/* 117 */       else if (limit instanceof Bignum) {
/*     */         
/* 119 */         LispObject i = Fixnum.ZERO;
/* 120 */         while (i.isLessThan(limit)) {
/*     */           
/* 122 */           if (binding instanceof SpecialBinding) {
/* 123 */             ((SpecialBinding)binding).value = i;
/*     */           } else {
/* 125 */             ((Binding)binding).value = i;
/*     */           } 
/* 127 */           Lisp.processTagBody(bodyForm, localTags, ext);
/*     */           
/* 129 */           i = i.incr();
/* 130 */           if (Lisp.interrupted)
/* 131 */             Lisp.handleInterrupt(); 
/*     */         } 
/* 133 */         if (binding instanceof SpecialBinding) {
/* 134 */           ((SpecialBinding)binding).value = i;
/*     */         } else {
/* 136 */           ((Binding)binding).value = i;
/* 137 */         }  result = Lisp.eval(resultForm, ext, thread);
/*     */       } else {
/*     */         
/* 140 */         return Lisp.type_error(limit, Symbol.INTEGER);
/* 141 */       }  return result;
/*     */     }
/* 143 */     catch (Return ret) {
/*     */       
/* 145 */       if (ret.getBlock() == blockId)
/*     */       {
/* 147 */         return ret.getResult();
/*     */       }
/* 149 */       throw ret;
/*     */     }
/*     */     finally {
/*     */       
/* 153 */       thread.resetSpecialBindings(mark);
/* 154 */       ext.inactive = true;
/* 155 */       while (thread.envStack.pop() != ext);
/*     */     } 
/*     */   }
/*     */   
/* 159 */   private static final dotimes DOTIMES = new dotimes();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/dotimes.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */