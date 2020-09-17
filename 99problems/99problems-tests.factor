! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test 99problems ;
IN: 99problems.tests

{ 7 } [ { 1 3 5 7 } my-last ] unit-test
{ f } [ { } my-last ] unit-test

{ { 5 7 } } [ { 1 3 5 7 } my-but-last ] unit-test
{ { 1 2 } } [ { 1 2 } my-but-last ] unit-test
{ f } [ { 1 } my-but-last ] unit-test
{ f } [ { } my-but-last ] unit-test

{ 5 } [ { 1 3 5 7 } 2 element-at ] unit-test
{ 1 } [ { 1 3 5 7 } 0 element-at ] unit-test
{ f } [ { 1 3 5 7 } 4 element-at ] unit-test
{ f } [ { 1 3 5 7 } 14 element-at ] unit-test

{ 4 } [ { 1 3 5 7 } my-length ] unit-test
{ 0 } [ { } my-length ] unit-test

{ { 7 5 3 1 } } [ { 1 3 5 7 } my-reverse ] unit-test
{ { 1 } } [ { 1 } my-reverse ] unit-test
{ { } } [ { } my-reverse ] unit-test

{ t } [ { 1 2 3 2 1 } palindrome? ] unit-test
{ t } [ { 1 2 1 } palindrome? ] unit-test
{ t } [ { 1 1 } palindrome? ] unit-test
{ t } [ { 1 } palindrome? ] unit-test
{ f } [ { 1 2 3 2 4 } palindrome? ] unit-test
{ f } [ { 1 1 2 3 2 1 } palindrome? ] unit-test
{ t } [ { } palindrome? ] unit-test

{ { 1 2 } } [ { 1 2 } my-flatten ] unit-test
{ { 1 2 } } [ { 1 { 2 } } my-flatten ] unit-test
{ { 1 2 } } [ { { 1 2 } } my-flatten ] unit-test
{ { 1 2 3 4 5 } } [ { 1 2 { 3 { 4 5 } } } my-flatten ] unit-test

{ { 1 2 3 4 5 } } [ { 1 2 3 4 5 } compress ] unit-test
{ { 1 2 3 4 5 } } [ { 1 1 2 2 2 3 4 5 5 } compress ] unit-test
{ { 1 } } [ { 1 1 1 1 1 } compress ] unit-test
{ { } } [ { } compress ] unit-test

{ { { 1 } { 2 } { 3 } { 4 } { 5 } } }
[ { 1 2 3 4 5 } pack ] unit-test
{ { { 1 1 } { 2 2 } { 3 3 } { 2 2 } { 5 5 } } }
[ { 1 1 2 2 3 3 2 2 5 5 } pack ] unit-test
{ { } } [ { } pack ] unit-test
{ { { 1 1 1 1 } { 2 } { 3 3 } { 1 1 } { 4 } { 5 5 5 5 } } }
[ { 1 1 1 1 2 3 3 1 1 4 5 5 5 5 } pack ] unit-test

{ { } } [ { } encode ] unit-test
{ { { 4 1 } { 1 2 } { 2 3 } { 2 1 } { 1 4 } { 4 5 } } }
[ { 1 1 1 1 2 3 3 1 1 4 5 5 5 5 } encode ] unit-test

{ { { 4 1 } 2 { 2 3 } { 2 1 } 4 { 4 5 } } }
[ { 1 1 1 1 2 3 3 1 1 4 5 5 5 5 } encode* ] unit-test

{ { 1 1 1 1 2 3 3 1 1 4 5 5 5 5 } }
[ { { 4 1 } 2 { 2 3 } { 2 1 } 4 { 4 5 } } decode ] unit-test
{ { } } [ { } decode ] unit-test
{ { 1 1 1 1 2 } } [ { { 4 1 } 2 } decode ] unit-test

{ { { 4 1 } 2 { 2 3 } { 2 1 } 4 { 4 5 } } }
[ { 1 1 1 1 2 3 3 1 1 4 5 5 5 5 } encode-direct ] unit-test

{ { } } [ { } dupli ] unit-test
{ { 1 1 } } [ { 1 } dupli ] unit-test
{ { 1 1 2 2 } } [ { 1 2 } dupli ] unit-test

{ { } } [ { } 3 repli ] unit-test
{ { 1 1 1 2 2 2 3 3 3 } } [ { 1 2 3 } 3 repli ] unit-test
{ { 1 1 1 1 1 } } [ { 1 } 5 repli ] unit-test

{ { 1 2 4 5 7 8 } } [ { 1 2 3 4 5 6 7 8 9 } 3 drop-nth ] unit-test
{ { 1 2 4 5 7 8 } } [ { 1 2 3 4 5 6 7 8 9 } 3 drop-nth* ] unit-test

{ { { 1 2 3 } { 4 5 6 } } } [ { 1 2 3 4 5 6 } 3 split ] unit-test

{ { 3 4 5 } } [ { 1 2 3 4 5 6 } 3 5 slice ] unit-test

{ { 4 5 6 7 8 9 1 2 3 } } [ { 1 2 3 4 5 6 7 8 9 } 3 rotate ] unit-test
{ { 7 8 9 1 2 3 4 5 6 } } [ { 1 2 3 4 5 6 7 8 9 } -3 rotate ] unit-test

{ { 1 2 4 } } [ { 1 2 3 4 } 3 remove-at ] unit-test

{ { 1 "hello" 2 3 } } [ "hello" { 1 2 3 } 2 insert-at ] unit-test

{ { 4 5 6 7 8 9 } } [ 4 9 range ] unit-test
{ { 4 5 6 7 8 9 } } [ 4 9 range* ] unit-test

{ {
  { 1 2 3 }
  { 1 2 4 }
  { 1 2 5 }
  { 1 3 4 }
  { 1 3 5 }
  { 1 4 5 }
  { 2 3 4 }
  { 2 3 5 }
  { 2 4 5 }
  { 3 4 5 }
} } [ 3 { 1 2 3 4 5 } combination ] unit-test

{ {
  { 12 }
  { 4 5 }
  { 4 5 }
  { 1 2 3 }
  { 6 7 8 }
  { 9 10 11 }
} }
[ { { 1 2 3 } { 4 5 } { 6 7 8 } { 4 5 } { 9 10 11 } { 12 } } lsort ] unit-test

{ {
  { 9 10 11 12 }
  { 15 }
  { 1 2 3 }
  { 6 7 8 }
  { 4 5 }
  { 4 5 }
  { 13 14 }
} }
[ { { 1 2 3 } { 4 5 } { 6 7 8 } { 4 5 } { 9 10 11 12 } { 13 14 } { 15 } } lfsort ]
unit-test

{ t } [ 17 is-prime? ] unit-test
{ t } [ 2 is-prime? ] unit-test
{ f } [ 1 is-prime? ] unit-test
{ f } [ 8 is-prime? ] unit-test
{ f } [ 9 is-prime? ] unit-test

{ 2 } [ 8 6 my-gcd ] unit-test
{ 12 } [ 12 24 my-gcd ] unit-test
{ 4 } [ 12 16 my-gcd ] unit-test
{ 1 } [ 125 81 my-gcd ] unit-test

{ f } [ 8 6 coprime? ] unit-test
{ f } [ 12 24 coprime? ] unit-test
{ f } [ 12 16 coprime? ] unit-test
{ t } [ 125 81 coprime? ] unit-test
{ t } [ 47 120 coprime? ] unit-test