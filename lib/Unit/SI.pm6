use v6;

role Unit::SI[$signature]
{
  use Unit::SI::Definitions;

  has $.si-signature;

  submethod TWEAK {
    $!si-signature = $signature;
  }

  multi method Str {
    self.pretty-notation( 0 );
  }

  multi method Str( Int $size ) {
    self.pretty-notation( $size );
  }

  method gist {
    scientific-notation( self );
  }

  sub scientific-notation( $self ) {
    my $symbol = $self.si-symbol || $self.scientific-signature;
    # ( 0 + $self ) to avoid calling $self.Str
    return ( 0.0 + $self ) ~ "e" ~ $self.si-signature[0] ~  $symbol;
  }

  method pretty-notation( $size is copy ) {
    my $symbol = self.si-pretty-symbol($size) || self.pretty-signature($size);
    return self.si-value( $size ) ~ " " ~ $symbol;
  }

  method scientific-signature(Int $size = 0)
  {
    return "(" ~ self.pretty-signature($size) ~ ")";
  }
  
  method pretty-signature(Int $size = 0)
  {
    my @u = <n m kg s A K mol cd>;
    my $i = 0;
    my @p;
    my @n;

    for 1 .. 7 {
      if self.si-signature[$_] != 0 {
        if self.si-signature[$_] > 0 {
          if self.si-signature[$_] == 1 {
            @p.push( @u[$_] );
          }
          else {
            @p.push( @u[$_] ~ "**" ~ self.si-signature[$_] );
          }
        } else {
          if self.si-signature[$_] == -1 {
            @n.push( @u[$_] );
          }
          else {
            @n.push( @u[$_] ~ "**" ~ abs(self.si-signature[$_]) );
          }
        }
      }
    }

    return @p.join(" ") unless @n.elems;
    return @n.join(" ") unless @p.elems;
    return "{@p.join(" ")}/{@n.join(" ")}";
}

  method si-value( $size is copy ) {
    # ( 0 + $self ) to avoid calling $self.Str
    return (0.0 + self)
      * exp-fact(self, $size)
      * unit-idx-fact($size);
  }

  method si-pretty-symbol( $size is copy = 0 )
  {
    return self.symbol( 0, $size );
  }

  method si-symbol( $size is copy = 0 ) {
    return self.symbol( 1, $size );
  }

  method symbol( $unit-idx, $size is copy = 0,  )
  {
    if my $unit = self!find-unit[0][$unit-idx]
    {
      state @pdim = "", |<deca hecto kilo mega giga tera peta exa zetta yotta>;
      state @ndim = "", |<deci centi milli micro nano pico femto atto zepto yocto>;

      my $mod   =
        $size > 0 ?? @pdim[unit-idx($size)] !!
        $size < 0 ?? @ndim[unit-idx($size)] !!
        "";

      return $mod ~ $unit;
    }
  }

  method !find-unit {
      @UNITS.first({ self.signature-matches( $_[1] ) });
  }

  method si-name {
    return self!find-unit[0][0];
  }

  method si-pretty-name {
    return self!find-unit[0][1];
  }

  method calc( $value, &result, &uresult )
  {
    my $result = &result();

    my $unit   =
      $value.does( Unit::SI )
      ?? &uresult()
      !! self.si-signature;

    my $e = $unit[0];

    while $result.Int != $result && $++ < 20 {
      $result *= 10; $e--;
    }

    $unit[0] := $e;

    return $result does Unit::SI[ $unit ];
  }

  method divide( $value )
  {
    return self.calc( $value,
      { self / $value },
      { self.unit-divide( $value.si-signature ) }
    );
  }

  multi method multiply( $value )
  {
    return self.calc( $value,
      { self * $value },
      { self.unit-multiply( $value.si-signature ) }
    );
  }

  method add( Unit::SI $value )
  {
    die "Unit mismatch in expression {self.gist} [{self.si-signature}] + {$value.gist} [{$value.si-signature}]"
        unless self.signature-matches( $value.si-signature );

    my $result = self + $value;
    $result does Unit::SI[ self.unit-add( $value.si-signature ) ];
    return $result;
  }

  method substract( Unit::SI $value )
  {
    die "Unit mismatch in expression {self.gist} [{self.si-signature}] - {$value.gist} [{$value.si-signature}]"
        unless self.signature-matches( $value.si-signature );

    my $result = self - $value;
    return $result does Unit::SI[ [.unit-substract( $value.si-signature )] ];
  }

  method compare( Unit::SI $value )
  {
    die "Unit mismatch in expression {self.gist} [{self.si-signature}] - {$value.gist} [{$value.si-signature}]"
        unless self.signature-matches( $value.si-signature );

    my $s = self   * (10**self.si-signature[0]);
    my $v = $value * (10**$value.si-signature[0]);

    return $s < $v ?? -1 !!
           $s > $v ?? +1 !!
           0;
  }

  method smaller-than( Unit::SI $value ) {
    return self.compare($value) == -1;
  }

  method greater-than( Unit::SI $value ) {
    return self.compare($value) == 1;
  }

  method equals( Unit::SI $value ) {
    return self.compare($value) == 0;
  }

  method unit-divide( $signature ) {
    return @$.si-signature «-» @$signature;
  }

  method unit-multiply( $signature ) {
    return @$.si-signature «+» @$signature;
  }

  method unit-add( $signature ) {
    return $signature;
  }

  method unit-substract( $ignature ) {
    return $signature;
  }

  method signature-matches( $signature ) returns Bool {
    return @$.si-signature[1 .. *] ~~ @$signature[1 .. *];
  }

  sub unit-idx (Int $i) { return abs($i) if -3 < $i < 3;
    return 2 + (abs($i) / 3).Int;
  }

  sub exp-fact( $value is copy, $size )
  {
    my $exp-diff = $value.si-signature[0] - $size;
    return 10**$exp-diff;
  }

  sub unit-idx-fact(Int $i) {
    return 1 if -3 < $i < 3;
    return 10**($i % 3);
  }
}
