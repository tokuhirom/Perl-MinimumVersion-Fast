use strict;
use warnings;
use Test::More;

use Perl::MinimumVersion::Fast;

my $p = Perl::MinimumVersion::Fast->new(\'10 < $a < 40 and exit 0');
is($p->minimum_version, '5.032');

done_testing;
