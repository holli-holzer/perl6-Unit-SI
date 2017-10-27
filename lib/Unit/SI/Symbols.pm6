unit module Unit::SI::Symbols;

use Unit::SI;
use Unit::SI::Definitions;

#is tighter(&[,])
sub postfix:<m> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<metre><signature> ] );
};


#[ <kilogram kg>, [  0,  0,  1,  0,  0,  0,  0,  0] ],
sub postfix:<kg> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<kilogram><signature> ] );
};


# [ <second s>,    [  0,  0,  0,  1,  0,  0,  0,  0] ],
sub postfix:<s> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<second><signature> ] );
};

# [ <ampere A>,    [  0,  0,  0,  0,  1,  0,  0,  0] ],
sub postfix:<A> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<ampere><signature> ] );
};

# [ <kelvin K>,    [  0,  0,  0,  0,  0,  1,  0,  0] ],
sub postfix:<K> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<kelvin><signature> ] );
};

# [ <mole mol>,    [  0,  0,  0,  0,  0,  0,  1,  0] ],
sub postfix:<mol> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<mole><signature> ] );
};

# [ <candela cd>,  [  0,  0,  0,  0,  0,  0,  0,  1] ],
sub postfix:<cd> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<candela><signature> ] );
};

# [ <hertz Hz >,   [  0,  0,  0, −1,  0,  0,  0,  0] ],
sub postfix:<Hz> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<hertz><signature> ] );
};

# [ <newton N >,   [  0,  1,  1, -2,  0,  0,  0,  0] ],
sub postfix:<N> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<newton><signature> ] );
};

# [ <pascal Pa>,   [  0, -1,  1, -2,  0,  0,  0,  0] ], #"N/m2"
sub postfix:<Pa> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<pascal><signature> ] );
};

# [ <joule J>,     [  0,  2,  1, -2,  0,  0,  0,  0] ], #[N·m]
sub postfix:<J> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<joule><signature> ] );
};

# [ <watt W>,      [  0,  2,  1, −3,  0,  0,  0,  0] ], #[J/s]
sub postfix:<W> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<watt><signature> ] );
};

# [ <coulomb C>,   [  0,  0,  0,  1,  1,  0,  0,  0] ],
sub postfix:<C> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<coulomb><signature> ] );
};

# [ <volt V>,      [  0,  2,  1, -3, -1,  0,  0,  0] ], #[W/A
sub postfix:<V> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<volt><signature> ] );
};

# [ <farad F>,     [  0, -2, -1,  4,  2,  0,  0,  0] ], #[C/V
sub postfix:<F> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<farad><signature> ] );
};

# [ <ohm Ω>,       [  0,  2,  1, −3, −2,  0,  0,  0] ], #[V/A]
sub postfix:<Ω> ($value) returns Unit::SI is export {
  return $value does Unit::SI[ %UNITS<ohm><signature> ];
};

# [ <siemens S>,   [  0, -2, -1,  3,  2,  0,  0,  0] ], #[A/V]
sub postfix:<S> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<siemens><signature> ] );
};

# [ <weber Wb>,    [  0,  2,  1, −2, −1,  0,  0,  0] ], #[V·s]
sub postfix:<Wb> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<weber><signature> ] );
};

# [ <tesla T>,     [  0,  0,  1, −2, −1,  0,  0,  0] ], #[Wb/m2]
sub postfix:<T> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<tesla><signature> ] );
};

# [ <henry H>,     [  0,  2,  1, −2, −2,  0,  0,  0] ], #[Wb/A]
sub postfix:<H> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<henry><signature> ] );
};

# [ <sievert Sv>,  [  0,  2,  0, −2,  0,  0,  0,  0] ], #[J/kg]
sub postfix:<Sv> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<sievert><signature> ] );
};

# [ <katal kat>,   [  0,  0,  0, -1,  0,  0,  1,  0] ],
sub postfix:<kat> ($value) returns Unit::SI is export {
  return $value does( Unit::SI[ %UNITS<katal><signature> ] );
};

#[ <lumen lm>,    [] ,[cd·sr], [cd
# <lux	lx>, [lm/m2]>, [m−2·cd]
#[ <becquerel	Bq>, [s−1
#[ <gray	Gy>, [J/kg], [m2·s−2]
#[ <katal	kat>, [mol·s−1],
#[ <degree-celsius	°C	temperature relative to 273.15 K		K
;
