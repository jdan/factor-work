! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences unicode ;
IN: palindrome

: normalize ( string -- string' )
  [ Letter? ] filter >lower ;

: palindrome? ( string -- ? )
  normalize dup reverse = ;