#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;

use Perl::MinimumVersion;
use Perl::MinimumVersion::Fast;
use Benchmark qw(cmpthese);

my $filename = 't/sample/Padre-SVN.pm';

my $c1 = sub {
    my $p = Perl::MinimumVersion::Fast->new($filename);
    $p->minimum_version();
};

my $c2 = sub {
    my $p = Perl::MinimumVersion->new($filename);
    $p->minimum_version();
};

cmpthese(
    -1 => {
        'Perl::MinimumVersion::Fast' => $c1,
        'Perl::MinimumVersion' => $c2,
    },
);

