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

ok !(12V == 12A);
exit;

my $voltage = 12V;
ok $voltage, "Yeah well, if this would fail, all hope were lost";
ok $voltage == 12, "I mean, it's just an int with a role";;
ok $voltage.si-name ~~ "volt", "Correct unit name";
ok $voltage.si-symbol ~~ "V", "Correct unit symbol";
ok "$voltage" ~~ "12V", "Voltage stringifies correctly";

my $current = 0.5A;
ok "$current" ~~ "0.5A", "Current stringifies correctly";

subtest {
   lives-ok {
     my $resistance = $voltage.divide( $current );

     ok $resistance == 24, "Impedance, correct result" ;
     ok "$resistance" ~~ "24Ω", "Impedance stringifies correctly";
   }, "Divide Voltage by Current lives";
}, "division by method";

subtest {
   lives-ok {
     my $resistance = $voltage / $current;
     ok $resistance == 24, "Impedance, correct result" ;
     ok "$resistance" ~~ "24Ω", "Impedance stringifies correctly";
   }, "Divide Voltage by Current lives";
}, "division by operator";

subtest {
  my $power   = $voltage.multiply( $current );
  ok $power == 6;
  ok "$power" ~~ "6W", "Power stringifies correctly";
}, "multiplication by method";

subtest {
  my $power   = $voltage * $current;
  ok $power == 6;
  ok "$power" ~~ "6W", "Power stringifies correctly (again)";;
}, "multiplication by operator";

subtest
{
  throws-like { $voltage.add( $current ) }, Exception, message => /:s Unit mismatch/;
  throws-like { $voltage + $current }, Exception, message => /:s Unit mismatch/;
}, "addition fails for different units";

subtest
{
  throws-like { $voltage.substract( $current ) }, Exception, message => /:s Unit mismatch/;
  throws-like { $voltage - $current }, Exception, message => /:s Unit mismatch/;
}, "subtraction fails for different units";

my $v1 = 12V;
my $v2 = 24V;

subtest
{
  my $x = $v1.add($v2);
  ok $x == 36;
  ok $x.si-name ~~ "volt";
  ok "$x" ~~ "36V";
};

subtest
{
  my $v3 = $v1 + $v2;
  ok "$v3" ~~ "36V";
  ok ($v1 + $v2).Str ~~ "36V";
};

#ok 12V == 12V;


#   my $x = 12V + 24V;
#
#   say "!!!", $x, ":$x", "-", $x.si-name;
#
#   #ok 12V + 24V == 36V, "V + V == V";
#   #ok 12V + 24V != 36A, "V + V != A";
# }, "bareness ahoi!";


done-testing;
