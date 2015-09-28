(in-package :cl-user)
(defpackage mh-dex-web-asd
  (:use :cl :asdf))
(in-package :mh-dex-web-asd)

(defsystem mh-dex-web
    :version "0.0.1"
    :author "BreakDS <breakds@gmail.com>, Cassandra Qi <cassandraqs@gmail.com>"
    :license "MIT"
    :depends-on (:realispic
                 :sqlite
                 :jonathan)
    :components ((:module "assets" :components
                          ((:module "js" :components
                                    ((:static-file "environment.js")
                                     (:static-file "page.js")
                                     (:static-file "constants.js")))))
                 (:module "templates" :components
                          ((:static-file "template.html")))
                 (:module "lisp" 
                          :depends-on ("assets" "templates")
                          :components
                          ((:file "packages")
                           (:file "imported-widgets" :depends-on ("packages"))
                           (:file "common-components" :depends-on ("packages"))
                           (:file "data-service" :depends-on ("packages"))
                           (:file "about-page" :depends-on ("packages" "imported-widgets"))
                           (:file "weapon-page" :depends-on ("packages" "imported-widgets"
                                                                        "common-components"
                                                                        "data-service"))
                           (:file "app" 
                                  :depends-on ("imported-widgets" "about-page"
                                                                  "weapon-page")))))
    :description "Web application of Ping's Monster Hunter Dex.")
