(in-package :mh-dex-web)

(def-service fetch-weapon-list (language type)
  (ensure-weapon-list)
  (get-weapon-entries :en (parse-integer type)))

(def-widget weapon-row ((columns :attribute)
                        (view-type :attribute)
                        (expanded :attribute)
                        (expand-callback :attribute)
                        (weapon-data :attribute))
  (labels ((should-component-update (next-props next-state) 
             (or (!= (@ next-props view-type) view-type)
                 (!= (@ next-props expanded) expanded)))
           (name-cell ()
             (:td ((class "mdl-data-table__cell--non-numeric"))
                  (when (= view-type "tree")
                    (:a ((href "#")
                         (on-click (=> () 
                                       (when (> (@ weapon-data offsprings) 0)
                                         (funcall expand-callback 
                                                  (@ weapon-data sub-id)
                                                  expanded)))))
                        (:i ((class "material-icons")
                             (style :font-size 20
                                    :padding-bottom 2
                                    :margin-left (* 25 (@ weapon-data depth))
                                    :vertical-align "middle"))
                            (if (= (@ weapon-data offsprings) 0)
                                "stars"
                                (if expanded 
                                    "remove_circle" 
                                    "add_box")))))
                  (:a ((href "#")
                       (style :text-decoration "none"
                              :padding-left 10)
                       (on-click (lambda () (trace "clicked."))))
                      (:span () (@ weapon-data name)))))
           (rare-cell ()
             (:td () (@ weapon-data rare)))
           (slots-cell ()
             (:td ((class "mdl-data-table__cell--non-numeric"))
                  (map (lambda (i)
                         (if (< i (@ weapon-data slots))
                             (:i ((class "material-icons")
                                  (style :font-size 16
                                         :padding-top 2))
                                 "panorama_fish_eye")
                             (:i ((class "material-icons")
                                  (style :font-size 16))
                                 "remove")))
                       (funcall (@ *aux* range) 0 3))))
           (damage-cell ()
             (:td () (@ weapon-data damage)))
           (affinity-cell ()
             (:td () 
                  (if (!= (@ weapon-data affinity) 0)
                      (+ (@ weapon-data affinity) "%")
                      nil)))
           (special-cell ()
             (:td ((class "mdl-data-table__cell--non-numeric"))
                  (map (lambda (item)
                         (:span ((style :font-weight 700
                                        :color (@ (aref *weapon_special_attacks*
                                                        (@ item type-id))
                                                  color)))
                                (+ (if (@ item awaken) "(" "")
                                   (@ (aref *weapon_special_attacks* (@ item type-id))
                                      name)
                                   " "
                                   (@ item damage)
                                   (if (@ item awaken) ")" ""))))
                       (@ weapon-data special))))
           (sharpness-cell ()
             (let ((bar-height 14))
               (:td ((class "mdl-data-table__cell--non-numeric"))
                    (:div ((class "mdl-shadow--2dp")
                           (style :height bar-height
                                  :width 135
                                  :display "inline-block"
                                  :background-color "#dfdfdf"))
                          (map (lambda (length index)
                                 (:span ((style :width (* length 3)
                                                :height bar-height
                                                :display "inline-block"
                                                :background-color (aref *weapon_sharpness_colors*
                                                                        index)))))
                               (@ weapon-data sharpness))))))
           (defense-cell ()
             (:td () (when (> (@ weapon-data defense) 0)
                       (@ weapon-data defense)))))
    (:tr ()
         (map (lambda (column)
                (funcall (getprop this (+ column "Cell"))))
              columns))))

(def-widget weapon-table-header ((columns :attribute))
  (:thead ()
          (map (lambda (column) 
                 (:th ((class "mdl-data-table__cell--non-numeric")
                       (key column))
                      (getprop *weapon_table_headers* column)))
               columns)))

(def-widget weapon-table ((weapon-type :attribute)
                          (weapon-list :attribute)
                          (view-type :attribute)
                          (expand-callback :attribute)
                          (visibles :attribute))
  (labels ((should-component-update (next-props next-state)
             (or (!= (@ next-props weapon-type) weapon-type)
                 (!= (@ next-props visibles) visibles)
                 (!= (@ next-props view-type) view-type)
                 (!= (@ next-props weapon-list) weapon-list)))
           (get-columns ()
             (case weapon-type
               (t (array "name" "rare" "slots" "damage" 
                         "affinity" "special" "defense" "sharpness")))))
    (:table ((class "mdl-data-table" "mdl-js-data-table" "mdl-shadow--2dp"))
            (:weapon-table-header ((columns (funcall (@ this get-columns)))))
            (:tbody ()
                    (map (lambda (visible)
                           (defvar weapon-data (aref weapon-list 
                                                     (@ visible sub-id)))
                           (:weapon-row ((key (@ weapon-data id))
                                         (expanded (@ visible expanded))
                                         (view-type view-type)
                                         (columns (funcall (@ this get-columns)))
                                         (expand-callback expand-callback)
                                         (weapon-data weapon-data))))
                         visibles)))))

(def-widget icon-toggle-button ((name :attribute)
                                (callback :attribute)
                                (icon :attribute))
  (labels ((component-did-mount ()
             (funcall (@ (funcall (@ *react find-d-o-m-node)
                                  (@ this refs the-toggle))
                         set-attribute)
                      "for" name)))
    (:label ((ref "theToggle")
             (class "mdl-icon-toggle" "mdl-js-icon-toggle" "mdl-js-ripple-effect"))
            (:input ((type "checkbox")
                     (id name)
                     (class "mdl-icon-toggle__input")
                     (default-checked false)))
            (:i ((class "mdl-icon-toggle__label" "material-icons"))
                icon))))

(def-widget weapon-control-panel ((view-type :attribute)
                                  (on-view-type-change :attribute))
  (:td ()
       (:button ((class "mdl-button" "mdl-js-button" "mdl-button--icon"))
                (:img ((src "assets/images/weapons/lance.png")
                       (style :height 24
                              :width 24))))
       (:button ((class "mdl-button" "mdl-js-button" "mdl-button--icon")
                 (disabled (= view-type "tree"))
                 (on-click (and (= view-type "list") on-view-type-change)))
                (:i ((class "material-icons")
                     (style :color (if (= view-type "tree") 
                                       "#00BCD4"
                                       "#C5C5C5")))
                    "device_hub"))
       (:button ((class "mdl-button" "mdl-js-button" "mdl-button--icon")
                 (disabled (= view-type "list"))
                 (on-click (and (= view-type "tree") on-view-type-change)))
                (:i ((class "material-icons")
                     (style :color (if (= view-type "list")
                                       "#00BCD4"
                                       "#C5C5C5")))
                    "view_list"))))

(def-widget weapon-list-panel ((selected-special :attribute)
                               (on-special-filter :attribute))
  (labels ((component-did-mount ()
             (funcall (@ component-handler upgrade-dom))
             nil)
           
           (component-did-update ()
             (funcall (@ component-handler upgrade-dom))
             nil))

    (:td ((style :text-align "right"))
         (:select-menu ((name "special-attack-filter")
                        (caption (@ (aref *weapon_special_attacks*
                                          selected-special)
                                    name)))
                       (map (lambda (elemental index)
                              (:menu-item ((key index)
                                           (id index)
                                           (callback on-special-filter))
                                          (@ elemental name)))
                            *weapon_special_attacks*)))))

(def-widget weapon-tree-panel ()
  (labels ((component-did-mount ()
             (funcall (@ component-handler upgrade-dom))
             nil)
           
           (component-did-update ()
             (funcall (@ component-handler upgrade-dom))
             nil))
    (:td ((style :text-align "right"))
         (:button ((class "mdl-button" "mdl-js-button" "mdl-js-ripple-effect"))
                  "Expand")
         (:button ((class "mdl-button" "mdl-js-button" "mdl-js-ripple-effect"))
                  "Collapse"))))

(def-widget weapon-page ((active-page :attribute)
                         (view-type :state "list")
                         (weapon-type :state "great sword")
                         (weapon-list :state (array))
                         (selected-special :state 0)
                         (visibles :state (array)))
  (labels ((switch-view-type ()
             (let ((new-view-type (if (= (:state view-type) "tree") 
                                      "list"
                                      "tree")))
               (if (= new-view-type "tree")
                   (progn (defvar new-visibles (array))
                          (funcall (@ (:state weapon-list) for-each)
                                   (lambda (weapon-data index)
                                     (when (= (@ weapon-data depth) 0)
                                       (funcall (@ new-visibles push) 
                                                (create sub-id index
                                                        expanded false)))))
                          (update-state view-type new-view-type
                                        visibles new-visibles))
                   (update-state view-type new-view-type
                                 visibles (map (lambda (weapon-data index)
                                                 (create sub-id index
                                                         expanded false))
                                               (:state weapon-list))))))
           (handle-expand (sub-id already-expanded)
             ;; Expand the children of the weapon specified by
             ;; sub-id. If already expanded, collapse it instead.
             (defvar depth (@ (aref (:state weapon-list) sub-id) depth))
             (defvar max-offspring-sub-id 
               (+ (@ (aref (:state weapon-list) sub-id) offsprings)
                  sub-id))
             (if already-expanded
                 (progn (defvar new-visibles 
                          (funcall (@ (:state visibles) filter)
                                   (lambda (visible)
                                     (or (<= (@ visible sub-id) sub-id)
                                         (> (@ visible sub-id) max-offspring-sub-id)))))
                        (funcall (@ new-visibles for-each)
                                 (lambda (visible index)
                                   (when (= (@ visible sub-id) sub-id)
                                     (setf (@ visible expanded) false))))
                        (update-state visibles new-visibles))
                 (progn (defvar new-visibles (array))
                        (funcall (@ (:state visibles) for-each)
                                 (=> (visible index)
                                     (if (or (< (@ visible sub-id) sub-id)
                                             (> (@ visible sub-id) max-offspring-sub-id))
                                         (funcall (@ new-visibles push) visible)
                                         (progn
                                           (funcall (@ new-visibles push) 
                                                    (create sub-id sub-id
                                                            expanded true))
                                           (loop for i from (1+ sub-id)
                                              to max-offspring-sub-id
                                              do (when (= (@ (aref (:state weapon-list) i) depth)
                                                          (1+ depth))
                                                   (funcall (@ new-visibles push) 
                                                            (create sub-id i
                                                                    expanded false))))))))
                        (update-state visibles new-visibles))))
           (handle-special-change (special-id)
             (when (!= (:state selected-special) special-id)
               (defvar new-visibles (array))
               (funcall (@ (:state weapon-list) for-each)
                        (lambda (weapon-data index)
                          (defvar specials (@ weapon-data special))
                          (when (or (= special-id 0)
                                    (and (> (@ specials length) 0)
                                         (= (@ (aref specials 0) type-id) special-id))
                                    (and (> (@ specials length) 1)
                                         (= (@ (aref specials 1) type-id) special-id)))
                            (funcall (@ new-visibles push)
                                     (create sub-id index
                                             expanded false)))))
               (update-state selected-special special-id
                             visibles new-visibles)))
           (component-will-mount ()
             (trace "RPC: calling fetch-weapon-list")
             (with-rpc ("fetch-weapon-list" :language "english"
                                            :type 1)
               (if rpc-error
                   (trace rpc-error)
                   (update-state weapon-list rpc-result
                                 visibles (map (lambda (weapon-data index)
                                                 (create sub-id index
                                                         expanded false))
                                               rpc-result)))
               (trace (aref rpc-result 0)))
             nil))
    (:app-page ((name "weapon-page")
                (active-page active-page))
               (:div ((class "mdl-grid"))
                     (:div ((class "mdl-cell" "mdl-cell--9-col"))
                           (:table ()
                                   (:tr () 
                                        (:td ((col-span 2))
                                             (:label ((style :margin-right 10))
                                                     "Search Armors")
                                             (:expandable-search-bar ((name "weapon-search-bar")))))
                                   (:tr ()
                                        (:weapon-control-panel ((view-type (:state view-type))
                                                                (on-view-type-change (@ this switch-view-type))))
                                        (if (= (:state view-type) "list")
                                            (:weapon-list-panel ((selected-special 
                                                                  (:state selected-special))
                                                                 (on-special-filter 
                                                                  (@ this handle-special-change))))
                                            (:weapon-tree-panel ())))
                                   (:tr ()
                                        (:td ((col-span 2))
                                             (:weapon-table ((weapon-type (:state weapon-type))
                                                             (visibles (:state visibles))
                                                             (view-type (:state view-type))
                                                             (expand-callback (@ this handle-expand))
                                                             (weapon-list (:state weapon-list))))))))))))


