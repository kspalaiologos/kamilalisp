/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.beans.BeanInfo;
/*     */ import java.beans.IntrospectionException;
/*     */ import java.beans.Introspector;
/*     */ import java.beans.PropertyDescriptor;
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
/*     */ public final class JavaBeans
/*     */ {
/*  45 */   private static final Primitive JGET_PROPERTY_VALUE = new pf__jget_property_value();
/*     */ 
/*     */   
/*     */   @DocString(name = "%jget-propety-value", args = "java-object property-name", doc = "Gets a JavaBeans property on JAVA-OBJECT.\nSYSTEM-INTERNAL: Use jproperty-value instead.")
/*     */   private static final class pf__jget_property_value
/*     */     extends Primitive
/*     */   {
/*     */     pf__jget_property_value() {
/*  53 */       super("%jget-property-value", Lisp.PACKAGE_JAVA, false, "java-object property-name");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject javaObject, LispObject propertyName) {
/*     */       try {
/*  60 */         Object obj = javaObject.javaInstance();
/*  61 */         PropertyDescriptor pd = JavaBeans.getPropertyDescriptor(obj, propertyName);
/*  62 */         Object value = pd.getReadMethod().invoke(obj, new Object[0]);
/*  63 */         if (value instanceof LispObject)
/*  64 */           return (LispObject)value; 
/*  65 */         if (value != null) {
/*  66 */           return JavaObject.getInstance(value, true);
/*     */         }
/*  68 */         return Lisp.NIL;
/*     */       }
/*  70 */       catch (Exception e) {
/*  71 */         return Lisp.error(new JavaException(e));
/*     */       } 
/*     */     }
/*     */   }
/*     */   
/*  76 */   private static final Primitive JSET_PROPERTY_VALUE = new pf__jset_property_value();
/*     */ 
/*     */   
/*     */   @DocString(name = "%jset-propety-value", args = "java-object property-name value", doc = "Sets a JavaBean property on JAVA-OBJECT.\nSYSTEM-INTERNAL: Use (setf jproperty-value) instead.")
/*     */   private static final class pf__jset_property_value
/*     */     extends Primitive
/*     */   {
/*     */     pf__jset_property_value() {
/*  84 */       super("%jset-property-value", Lisp.PACKAGE_JAVA, false, "java-object property-name value");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject javaObject, LispObject propertyName, LispObject value) {
/*  90 */       Object obj = null; try {
/*     */         Object jValue;
/*  92 */         obj = javaObject.javaInstance();
/*  93 */         PropertyDescriptor pd = JavaBeans.getPropertyDescriptor(obj, propertyName);
/*     */ 
/*     */         
/*  96 */         if (value instanceof JavaObject) {
/*  97 */           jValue = value.javaInstance();
/*     */         }
/*  99 */         else if (boolean.class.equals(pd.getPropertyType()) || Boolean.class
/* 100 */           .equals(pd.getPropertyType())) {
/* 101 */           jValue = Boolean.valueOf((value != Lisp.NIL));
/*     */         } else {
/* 103 */           jValue = (value != Lisp.NIL) ? value.javaInstance() : null;
/*     */         } 
/*     */         
/* 106 */         pd.getWriteMethod().invoke(obj, new Object[] { jValue });
/* 107 */         return value;
/* 108 */       } catch (Exception e) {
/* 109 */         return Lisp.error(new JavaException(e));
/*     */       } 
/*     */     }
/*     */   }
/*     */   
/*     */   static PropertyDescriptor getPropertyDescriptor(Object obj, LispObject propertyName) throws IntrospectionException {
/* 115 */     String prop = ((AbstractString)propertyName).getStringValue();
/* 116 */     BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
/* 117 */     for (PropertyDescriptor pd : beanInfo.getPropertyDescriptors()) {
/* 118 */       if (pd.getName().equals(prop)) {
/* 119 */         return pd;
/*     */       }
/*     */     } 
/* 122 */     Lisp.error(new LispError("Property " + prop + " not found in " + obj));
/*     */     
/* 124 */     return null;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JavaBeans.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */