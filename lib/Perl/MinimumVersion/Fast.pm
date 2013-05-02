package Perl::MinimumVersion::Fast;
use 5.008005;
use strict;
use warnings;

use Compiler::Lexer;
use List::Util qw(max);

our $VERSION = "0.01";

my $MIN_VERSION = version->new('5.008');

sub new {
    my ($class, $stuff) = @_;

    my $filename;
    my $src;
    if (ref $stuff) {
        $filename = $stuff;
        open my $fh, '<', $stuff
            or die "Unknown file: $src";
        $src = do { local $/; <$fh> }; 
    } else {
        $filename = '-';
        $src = $stuff;
    }

    my $lexer = Compiler::Lexer->new($filename);
    my @tokens = $lexer->tokenize($src);
    bless {
        tokens => \@tokens,
    }, $class;
}

sub minimum_version {
    my $self = shift;
    my @tokens = map { @$$_ } @{$self->{tokens}};
    my $version = $MIN_VERSION;
    for my $i (0..@tokens-1) {
        my $token = $tokens[$i];
        if ($token->{name} eq 'ToDo') {
            $version = max($version, version->new('5.012'));
        } elsif ($token->{name} eq 'Package') {
            if (@tokens > $i+2) {
                my $number = $tokens[$i+2];
                if ($number->{name} eq 'Int' || $number->{name} eq 'Double' || $number->{name} eq 'Key') {
                    $version = max($version, version->new('5.012'));
                }
            }
        }
        warn $token->{name};
        # postfix when
    }
    return $version;
    use Data::Dumper; warn Dumper(\@tokens);
}

1;
__END__

=encoding utf-8

=head1 NAME

Perl::MinimumVersion::Fast - It's new $module

=head1 SYNOPSIS

    use Perl::MinimumVersion::Fast;

=head1 DESCRIPTION

Perl::MinimumVersion::Fast is ...

=head1 LICENSE

Copyright (C) tokuhirom.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

tokuhirom E<lt>tokuhirom@gmail.comE<gt>

=cut

