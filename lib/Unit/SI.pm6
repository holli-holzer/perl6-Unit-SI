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
    my $symbol = $self.si-symbol;
    # ( 0 + $self ) to avoid calling $self.Str
    return ( 0.0 + $self ) ~ "e" ~ $self.si-signature[0] ~  $symbol;
  }

  my @pdim = "", |<deca hecto kilo mega giga tera peta exa zetta yotta>;
  my @ndim = "", |<deci centi milli micro nano pico femto atto zepto yocto>;

  method pretty-notation( $size )
  {
    my $self     = (0.0 + self);
    #say "!pretty-notation! $self";
    my $exp      = self.si-signature[0];
    my $exp-diff = $exp - $size;


    my $value = $self * (10**$exp-diff);
    #say "$self $exp $size $exp-diff -> $value ";
    my $mod   =
      $size > 0 ?? @pdim[$size] !!
      $size < 0 ?? @ndim[abs($size)] !!
      "";

    return $value  ~ $mod ~ self.si-symbol;
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

    # say "C1 ", self;
    # say "C2 ", $value;

    my $s = self   * (10**self.si-signature[0]);
    my $v = $value * (10**$value.si-signature[0]);

    # say "C1A ", $s;
    # say "C2A ", $v;

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
    # say "*1* ", "-", @$.si-signature;
    # say "*2* ", @$signature;
    # say "--1 ", 0 - 0;
    # say "--2 ", (0+@$.si-signature[0]) - (0+@$signature[0]);
    # say "--3 ", 0+@$.si-signature[0];
    # say "--4",  @$signature[0].WHAT;
    # say "--5 ", @$signature[0].perl;
    # say "--5 ", @$signature[0].perl.WHAT;
    my @r = @$.si-signature «-» @$signature;
    #say "*3* ", @r;
    return @r;
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
}
