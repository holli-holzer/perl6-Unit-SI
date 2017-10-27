
unit module Unit::SI::Operators;

use Unit::SI;

multi sub infix:<*>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI {
  my $v = callwith( $a, $b );
  $v does Unit::SI[ [$a.unit-multiply( $b.si-signature )] ];
}

multi sub infix:<==>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Bool {
  say "== $a, $b";
  return callwith( $a, $b ) && $a.signature-matches( $b.si-signature );
}

multi sub infix:</>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI {
  my $v = callwith( $a, $b );
  $v does Unit::SI[ [$a.unit-divide( $b.si-signature )] ];
}

multi sub infix:<+>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI {
  #say <$a>, $a.si-signature;
  #say <$b>, $b.si-signature;
  my $v = callwith( $a, $b ) does Unit::SI[ $a.unit-add( $b.si-signature ) ];
  #say "OP > $v ", $v.si-signature;
  return $v;
}

multi sub infix:<->(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI {
  my $v = callwith( $a, $b );
  $v does Unit::SI[ [$a.unit-add( $b.si-signature )] ];
}
