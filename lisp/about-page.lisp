(in-package :mh-dex-web)

(def-widget about-page-title ()
  (:h3 ((style :font-size 24
               :font-weight 500
               :margin-top 40
               :margin-left 20
               :color "rgba(0, 0, 0, .54)"
               :text-transform "uppercase"))
       (@ this props children)))

(def-widget developer-info-card ((developer-name :attribute)
                                 (weapon :attribute))
  (:div ((class "mdl-card mdl-shadow--2dp"))
        (:div ((class "mdl-card__title"))
              ;; (:i ((class "material-icons")
              ;;      (style :margin-left 10))
              ;;     "assignment_ind")
              (:img ((src (+ "assets/images/weapons/" 
                             weapon
                             ".png"))
                     (style :width 32 :height 32
                            :margin-right 10)))
              (:h2 ((class "mdl-card__title-text"))
                   developer-name))
        (:div ((class "mdl-card__supporting-text"))
              (@ this props children))))

(def-widget about-page ((is-active :attribute))
  (:app-page ((link "about-page")
              (is-active is-active))
             (:about-page-title () "Development Team")
             (:section ((class "mdl-grid"))
                       (:div ((class "mdl-cell mdl-cell--3-col"))
                             (:developer-info-card ((developer-name "Ping")
                                                    (weapon "charge_blade"))
                                                   "Ping is a seasoned monster hunter player. "
                                                   "His favorite weapon is a charge blade."))
                       (:div ((class "mdl-cell mdl-cell--3-col"))
                             (:developer-info-card ((developer-name "Breakds")
                                                    (weapon "lance"))
                                                   "Break is the lancer and the backend developer."))
                       (:div ((class "mdl-cell mdl-cell--3-col"))
                             (:developer-info-card ((developer-name "Cassandra Qi")
                                                    (weapon "switch_axe"))
                                                   "Cassandra is the frontend developer and "
                                                   "the axe weild.")))
             (:hr ())
             (:about-page-title () "Copyrights")
             (:section ((class "mdl-grid"))
                       (:div ((class "mdl-cell mdl-cell--6-col"))
                             "This application and its source code are distributed under the MIT license."))))
