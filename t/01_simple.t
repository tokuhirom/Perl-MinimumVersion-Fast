use strict;
use warnings;
use utf8;
use Test::More;

use Perl::MinimumVersion::Fast;

for (
    ['...', '5.012'],
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
    ['require Data::Dumper', '5.008'],
    ['require strict', '5.008'],
    ['use strict', '5.008'],
    ['use 5', '5.008'],
    ['require 5', '5.008'],
    ['1 // 2', '5.010'],
    ['1 ~~ 2', '5.010'],
    ['$x //= 2', '5.010'],
    ['%+', '5.010'],
    ['$+{"a"}', '5.010'],
    ['@+{"a"}', '5.010'],
    ['warn %-', '5.010'],
    ['$-{"a"}', '5.010'],
    ['@-{"a"}', '5.010'],
    ['when (1) {}', '5.010'],
    ['when ([1,2,3]) {}', '5.010'],
    [q{print "$_," when [1,2,3];}, '5.012'],
    [q{print "$_," when([1,2,3]);}, '5.012'],
    [q{print "$_," when 1}, '5.012'],
    [q!warn; when (1) { }!, '5.010'],
    [q!use 5.010!, '5.010'],
    [q!use 5.010_001!, '5.010001'],
) {
    my ($src, $version) = @$_;
    my $p = Perl::MinimumVersion::Fast->new(\$src);
    is($p->minimum_version, $version, $src);
}

done_testing;

