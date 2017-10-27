use v6;

role Unit::SI[$signature]
{
  use Unit::SI::Definitions;

  has $.si-signature;

  submethod TWEAK
  {
    $!si-signature = $signature;
  }

  method Str {
    my $symbol = self.si-symbol;
    my $value  = callsame();
    return $value.ends-with($symbol) ?? $value !! $value ~ $symbol;
  }


  method !find-unit {
      @UNITS.first({ self.signature-matches( $_[1] ) });
  }

  method si-name {
    return self!find-unit[0][0];
  }

  method si-symbol {
    return self!find-unit[0][1];
  }

  method divide( Unit::SI $value )
  {
    my $result = self / $value;
    return $result does Unit::SI[ [self.unit-divide( $value.si-signature )] ];
  }

  method multiply( Unit::SI $value )
  {
    my $result = self * $value;
    return $result does Unit::SI[ [self.unit-multiply( $value.si-signature )] ];
  }

  method add( Unit::SI $value )
  {
    say "M ADD1";

    die "Unit mismatch in expression {self} [{self.si-signature}] + $value [{$value.si-signature}]"
        unless self.signature-matches( $value.si-signature );

    say "M ADD2";
    my $result = self + $value;
    say "M ADD3 $result";
    $result does Unit::SI[ self.unit-add( $value.si-signature ) ];
    say "M ADD4", $result.WHAT, $result.si-signature, $result.si-name;
    return $result;
  }

  method substract( Unit::SI $value )
  {
    die "Unit mismatch in expression {self} [{self.si-signature}] - $value [{$value.si-signature}]"
        unless self.signature-matches( $value.si-signature );

    my $result = self - $value;
    return $result does Unit::SI[ [.unit-substract( $value.si-signature )] ];
  }

  method unit-divide( $signature ) {
    return @$.si-signature «-» @$signature;
  }

  method unit-multiply( $signature ) {
    return @$.si-signature «+» @$signature;
  }

  method unit-add( $signature )
  {
    die "Unit mismatch in expression [{self.si-signature}] + [$signature]"
        unless self.signature-matches( $signature );

    return $signature;
  }

  method unit-substract( $ignature ) {
    die "Unit mismatch in expression [{self.si-signature}] - [$signature]"
        unless self.signature-matches( $signature );

    return $signature;
  }

  method signature-matches( $signature ) returns Bool {
    return @$.si-signature ~~ @$signature;
  }
}
