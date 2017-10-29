
unit module Unit::SI::Operators;

use Unit::SI;

multi sub infix:«<»(Unit::SI $a, Unit::SI $b)
is export
is default
returns Bool { $a.smaller-than($b) }

multi sub infix:«>»(Unit::SI $a, Unit::SI $b)
is export
is default
returns Bool { $a.greater-than($b) }

multi sub infix:<==>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Bool { $a.equals($b) }

multi sub infix:<!=>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Bool { !$a.equals($b) }

multi sub infix:<*>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI { $a.multiply($b) }

multi sub infix:</>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI { $a.divide($b) }

multi sub infix:<+>(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI { $a.add($b) }

multi sub infix:<->(Unit::SI $a, Unit::SI $b)
is export
is default
returns Unit::SI { $a.substract($b) }
