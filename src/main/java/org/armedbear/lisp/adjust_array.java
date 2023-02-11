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
/*     */ 
/*     */ 
/*     */ public final class adjust_array
/*     */   extends Primitive
/*     */ {
/*     */   public adjust_array() {
/*  45 */     super("%adjust-array", Lisp.PACKAGE_SYS, false);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/*  51 */     if (args.length != 10)
/*  52 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 10)); 
/*  53 */     AbstractArray array = Lisp.checkArray(args[0]);
/*  54 */     LispObject dimensions = args[1];
/*  55 */     LispObject elementType = args[2];
/*  56 */     boolean initialElementProvided = (args[4] != Lisp.NIL);
/*  57 */     boolean initialContentsProvided = (args[6] != Lisp.NIL);
/*  58 */     LispObject initialElement = initialElementProvided ? args[3] : null;
/*  59 */     LispObject initialContents = initialContentsProvided ? args[5] : null;
/*  60 */     LispObject fillPointer = args[7];
/*  61 */     LispObject displacedTo = args[8];
/*  62 */     LispObject displacedIndexOffset = args[9];
/*  63 */     if (initialElementProvided && initialContentsProvided) {
/*  64 */       return Lisp.error(new LispError("ADJUST-ARRAY: cannot specify both initial element and initial contents."));
/*     */     }
/*  66 */     if (elementType != array.getElementType() && 
/*  67 */       Lisp.getUpgradedArrayElementType(elementType) != array.getElementType())
/*     */     {
/*  69 */       return Lisp.error(new LispError("ADJUST-ARRAY: incompatible element type."));
/*     */     }
/*  71 */     if (array.getRank() == 0) {
/*  72 */       return array.adjustArray(new int[0], initialElement, initialContents);
/*     */     }
/*  74 */     if (!initialElementProvided && array.getElementType() == Lisp.T)
/*  75 */       initialElement = Fixnum.ZERO; 
/*  76 */     if (array.getRank() == 1) {
/*     */       int newSize;
/*  78 */       if (dimensions instanceof Cons && dimensions.length() == 1) {
/*  79 */         newSize = Fixnum.getValue(dimensions.car());
/*     */       } else {
/*  81 */         newSize = Fixnum.getValue(dimensions);
/*  82 */       }  if (array instanceof AbstractVector) {
/*  83 */         AbstractArray v2; AbstractVector v = (AbstractVector)array;
/*     */         
/*  85 */         if (displacedTo != Lisp.NIL) {
/*     */           int displacement;
/*  87 */           if (displacedIndexOffset == Lisp.NIL) {
/*  88 */             displacement = 0;
/*     */           } else {
/*  90 */             displacement = Fixnum.getValue(displacedIndexOffset);
/*  91 */           }  v2 = v.adjustArray(newSize, 
/*  92 */               Lisp.checkArray(displacedTo), displacement);
/*     */         } else {
/*     */           
/*  95 */           v2 = v.adjustArray(newSize, initialElement, initialContents);
/*     */         } 
/*     */ 
/*     */         
/*  99 */         if (fillPointer != Lisp.NIL)
/* 100 */           v2.setFillPointer(fillPointer); 
/* 101 */         return v2;
/*     */       } 
/*     */     } 
/*     */     
/* 105 */     int rank = dimensions.listp() ? dimensions.length() : 1;
/* 106 */     int[] dimv = new int[rank];
/* 107 */     if (dimensions.listp()) {
/* 108 */       for (int i = 0; i < rank; i++) {
/* 109 */         LispObject dim = dimensions.car();
/* 110 */         dimv[i] = Fixnum.getValue(dim);
/* 111 */         dimensions = dimensions.cdr();
/*     */       } 
/*     */     } else {
/* 114 */       dimv[0] = Fixnum.getValue(dimensions);
/*     */     } 
/* 116 */     if (displacedTo != Lisp.NIL) {
/*     */       int displacement;
/* 118 */       if (displacedIndexOffset == Lisp.NIL) {
/* 119 */         displacement = 0;
/*     */       } else {
/* 121 */         displacement = Fixnum.getValue(displacedIndexOffset);
/* 122 */       }  return array.adjustArray(dimv, 
/* 123 */           Lisp.checkArray(displacedTo), displacement);
/*     */     } 
/*     */     
/* 126 */     return array.adjustArray(dimv, initialElement, initialContents);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 132 */   private static final Primitive _ADJUST_ARRAY = new adjust_array();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/adjust_array.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */