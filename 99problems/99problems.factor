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
:: flush ( state elt -- state )
  <pack-state>
    elt >>current
    { elt } >>run
    state [ (result)>> ] [ run>> ] bi suffix >>(result) ;

:: pack-one ( state elt -- state )
  elt state current>> =
  [ state [ elt suffix ] change-run ]
  [ state elt flush ]
  if ;

! We'll define our own result>> accessor, since the
! internal (result) has an "off-by-one" in that the initial
! `{ }` run is pushed on the first flush.
!
! This custom accessor will appropriately discard it.
M: pack-state result>> ( state -- seq ) (result)>> 1 tail ;

: pack ( seq -- seqs )
  <pack-state> [ pack-one ] reduce
  f flush   ! flush the current run to the result
  result>> ;