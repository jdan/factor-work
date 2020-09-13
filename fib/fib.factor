! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math ;
IN: fib

: fib' ( a b n -- a' b' n' )
  dup 0 =
  [ ]
  [ [ dup -rot + ]  ! a b -> b (a+b)
    dip
    1 - fib'
  ]
  if ;

: fib ( n -- n' )
  [ 0 1 ] dip fib' 2drop ;
