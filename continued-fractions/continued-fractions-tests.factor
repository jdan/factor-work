! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test math continued-fractions ;
IN: continued-fractions.tests

{ 3 } [ { 3 } eval ] unit-test
{ 4+3/10 } [ { 1 2 3 4 } eval ] unit-test

{ { 3 } } [ 1 8frac ] unit-test
{ { -6 3 } } [ 2 8frac ] unit-test
{ { 6 -6 6 -6 6 -6 6 -6 3 } } [ 9 8frac ] unit-test
{ { } } [ 0 8frac ] unit-test

{ { 2 } } [ 1 8frac' ] unit-test
{ { 1 2 } } [ 2 8frac' ] unit-test
{ { 4 1 4 1 4 1 4 1 2 } } [ 9 8frac' ] unit-test
{ { } } [ 0 8frac' ] unit-test

{ { { 3 1 } } } [ 1 8pell ] unit-test
{ { { 3 1 } { 17 6 } } } [ 2 8pell ] unit-test
{ { { 3 1 }
    { 17 6 }
    { 99 35 }
    { 577 204 }
} } [ 4 8pell ] unit-test

{ { { 1 1 }
    { 8 6 }
    { 49 35 }
    { 288 204 }
    { 1681 1189 }
    { 9800 6930 }
    { 57121 40391 }
    { 332928 235416 }
    { 1940449 1372105 }
    { 11309768 7997214 }
} } [ 10 houses ] unit-test