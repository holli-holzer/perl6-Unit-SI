use v6;
#`(
Copyright ©  holli.holzer@gmail.com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

)
use Test;
use Unit::SI;

use Unit::SI::Symbols;
use Unit::SI::Operators;

my $voltage = 12V;
ok $voltage, "Yeah well, if this would fail, all hope were lost";
ok $voltage.si-name ~~ "volt", "Correct unit name";
ok $voltage.si-symbol ~~ "V", "Correct unit symbol";
ok $voltage.gist ~~ "12e0V", "Voltage stringifies correctly";

my $current = 0.5A;
ok $current.gist ~~ "5e-1A", "Current gistifies correctly";

my $current2 = 0.05A;
ok $current2.gist ~~ "5e-2A", "Current gistifies correctly";

my $current3 = 12300000A;
ok $current3.gist ~~ "12300000e0A", "Current gistifies correctly";

ok $current.gist ~~ "5e-1A", "Current gistifies correctly!";
#todo
#my $current4 = 123000A;
#ok $current4.gist ~~ "-1.23e5A", "Current gistifies correctly";

subtest {
   lives-ok {
     my $resistance = $voltage.divide( $current );
     ok $resistance.gist ~~ "24e0Ω", "Impedance, correct result" ;
   }, "Divide Voltage by Current lives";
}, "division by method";

subtest {
   lives-ok {
     my $resistance = $voltage / $current;
     ok $resistance.gist ~~ "24e0Ω", "Impedance, correct result" ;
   }, "Divide Voltage by Current lives";
}, "division by operator";


subtest {
  my $power   = $voltage.multiply( $current );
  ok $power.gist ~~ "60e-1W", "Power stringifies correctly";
}, "multiplication by method";

subtest {
  my $power   = $voltage * $current;
  ok $power.gist ~~ "60e-1W", "Power stringifies correctly";
}, "multiplication by operator";

subtest
{
  throws-like { $voltage.add( $current ) }, Exception, message => /:s Unit mismatch/, "dies as expected";
  throws-like { $voltage + $current }, Exception, message => /:s Unit mismatch/, "dies as expected";
}, "addition fails for different units";

subtest
{
  throws-like { $voltage.substract( $current ) }, Exception, message => /:s Unit mismatch/, "dies as expected";
  throws-like { $voltage - $current }, Exception, message => /:s Unit mismatch/, "dies as expected";
}, "subtraction fails for different units";

subtest {
  ok 12V == 12V, "12V == 12V";
  ok !(12V == 14V), "!(12V == 14V)";
  throws-like { 12V == 12A }, Exception, message => /:s Unit mismatch/, "dies as expected";
}, "equality";


subtest {
  ok !(12V != 12V), "!(12V != 12V)";
  ok 12V != 14V, "12V != 14V";
  throws-like { 12V != 15A }, Exception, message => /:s Unit mismatch/, "dies as expected";
}, "inequality";

subtest {
  ok -12V < 10V, "-12V < 10V";
  ok -12V == 12V * -1n, "multiply by -n";
  ok (-12V).gist ~~ "-12e0V", "negative value gistifies correctly";
}, "negativity";

subtest {
  ok 12V < 24V, "12V < 24V";
  ok 24V > 12V, "24V > 12V";
  ok !(12V > 24V), "!(12V > 24V)";
  ok !(24V < 12V), "!(24V < 12V)";
  throws-like { 12V < 15A }, Exception, message => /:s Unit mismatch/, "dies as expected";
  throws-like { 12V > 15A }, Exception, message => /:s Unit mismatch/, "dies as expected";
}, "smaller / bigger";

subtest {
  ok (2n * 12V).gist ~~ "24e0V", "multiplication by n";
  throws-like { 12V + 2n }, Exception, message => /:s Unit mismatch/, "n doesnt add";
  pass;
}, "n";

subtest {
  my $speed    = 100㎧;
  my $distance = -1000m;
  my $time     = $distance / $speed;

  ok $time.gist ~~ "-10e0s", "time gistifies correctly";
  ok 1000m / -100㎧ == -10s, "time correct";
}, "time and speed";

subtest
{
  ok (1200V).Str(3) ~~ "1.2 kilovolt", "kiloVolt";
  ok (1200V).Str(2) ~~ "12 hectovolt", "hectoVolt";
  ok (1200V).Str(1) ~~ "120 decavolt", "decaVolt";
  ok (1200V).Str(0) ~~ "1200 volt", "Volt";
  ok (1200V).Str(-1) ~~ "12000 decivolt", "deciVolt";
  ok (1200V).Str(-2) ~~ "120000 centivolt", "centiVolt";
  ok (1200V).Str(-3) ~~ "1200000 millivolt", "milliVolt";
}, "n>1 pretty-notation, > x > 1";

subtest
{
  ok (0.0012V).Str(3) ~~ "0.0000012 kilovolt", "kiloVolt";
  ok (0.0012V).Str(2) ~~ "0.000012 hectovolt", "hectoVolt";
  ok (0.0012V).Str(1) ~~ "0.00012 decavolt", "decaVolt";
  ok (0.0012V).Str(0) ~~ "0.0012 volt", "Volt";
  ok (0.0012V).Str(-1) ~~ "0.012 decivolt", "deciVolt";
  ok (0.0012V).Str(-2) ~~ "0.12 centivolt", "centiVolt";
  ok (0.0012V).Str(-3) ~~ "1.2 millivolt", "milliVolt";
}, "n>1 pretty-notation, 0 < x < 1";

subtest
{
  ok (-0.0012V).Str(3) ~~ "-0.0000012 kilovolt", "kiloVolt";
  ok (-0.0012V).Str(0) ~~ "-0.0012 volt", "Volt";
  ok (-0.0012V).Str(-3) ~~ "-1.2 millivolt", "milliVolt";
}, "n>1 pretty-notation,  x < 0";

subtest
{
  ok (1200000V).Str(6) ~~ "1.2 megavolt";
  ok (1200000V).Str(4) ~~ "1200 kilovolt";
  ok (1200000V).Str(3) ~~ "1200 kilovolt";
  ok (120000V).Str(6)  ~~ "0.12 megavolt", "megaVolt";
  ok (12000V).Str(5)   ~~ "12 kilovolt", "kiloVolt";
  ok (1200V).Str(4)    ~~ "1.2 kilovolt", "kiloVolt";
  ok (120V).Str(3)     ~~ "0.12 kilovolt", "kiloVolt";
}, "mega, giga, etc";

subtest
{
  my $mole = 12mol;
  my $candela = 100cd;
  my $something = $mole / $candela;

  ok $something.gist ~~ "12e-2(mol/cd)";
  ok $something.Str ~~ "0.12 mol/cd";
}, "something";

subtest
{
  my $m = 10000g;
  say $m.gist;
  say $m.Str(0);
  say $m.Str(1);
  say $m.Str(2);
  say $m.Str(3);
  say $m.Str(4);
}

done-testing;
