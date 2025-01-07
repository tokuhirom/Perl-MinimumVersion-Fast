use strict;
use warnings;
use Test::More;

use Perl::MinimumVersion::Fast;

my $p = Perl::MinimumVersion::Fast->new(\'-e -f -s ".exrc" and print "1\n"');
is($p->minimum_version, '5.010');

done_testing;
