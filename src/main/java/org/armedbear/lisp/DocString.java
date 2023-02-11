package org.armedbear.lisp;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface DocString {
  String name() default "";
  
  String args() default "";
  
  String returns() default "";
  
  String doc() default "";
}


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/DocString.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */