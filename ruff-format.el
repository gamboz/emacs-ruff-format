;;; ruff-format.el --- Ruff format Python source     -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Ville Skyttä

;; Author: Ville Skyttä <ville.skytta@iki.fi>
;; URL: https://github.com/JoshHayes/emacs-ruff-format
;; Package-Requires: ((emacs "24") (reformatter "0.3"))
;; Version: 0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:

;; Format Python source code using the Ruff formatter.

;;; Code:

(require 'reformatter)

(defcustom ruff-format-command "ruff"
  "Ruff command to use for formatting."
  :type 'string
  :group 'ruff-format)

;;;###autoload (autoload 'ruff-format-buffer "ruff-format" nil t)
;;;###autoload (autoload 'ruff-format-region "ruff-format" nil t)
;;;###autoload (autoload 'ruff-format-on-save-mode "ruff-format" nil t)

(reformatter-define ruff-format
  :program ruff-format-command
  :args (list "format" "--stdin-filename" (or (buffer-file-name) input-file))
  :lighter " RuffFmt"
  :group 'ruff-format)

;;;###autoload (autoload 'ruff-check-buffer "ruff-check" nil t)
;;;###autoload (autoload 'ruff-check-region "ruff-check" nil t)
;;;###autoload (autoload 'ruff-check-on-save-mode "ruff-check" nil t)
(reformatter-define ruff-check
  :program "ruff"
  :args (list "check" input-file)
  :lighter " RuffChk"
  :stdin nil
  :stdout nil
  :input-file (reformatter-temp-file)
  :group 'ruff-format
  )

;; bind to C-S-F11 with something like
;; (use-package python
;;   :bind (:map python-mode-map
;;               ([C-f11] . (lambda () (interactive)
;;                            (ruff-format-buffer)))
;;               ([S-C-f11] . (lambda () (interactive)
;;                              (ruff-check-buffer)))
;;               )


(provide 'ruff-format)
;;; ruff-format.el ends here
