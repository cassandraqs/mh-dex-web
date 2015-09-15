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
                    :rpc-error)
      (:import-from :realispic.candy
                    :trace)
      (:export :dex))))
(in-package :mh-dex-web)

(def-widget main-app-view ()
  (:button () "main-app"))
  ;; (:div ((class "mdl-layout mdl-js-layout"))
  ;;       (:header ((class "mdl-layout__header"))
  ;;                (:div ((class "mdl-layout__header-row"))
  ;;                      ;; Add spacer, to align navigation to the right
  ;;                      (:div ((class "mdl-layout-spacer")))
  ;;                      (:nav ((class "mdl-navigation"))
  ;;                            (:a ((class "mdl-navigation__link"
                                         
                 
                         

(def-app dex ()
  :title "MH4G Dex"
  :port 5120
  :system :mh-dex-web
  :includes (;; Material Design Lite
             "https://storage.googleapis.com/code.getmdl.io/1.0.4/material.grey-blue.min.css"
             "https://storage.googleapis.com/code.getmdl.io/1.0.4/material.min.js"
             "https://fonts.googleapis.com/icon?family=Material+Icons"
             "assets/js/app.js")
  :static-root (merge-pathnames "assets/"
                                (asdf:system-source-directory :mh-dex-web))
  :widget (:main-app-view ()))

                      

  
  



               
        
      
      
    
