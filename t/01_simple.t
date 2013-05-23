use strict;
use warnings;
use utf8;
use Test::More;

use Perl::MinimumVersion::Fast;

diag "Compiler::Lexer: $Compiler::Lexer::VERSION";

note '--- minimum_version';
for (
    ['...', '5.012'],
    ['package Foo', '5.008'],
    ['package Foo;', '5.008'],
    ['package Foo 3', '5.012'],
    ['package Foo 3.14', '5.012'],
    ['package Foo 3.14_01', '5.012'],
    # ↓ Compiler::Lexer 0.05 can't parse this.
#   ['package Foo v0.0.1', '5.012'],
    ['package Foo { }', '5.014'],
    ['package Foo 3 { }', '5.014'],
    ['package Foo 3.14 { }', '5.014'],
    ['package Foo v0.0.1 { }', '5.014'],
    ['package Foo; { }', '5.008'],
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
    [q!use 5.010_001!, '5.010_001'],
) {
    my ($src, $version) = @$_;
    my $p = Perl::MinimumVersion::Fast->new(\$src);
    is($p->minimum_version, $version, $src);
    dump_version_markers($p);
}

subtest 'minimum_explict_version/minimum_syntax_version' => sub {
    for (
        # code                 explict      syntax
        [q!use     5.010_001!, '5.010_001', '5.008'],
        [q!require 5.010_001!, '5.010_001', '5.008'],
        ['...',                undef,       '5.012'],
    ) {
        my ($src, $explicit_version, $syntax_version) = @$_;
        my $p = Perl::MinimumVersion::Fast->new(\$src);
        is($p->minimum_explicit_version, $explicit_version, "$src - explicit");
        is($p->minimum_syntax_version,   $syntax_version,   "$src - syntax");
    }
};

subtest 'version markers' => sub {
    {
        my $p = Perl::MinimumVersion::Fast->new(\'use 5.010_001');
        is_deeply(
            [$p->version_markers], [
                '5.010_001' => [
                    'explicit',
                ],
            ],
        );
    }

    {
        my $p = Perl::MinimumVersion::Fast->new(\'...');
        is_deeply(
            [$p->version_markers], [
                '5.012' => [
                    'yada-yada-yada operator(...)',
                ],
            ],
        );
    }
};

done_testing;

sub dump_version_markers {
    my $p = shift;
    my @rv = $p->version_markers;
    for (my $i=0; $i<@rv; $i+=2) {
        note $rv[$i] . ":\n" . join("\n", map { "  - $_" } @{$rv[$i+1]});
    }
}
