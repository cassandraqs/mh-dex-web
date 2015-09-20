(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :mh-dex-web)
    (defpackage mh-dex-web
      (:use :cl :parenscript)
      (:import-from :realispic
                    :def-app
                    :def-widget
                    :def-service
                    :import-widget
                    :with-rpc
                    :rpc-result
                    :rpc-error
                    :*template-path*)
      (:import-from :realispic.candy
                    :trace)
      (:export :dex))))

