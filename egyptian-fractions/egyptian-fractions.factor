! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math math.functions math.order sequences ;
IN: egyptian-fractions

USING: locals ;
:: greedy-next ( min-d r -- min-d' r' next )
  ! grab the smallest denominator we can
  r recip ceiling min-d max
  [ 1 + ]             ! new min-d
  [ r swap recip - ]  ! updated fraction
  [ recip ]           ! the next unit frac in the seq
  tri ;

: rational>egyptian ( r -- seq )
  2 swap
  [ dup 0 > ]
  [ greedy-next ]
  produce 2nip ;