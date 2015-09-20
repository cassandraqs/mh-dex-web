(in-package :cl-user)
(defpackage mh-dex-web-asd
  (:use :cl :asdf))
(in-package :mh-dex-web-asd)

(defsystem mh-dex-web
    :version "0.0.1"
    :author "BreakDS <breakds@gmail.com>, Cassandra Qi <cassandraqs@gmail.com>"
    :license "MIT"
    :depends-on (:realispic)
    :components ((:module "assets" :components
                          ((:module "js" :components
                                    ((:static-file "environment.js")
                                     (:static-file "page.js")))))
                 (:module "templates" :components
                          ((:static-file "template.html")))
                 (:module "lisp" 
                          :depends-on ("assets" "templates")
                          :components
                          ((:file "app"))))
    :description "Web application of Ping's Monster Hunter Dex.")
                          
