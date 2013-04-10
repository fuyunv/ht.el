(require 'ert)
(require 'ht)

(ert-deftest ht-test-ht ()
  (let ((h (ht (1 2) ("foo" (1+ 2)))))
    (should (and (member 1 (ht-keys h))
                 (member "foo" (ht-keys h))
                 (member 2 (ht-values h))
                 (member 3 (ht-values h))))))

(ert-deftest ht-test-create ()
  (should (hash-table-p (ht-create))))

(ert-deftest ht-test-set-then-get ()
  (let ((h (ht-create)))
    (ht-set h "foo" "bar")
    (should (equal (ht-get h "foo") "bar"))))

(ert-deftest ht-test-get-default ()
  (let ((h (ht-create)))
    (should (equal (ht-get h "foo" "default") "default"))))

(ert-deftest ht-test-create-non-default-test ()
  (let ((h (ht-create 'eq)))
    (should (equal (hash-table-test h) 'eq))))

(ert-deftest ht-test-remove ()
  (let ((h (ht-create)))
    (ht-set h "foo" "bar")
    (ht-remove h "foo")
    (should (equal (ht-get h "foo") nil))))

(ert-deftest ht-test-clear ()
  (let ((h (ht-create)))
    (ht-set h "foo" "bar")
    (ht-set h "biz" "baz")
    (ht-clear h)
    (should (equal (ht-items h) nil))))

(ert-deftest ht-test-keys ()
  (let ((h (ht-create)))
    (ht-set h "foo" "bar")
    (should (equal (ht-keys h) (list "foo")))))

(ert-deftest ht-test-values ()
  (let ((h (ht-create)))
    (ht-set h "foo" "bar")
    (should (equal (ht-values h) (list "bar")))))

(ert-deftest ht-test-items ()
  (let ((h (ht-create)))
    (ht-set h "key1" "value1")
    (should (equal (ht-items h) '(("key1" "value1"))))))

(ert-deftest ht-test-from-alist ()
  (let* ((alist '(("key1" . "value1")))
         (h (ht-from-alist alist)))
    (should (equal (ht-items h) '(("key1" "value1"))))))

(ert-deftest ht-test-from-alist-masked-values ()
  (let* ((alist '(("key1" . "value1") ("key1" . "value2")))
         (h (ht-from-alist alist)))
    (should (equal (ht-items h) '(("key1" "value1"))))))

(ert-deftest ht-test-from-plist ()
  (let* ((plist '("key1" "value1"))
         (h (ht-from-plist plist)))
    (should (equal (ht-items h) '(("key1" "value1"))))))

(ert-deftest ht-test-to-alist ()
  (let* ((alist '(("key1" . "value1") ("key2" . "value2")))
         (h (ht-from-alist alist)))
    (should (or (equal (ht-to-alist h) alist)
                (equal (ht-to-alist h) (reverse alist))))))

(ert-deftest ht-test-to-plist ()
  (let* ((h (ht-create)))
    (ht-set h "foo" "bar")
    (should (equal (ht-to-plist h) '("foo" "bar")))))

(defun ht-run-tests ()
  (interactive)
  (ert-run-tests-interactively "ht-test-"))
