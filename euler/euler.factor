! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math math.functions sequences ;
IN: euler

! If we list all the natural numbers below 10 that
! are multiples of 3 or 5, we get 3, 5, 6 and 9. The
! sum of these multiples is 23.
!
! Find the sum of all the multiples of 3 or 5 below 1000.
USING: math.ranges ;
: euler1 ( n -- n )
  [1,b)
  [
    [ 3 divisor? ] [ 5 divisor? ] bi
    or
  ] filter
  0 [ + ] reduce ;

! Each new term in the Fibonacci sequence is generated
! by adding the previous two terms. By starting with 1
! and 2, the first 10 terms will be:
!
!   1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
!
! By considering the terms in the Fibonacci sequence
! whose values do not exceed four million, find the sum
! of the even-valued terms.
USING: accessors ;
TUPLE: fib-state a b ;
: next-fib ( state -- state' )
  [ a>> ] [ b>> ] bi
  swap over +
  fib-state boa ;

: euler2 ( n -- n )
  1 2 fib-state boa
  [ 2dup a>> > ]
  [ [ next-fib ] keep a>> ]
  produce 2nip
  [ even? ] filter
  sum ;

! The prime factors of 13195 are 5, 7, 13 and 29.
!
! What is the largest prime factor of the number
! 600851475143 ?
USING: math.primes.factors math.order ;
: euler3 ( n -- n ) factors 0 [ max ] reduce ;

! A palindromic number reads the same both ways.
! The largest palindrome made from the product of two
! 2-digit numbers is 9009 = 91 × 99.
!
! Find the largest palindrome made from the product of
! two 3-digit numbers.
USING: palindrome sequences.product arrays math.parser ;
: euler4 ( max -- palindrome )
  dup [ [1,b] ] bi@ 2array
  <product-sequence> >array
  [ product ] map
  [ number>string dup reverse = ] filter
  0 [ max ] reduce ;

! 2520 is the smallest number that can be divided by
! each of the numbers from 1 to 10 without any remainder.
!
! What is the smallest positive number that is evenly
! divisible by all of the numbers from 1 to 20?
: euler5 ( max -- n ) [1,b] 1 [ lcm ] reduce ;
