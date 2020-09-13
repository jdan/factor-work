! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test euler ;
IN: euler.tests

{ 23 } [ 10 euler1 ] unit-test
{ 233168 } [ 1000 euler1 ] unit-test

{ 44 } [ 100 euler2 ] unit-test
{ 4613732 } [ 4000000 euler2 ] unit-test

{ 29 } [ 13195 euler3 ] unit-test
{ 6857 } [ 600851475143 euler3 ] unit-test

{ 9009 } [ 99 euler4 ] unit-test
{ 906609 } [ 999 euler4 ] unit-test

{ 2520 } [ 10 euler5 ] unit-test
{ 232792560 } [ 20 euler5 ] unit-test
{ 232792560 } [ 21 euler5 ] unit-test
{ 2329089562800 } [ 30 euler5 ] unit-test
{ 69720375229712477164533808935312303556800 }
[ 100 euler5 ] unit-test