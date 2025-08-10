;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Writeroom (zen) settings
;; Disable line numbers in zen mode
(after! writeroom-mode
  (add-hook! 'writeroom-mode-enable-hook :append
             (setq-local display-line-numbers nil))
  (add-hook! 'writeroom-mode-disable-hook :append
             (setq-local display-line-numbers t)))

(setq writeroom-width 40)

;; Org-related settings
;; Hide emphasis marker
(setq org-hide-emphasis-markers t)
(setq org-startup-folded t)
(setq org-directory "~/personal/org")

;; Org - Capture templates

(defun my/week-of-month ()
  "Return the week number within the current month (1–5)."
  (let* ((day (string-to-number (format-time-string "%d")))
         (week (1+ (/ (1- day) 7))))
    (format "Week %d" week)))

(defun my/org-part-of-day ()
  "Return Morning/Afternoon/Evening/Night based on current hour."
  (let ((h (string-to-number (format-time-string "%H"))))
    (cond ((< h 5)  "Early Morning")
          ((< h 12) "Morning")
          ((< h 17) "Afternoon")
          ((< h 21) "Evening")
          (t        "Late Night"))))

(defun my/org-journal-target ()
  "Jump to org-directory/journal.org and ensure headings:
* Month Year
** Week N (month-based)
*** m/d/YYYY, Weekday
Place point under the date for a new entry."
  (let* ((file (expand-file-name "journal.org" org-directory))
         (month (format-time-string "%B %Y"))         ;; e.g., "August 2025"
         (week  (my/week-of-month))                   ;; e.g., "Week 3"
         (date  (format-time-string "%-m/%-d/%Y, %A"))) ;; e.g., "8/8/2025, Friday"
    (set-buffer (org-capture-target-buffer file))
    (org-capture-put-target-region-and-position)
    (widen)
    ;; Ensure * Month Year
    (goto-char (point-min))
    (unless (re-search-forward (format "^\\* %s\\s-*$" (regexp-quote month)) nil t)
      (goto-char (point-max)) (unless (bolp) (insert "\n"))
      (insert "* " month "\n"))
    (org-back-to-heading t)

    ;; Ensure ** Week N under Month
    (org-narrow-to-subtree)
    (unless (re-search-forward (format "^\\*\\* %s\\s-*$" (regexp-quote week)) nil t)
      (goto-char (point-max)) (unless (bolp) (insert "\n"))
      (insert "** " week "\n"))
    (org-back-to-heading t)

    ;; Ensure *** Date under Week
    (org-narrow-to-subtree)
    (unless (re-search-forward (format "^\\*\\*\\* %s\\s-*$" (regexp-quote date)) nil t)
      (goto-char (point-max)) (unless (bolp) (insert "\n"))
      (insert "*** " date "\n"))
    (widen)
    ;; Position at end of the date subtree so the capture entry becomes a child
    (re-search-backward (format "^\\*\\*\\* %s\\s-*$" (regexp-quote date)))
    (org-end-of-subtree t t)))

(after! org
  (add-to-list 'org-capture-templates
               '("j" "Journal" entry
                 (function my/org-journal-target)
                 "* %(my/org-part-of-day) [%<%-I:%M%p>]\n%?\n")))
