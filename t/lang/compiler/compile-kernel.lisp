#|
  This file is a part of oclcl project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage oclcl-test.lang.compiler.compile-kernel
  (:use :cl :prove
        :oclcl.lang.type
        :oclcl.lang.kernel
        :oclcl.lang.compiler.compile-kernel))
(in-package :oclcl-test.lang.compiler.compile-kernel)

(plan nil)


;;;
;;; test COMPILE-KERNEL funcition
;;;

(diag "COMPILE-KERNEL")

(let ((kernel (make-kernel)))
  (kernel-define-function kernel 'foo 'void '((x int*))
                                 '((set (aref x 0) (bar 1))
                                   (return)))
  (kernel-define-function kernel 'bar 'int '((x int)) '((return x)))
  (kernel-define-function kernel 'baz 'void '() '((return)))
  (is (compile-kernel kernel)
      "#include \"int.h\"
#include \"float.h\"
#include \"float3.h\"
#include \"float4.h\"
#include \"double.h\"
#include \"double3.h\"
#include \"double4.h\"
#include \"curand.h\"


/**
 *  Kernel function prototypes
 */

__kernel void oclcl_test_lang_compiler_compile_kernel_baz();
 int oclcl_test_lang_compiler_compile_kernel_bar( int x );
__kernel void oclcl_test_lang_compiler_compile_kernel_foo( int* x );


/**
 *  Kernel function definitions
 */

__kernel void oclcl_test_lang_compiler_compile_kernel_baz()
{
  return;
}

 int oclcl_test_lang_compiler_compile_kernel_bar( int x )
{
  return x;
}

__kernel void oclcl_test_lang_compiler_compile_kernel_foo( int* x )
{
  x[0] = oclcl_test_lang_compiler_compile_kernel_bar( 1 );
  return;
}
"
      "basic case 1"))


(finalize)
