(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)

  (unless (find-package :mh-dex-web.data-service)
    (defpackage mh-dex-web.data-service
      (:use :cl)
      (:import-from :jonathan
                    :to-json
                    :%to-json
                    :write-key-value
                    :with-object)
      (:export :get-weapon-entries
               :ensure-weapon-list)))

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
                    :lambda!
                    :trace
                    :map)
      (:import-from :mh-dex-web.data-service
                    :get-weapon-entries
                    :ensure-weapon-list)
      (:export :dex))))



