(in-package :mh-dex-web)


(def-widget menu-item ((id :attribute)
                       (callback :attribute))
  (:li ((class "mdl-menu__item")
        (on-click (lambda! () (funcall callback id))))
       (@ this props children)))
                           
       

(def-widget dropdown-menu ((for :attribute))
  (labels ((component-did-mount ()
             (funcall (@ (funcall (@ *react find-d-o-m-node)
                                  ;; There is a bug since we should
                                  ;; not have to use (@ this props
                                  ;; for).
                                  (@ this refs the-ul))
                         set-attribute)
                      "for" for)))
    (:ul ((ref "theUl")
          (class "mdl-menu" "mdl-menu--bottom-left"
                 "mdl-js-menu" "mdl-js-ripple-effect"))
         (@ this props children))))

(def-widget select-menu ((name :attribute)
                         (caption :attribute))
  (:span ()
         (:button ((class "mdl-button" "mdl-js-button")
                   (id name))
                  caption)
         (:dropdown-menu ((for name))
                         (@ this props children))))

;; (def-widget icon-toggle ((name :attribute)
;;                          (callback :attribute)
;;                          (icon :attribute))
;;   (labels ((component-did-mount ()
;;              (funcall (@ (funcall (@ *react find-d-o-m-node)
;;                                   (@ this refs checkbox-input))
;;                          set-attribute)
;;                       "for" name)))
;;     (:label ((ref "checkboxInput")
;;              (class "mdl-icon-toggle" "mdl-js-icon-toggle"
;;                     "mdl-js-ripple-effect"))
;;             (:input ((id name)
;;                      (type "checkbox")
;;                      (class "mdl-icon-toggle__input"))
;;                     (:i ((class "mdl-icon-toggle_label" "material-icons"))
;;                         icon)))))

