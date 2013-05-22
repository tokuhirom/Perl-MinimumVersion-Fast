# NAME

Perl::MinimumVersion::Fast - Find a minimum required version of perl for Perl code

# SYNOPSIS

    use Perl::MinimumVersion::Fast;

    my $p = Perl::MinimumVersion::Fast->new($filename);
    print $p->minimum_version, "\n";

# DESCRIPTION

"Perl::MinimumVersion::Fast" takes Perl source code and calculates the minimum
version of perl required to be able to run it. Because it is based on PPI,
it can do this without having to actually load the code.

Perl::MinimumVersion::Fast is alternative implementation of Perl::MinimumVersion.

It's based on goccy's [Compiler::Lexer](http://search.cpan.org/perldoc?Compiler::Lexer).

This module supports only Perl 5.8.1+.
If you want to support __Perl 5.6__, use [Perl::MinimumVersion](http://search.cpan.org/perldoc?Perl::MinimumVersion) instead.

In 2013, you don't need to support Perl 5.6 in most of case.

# METHODS

- my $p = Perl::MinimumVersion::Fast->new($filename);
- my $p = Perl::MinimumVersion::Fast->new(\\$src);

    Create new instance. You can create object from `$filename` and `\$src` in string.

- $p->minimum\_version();

    Get a minimum perl version the code required.

# BENCHMARK

Perl::MinimumVersion::Fast is faster than Perl::MinimumVersion.
Because Perl::MinimumVersion::Fast uses [Compiler::Lexer](http://search.cpan.org/perldoc?Compiler::Lexer), that is a Perl5 lexer implemented in C++.
And Perl::MinimumVersion::Fast omits some features implemented in Perl::MinimumVersion.

But, but, [Perl::MinimumVersion::Fast](http://search.cpan.org/perldoc?Perl::MinimumVersion::Fast) is really fast.

                                Rate Perl::MinimumVersion Perl::MinimumVersion::Fast
    Perl::MinimumVersion       5.26/s                   --                       -97%
    Perl::MinimumVersion::Fast  182/s                3365%                         --

# LICENSE

Copyright (C) tokuhirom.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

tokuhirom <tokuhirom@gmail.com>

# SEE ALSO

This module using [Compiler::Lexer](http://search.cpan.org/perldoc?Compiler::Lexer) as a lexer for Perl5 code.

This module is inspired from [Perl::MinimumVersion](http://search.cpan.org/perldoc?Perl::MinimumVersion).
