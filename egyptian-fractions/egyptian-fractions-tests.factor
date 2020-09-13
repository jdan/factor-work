! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test egyptian-fractions ;
IN: egyptian-fractions.tests

{ { 1/2 1/10 } } [ 3/5 rational>egyptian ] unit-test
{ { 1/2 1/8 } } [ 5/8 rational>egyptian ] unit-test
{ { 1/2 1/3 1/4 } } [ 13/12 rational>egyptian ] unit-test
{ {
    1/25
    1/757
    1/763309
    1/873960180913
    1/1527612795642093418846225
} } [ 5/121 rational>egyptian ] unit-test