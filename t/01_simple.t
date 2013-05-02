use strict;
use warnings;
use utf8;
use Test::More;

use Perl::MinimumVersion::Fast;

for (
    [\'...', '5.012'],
    ['package Foo', '5.008'],
    ['package Foo;', '5.008'],
    ['package Foo 3 { }', '5.012'],
    ['package Foo 3', '5.012'],
    ['package Foo 3.14 { }', '5.012'],
    ['package Foo v0.0.1 { }', '5.012'],
    ['require mro', '5.010'],
    ['use mro', '5.010'],
    ['use feature', '5.010'],
    ['require feature', '5.010'],
    ['use Data::Dumper', '5.008'],
) {
    my ($src, $version) = @$_;
    my $p = Perl::MinimumVersion::Fast->new($src);
    is($p->minimum_version, $version);
}

done_testing;

