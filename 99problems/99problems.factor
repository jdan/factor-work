! Copyright (C) 2020 Jordan Scales.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences ;
IN: 99problems

! P01 (*) Find the last box of a list.
: my-last ( seq -- n/? )
  dup empty? [ f nip ] [ last ] if ;

! P02 (*) Find the last but one box of a list.
USING: math ;
: my-but-last ( seq -- seq/? )
  dup length 2 <
  [ f nip ]
  [ reverse 2 head reverse ]
  if ;

! P03 (*) Find the K'th element of a list.
: element-at ( seq n -- n/? )
  dup pick length >=
  [ f 2nip ]
  [ swap nth ]
  if ;

! P04 (*) Find the number of elements of a list.
: my-length ( seq -- n )
  dup empty?
  [ 0 nip ]
  [ rest my-length 1 + ]
  if ;

! P05 (*) Reverse a list.
: my-reverse ( seq -- seq )
  [ { } ]
  [ [ first ] [ rest ] bi my-reverse swap suffix ]
  if-empty ; ! neat, no need to `dup`

! P06 (*) Find out whether a list is a palindrome.
: palindrome? ( seq -- ? ) dup my-reverse = ;

! P07 (**) Flatten a nested list structure.
USING: arrays ;
: my-flatten ( seqseq -- seq )
  [ dup sequence? [ my-flatten ] [ 1array ] if ] map
  { } [ append ] reduce ;

! P08 (**) Eliminate consecutive duplicates of list elements.
: compress ( seq -- seq )
  { f { } } ! bit of an awkward data structure
  [ dup pick first =
    [ drop ]
    [ dup pick second swap suffix ! seq new-letter new-seq
      2array nip
    ]
    if
  ]
  reduce second ;

! P09 (**) Pack consecutive duplicates of list elements
! into sublists.
TUPLE: pack-state current run (result) ;
: <pack-state> ( -- state )
  f { } { } pack-state boa ;

USING: locals accessors ;
GENERIC: flush ( elt state -- state )
GENERIC: pack-one ( elt state -- state )

M:: pack-state flush ( elt state -- state )
  <pack-state>
    elt >>current
    { elt } >>run
    state [ (result)>> ] [ run>> ] bi suffix >>(result) ;

M:: pack-state pack-one ( elt state -- state )
  elt state current>> =
  [ state [ elt suffix ] change-run ]
  [ elt state flush ]
  if ;

! We'll define our own result>> accessor, since the
! internal (result) has an "off-by-one" in that the initial
! `{ }` run is pushed on the first flush.
!
! This custom accessor will appropriately discard it.
M: pack-state result>> ( state -- seq ) (result)>> 1 tail ;

: pack ( seq -- seqs )
  <pack-state> [ swap pack-one ] reduce
  f swap flush   ! flush the current run to the result
  result>> ;

! P10 (*) Run-length encoding of a list.
: encode ( seq -- run ) pack [ [ length ] [ first ] bi 2array ] map ;

! P11 (*) Modified run-length encoding.
: encode* ( seq -- run )
  pack
  [ dup length 1 =
    [ first ]
    [ [ length ] [ first ] bi 2array ]
    if
  ] map ;

! P12 (**) Decode a run-length encoded list.
USING: math.ranges ;
:: (repeat) ( n elt -- seq ) n [1,b] [ drop elt ] map ;

: decode ( run -- seq )
  [ dup sequence?
    [ [ first ] [ second ] bi (repeat) ]
    [ 1array ]
    if
  ] map my-flatten ;

! P13 (**) Run-length encoding of a list (direct solution).
TUPLE: encode-state current run (result) ;
: <encode-state> ( -- state )
  f 0 { } encode-state boa ;

M:: encode-state flush ( elt state -- state )
  <encode-state>
    elt >>current
    1 >>run
    state
      [ (result)>> ] [ run>> ] [ current>> ] tri
      over 1 =    ! kind of sus logic to change (1 A) -> A
      [ nip suffix ]
      [ 2array suffix ]
      if
    >>(result) ;

GENERIC: encode-one ( elt state -- state )
M:: encode-state encode-one ( elt state -- state )
  elt state current>> =
  [ state [ 1 + ] change-run ]
  [ elt state flush ]
  if ;

M: encode-state result>> ( state -- seq ) (result)>> 1 tail ;
: encode-direct ( seq -- seqs )
  <encode-state> [ swap encode-one ] reduce
  f swap flush
  result>> ;

! P14 (*) Duplicate the elements of a list.
:: dupli ( seq -- seq )
  seq
  [ { } ]
  [ first dup 2array
    seq rest dupli append
  ]
  if-empty ;

! P15 (**) Replicate the elements of a list a given number of times.
:: repli ( seq n -- seq )
  seq
  [| elt | n elt (repeat) ]
  map my-flatten ;

! P16 (**) Drop every N'th element from a list.
USING: sequences.extras ;
:: drop-nth ( seq n -- seq )
  seq
  [| elt i | i 1 + n mod 0 > ]
  filter-index ;  ! filter-index is a bit of a cop-out

:: (drop-nth*) ( seq n cur -- seq )
  seq
  [ { } ]
  [ cur 1 =
    [ rest n n (drop-nth*) ]
    [ rest n cur 1 - (drop-nth*)
      seq first
      prefix
    ]
    if
  ]
  if-empty ;

: drop-nth* ( seq n -- seq ) dup (drop-nth*) ;

! P17 (*) Split a list into two parts; the length of the first
! part is given.
:: (split) ( seq n acc -- seqs )
  n 0 =
  [ acc seq 2array ]
  [ seq rest
    n 1 -
    acc seq first suffix
    (split)
  ]
  if ;

: split ( seq n -- seqs ) { } (split) ;

! P18 (**) Extract a slice from a list.
:: drop-start ( seq n -- seq )
  n 0 =
  [ seq ]
  [ seq rest n 1 - drop-start ]
  if ;

:: take ( seq n -- seq )
  n 0 =
  [ { } ]
  [ seq rest n 1 - take
    seq first
    prefix
  ]
  if ;

:: slice ( seq a b -- seq )
  a 1 - :> start
  b a - 1 + :> end
  seq start drop-start end take ;

:: (rotate) ( seq n acc -- seq )
  n 0 =
  [ seq acc append ]
  [ seq rest
    n 1 -
    acc seq first suffix
    (rotate)
  ]
  if ;

! P19 (**) Rotate a list N places to the left.
:: rotate ( seq n -- seq )
  n 0 <
  [ seq dup length n + rotate ]
  [ seq n { } (rotate) ]
  if ;

! P20 (*) Remove the K'th element from a list.
:: remove-at ( seq n -- seq )
  n 1 =
  [ seq rest ]
  [ seq rest n 1 - remove-at
    seq first
    prefix
  ]
  if ;

! P21 (*) Insert an element at a given position
! into a list.
:: insert-at ( elt seq n -- seq )
  n 1 =
  [ seq elt prefix ]
  [ elt seq rest n 1 - insert-at
    seq first
    prefix
  ]
  if ;

! P22 (*) Create a list containing all integers
! within a given range.
:: range ( a b -- seq )   ! NOTE: this is just [a,b]
  a b =
  [ { b } ]
  [ a 1 + b range
    a
    prefix
  ]
  if ;

:: range* ( a b -- seq )
  a 1 - :> value!
  value
  [ value b < ]        ! need a mutable `value` to compare
  [ value 1 + dup value! ]  ! yield, and also update value
  produce nip ;

USING: random ;
! P23 (**) Extract a given number of randomly selected
! elements from a list.
: rnd-select ( seq n -- seq ) sample ;

! P24 (*) Lotto: Draw N different random numbers from
! the set 1..M.
:: lotto-select ( n m -- seq )
  n [1,b] :> ns
  m [1,b] :> ms
  ns [ drop ms random ] map ;

! P25 (*) Generate a random permutation of the elements
! of a list.
: rnd-permu ( seq -- seq ) dup length rnd-select ;

! P26 (**) Generate the combinations of K distinct objects
! chosen from the N elements of a list
:: all-combinations ( seq -- seqs )
  seq
  [ { { } } ]
  [ rest all-combinations :> rest*
    rest* [ seq first prefix ] map
    rest*
    append
  ]
  if-empty ;

:: combination ( n seq -- seqs )
  seq all-combinations [ length n = ] filter ;

! P27 (**) Group the elements of a set into disjoint subsets.
! meh... skipping this one

! P28 (**) Sorting a list of lists according to length
! of sublists
USING: sorting math.order ;
: lsort ( seq -- seq ) [ [ length ] bi@ <=> ] sort ;

! (b) Again, we suppose that a list contains elements that
! are lists themselves. But this time the objective is to
! sort the elements of this list according to their length
! frequency; i.e., in the default, where sorting is done
! ascendingly, lists with rare lengths are placed first,
! others with a more frequent length come later.
USING: assocs ;
:: lfsort ( seqs -- seqs )
  seqs [ length ] collect-by :> freq
  seqs [ [| seq | seq length freq at length ] bi@ <=> ] sort ;

: [2,b] ( n -- seq ) [1,b] rest ;

! P31 (**) Determine whether a given integer number is prime.
USING: math.functions ;
:: is-prime? ( n -- ? )
  n 1 =
  [ f ]
  [ n sqrt [2,b]
    [| elt | n elt mod 0 = ]
    none?
  ] if ;

! P32 (**) Determine the greatest common divisor of two positive
! integer numbers.
:: my-gcd ( a b -- n )
  b 0 =
  [ a ]
  [ b a b mod my-gcd ]
  if ;

! P33 (*) Determine whether two positive integer numbers
! are coprime.
: coprime? ( a b -- ? ) my-gcd 1 = ;

! P34 (**) Calculate Euler's totient function phi(m).
:: totient-phi ( n -- n )
  n [1,b) [| i | n i coprime? ] filter length ;

! P35 (**) Determine the prime factors of a given positive
! integer.
:: (prime-factors) ( n a -- seq )
  a n >
  [ { } ]
  [ n a mod 0 =
    [ n a / 2 (prime-factors)
      a
      prefix ]
    [ n a 1 + (prime-factors) ]
    if
  ]
  if ;

: prime-factors ( n -- seq ) 2 (prime-factors) ;

! P36 (**) Determine the prime factors of a given
! positive integer (2).
: prime-factors-mult ( n -- exps )
  prime-factors encode [ reverse ] map ;

! P37 (**) Calculate Euler's totient function phi(m) (improved).
: totient-phi* ( n -- n )
  dup
  prime-factors-mult
  [ first 1 swap recip - ] map
  1 [ * ] reduce
  * ;

! P38 (*) Compare the two methods of calculating Euler's totient
! function.
!
! [ 10090 totient-phi ] benchmark
!   1272700
! [ 10090 totient-phi* ] benchmark
!   27700

! P39 (*) A list of prime numbers.
: primes ( a b -- seq ) range [ is-prime? ] filter ;

! P40 (**) Goldbach's conjecture.
:: goldbach ( n -- pair )
  1 n primes :> ps
  2 ps combination
  [ [ first ] [ second ] bi + n = ] filter
  first ;