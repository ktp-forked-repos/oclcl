#|
  This file is a part of oclcl project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage oclcl-test.lang.type
  (:use :cl :cl-test-more
        :oclcl.lang.data
        :oclcl.lang.type))
(in-package :oclcl-test.lang.type)

(plan nil)


;;;
;;; test OCLCL-TYPE-P function
;;;

(diag "OCLCL-TYPE-P")

(dolist (type '(char uchar short ushort int uint long ulong))
  (is (oclcl-type-p type) t (format nil "integer type : ~a" type)))
(dolist (type '(float double))
  (is (oclcl-type-p type) t (format nil "float type : ~a" type)))

(is (oclcl-type-p 'int) t "basic case 1")
(is (oclcl-type-p 'float3) t "basic case 2")
(is (oclcl-type-p 'float3*) t "basic case 3")
(is (oclcl-type-p '*float*) nil "basic case 4")


;;;
;;; test CFFI-TYPE function
;;;

(diag "CFFI-TYPE")

(is (cffi-type 'int) :int "basic case 1")
(is (cffi-type 'float3) '(:struct float3) "basic case 2")


;;;
;;; test CFFI-TYPE-SIZE function
;;;

(diag "CFFI-TYPE-SIZE")

(is (cffi-type-size 'int) 4 "basic case 1")
(is (cffi-type-size 'float3) 12 "basic case 2")


;;;
;;; test CUDA-TYPE function
;;;

(diag "CUDA-TYPE")

(is (cuda-type 'int) "int" "basic case 1")
(is (cuda-type 'float3) "float3" "basic case 2")
(is (cuda-type 'float3*) "float3*" "basic case 3")


;;;
;;; test STRUCTURE-ACCESSOR-P function
;;;

(diag "STRUCTURE-ACCESSOR-P")

(is (structure-accessor-p 'float3-x) t "basic case 1")
(is (structure-accessor-p 'float4-w) t "basic case 2")
(is (structure-accessor-p 'float3-w) nil "basic case 3")


;;;
;;; test STRUCTURE-ACCESSOR-CUDA-ACCESSOR function
;;;

(diag "STRUCTURE-ACCESSOR-CUDA-ACCESSOR")

(is (structure-accessor-cuda-accessor 'float3-x) "x" "basic case 1")
(is (structure-accessor-cuda-accessor 'float4-w) "w" "basic case 2")
(is-error (structure-accessor-cuda-accessor 'float3-w) simple-error
          "ACCESSOR which is not an invalid accessor.")


;;;
;;; test STRUCTURE-ACCESSOR-RETURN-TYPE function
;;;

(diag "STRUCTURE-ACCESSOR-RETURN-TYPE")

(is (structure-accessor-return-type 'float3-x) 'float "basic case 1")
(is (structure-accessor-return-type 'double4-w) 'double "basic case 2")
(is-error (structure-accessor-return-type 'float3-w) simple-error
          "ACCESSOR which is not an invalid accessor.")


;;;
;;; test ARRAY-TYPE-BASE function
;;;

(diag "ARRAY-TYPE-BASE")

(is (array-type-base 'int*) 'int
    "basic case 1")

(is (array-type-base 'int**) 'int
    "basic case 2")


;;;
;;; test ARRAY-TYPE-DIMENSION function
;;;

(diag "ARRAY-TYPE-DIMENSION")

(is (array-type-dimension 'int*) 1
    "basic case 1")

(is (array-type-dimension 'int**) 2
    "basic case 2")


(finalize)
