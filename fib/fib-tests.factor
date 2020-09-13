! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test fib ;
IN: fib.tests

{ 0 } [ 0 fib ] unit-test
{ 1 } [ 1 fib ] unit-test
{ 1 } [ 2 fib ] unit-test
{ 3 } [ 4 fib ] unit-test
{ 13 } [ 7 fib ] unit-test
{ 354224848179261915075 } [ 100 fib ] unit-test