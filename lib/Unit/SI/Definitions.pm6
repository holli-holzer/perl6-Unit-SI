module Unit::SI::Definitions
{
  # [Q] = 10n·mα·kgβ·sγ·Aδ·Kε·molζ·cdη
  our @UNITS is export;
  our %UNITS is export;

  INIT {
    say "----------- INIT -------------";
    @UNITS =  #       10n·  m· kg·  s·  A  ·K·  mol·cd
      [ <n n>,         [  0,  0,  0,  0,  0,  0,  0,  0] ],
      [ <metre m>,     [  0,  1,  0,  0,  0,  0,  0,  0] ],
      [ <gram g>,      [  0,  0,  1,  0,  0,  0,  0,  0] ],
      [ <second s>,    [  0,  0,  0,  1,  0,  0,  0,  0] ],
      [ <meter/second ㎧>, [  0,  1,  0,  -1,  0,  0,  0,  0] ],
      [ <meter/second² ㎨>, [  0,  1,  0,  -1,  0,  0,  0,  0] ],
      [ <ampere A>,    [  0,  0,  0,  0,  1,  0,  0,  0] ],
      [ <kelvin K>,    [  0,  0,  0,  0,  0,  1,  0,  0] ],
      [ <mole mol>,    [  0,  0,  0,  0,  0,  0,  1,  0] ],
      [ <candela cd>,  [  0,  0,  0,  0,  0,  0,  0,  1] ],
      [ <hertz Hz >,   [  0,  0,  0, −1,  0,  0,  0,  0] ],
      [ <newton N >,   [  0,  1,  1, -2,  0,  0,  0,  0] ],
      [ <pascal Pa>,   [  0, -1,  1, -2,  0,  0,  0,  0] ], #"N/m2"
      [ <joule J>,     [  0,  2,  1, -2,  0,  0,  0,  0] ], #[N·m]
      [ <watt W>,      [  0,  2,  1, −3,  0,  0,  0,  0] ], #[J/s]
      [ <coulomb C>,   [  0,  0,  0,  1,  1,  0,  0,  0] ],
      [ <volt V>,      [  0,  2,  1, -3, -1,  0,  0,  0] ], #[W/A
      [ <farad F>,     [  0, -2, -1,  4,  2,  0,  0,  0] ], #[C/V
      [ <ohm Ω>,       [  0,  2,  1, −3, −2,  0,  0,  0] ], #[V/A]
      [ <siemens S>,   [  0, -2, -1,  3,  2,  0,  0,  0] ], #[A/V]
      [ <weber Wb>,    [  0,  2,  1, −2, −1,  0,  0,  0] ], #[V·s]
      [ <tesla T>,     [  0,  0,  1, −2, −1,  0,  0,  0] ], #[Wb/m2]
      [ <henry H>,     [  0,  2,  1, −2, −2,  0,  0,  0] ], #[Wb/A]
      [ <sievert Sv>,  [  0,  2,  0, −2,  0,  0,  0,  0] ], #[J/kg]
      [ <katal kat>,   [  0,  0,  0, -1,  0,  0,  1,  0] ],
    ;

    for @UNITS -> $unit
    {
      my %u =
        name      => $unit[0][0],
        symbol    => $unit[0][1],
        signature => $unit[1],
      ;

      %UNITS{ $unit[0][0] } = %u;
    }
  }
}
