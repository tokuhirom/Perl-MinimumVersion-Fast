# NAME

Perl::MinimumVersion::Fast - It's new $module

# SYNOPSIS

    use Perl::MinimumVersion::Fast;

    my $p = Perl::MinimumVersion::Fast->new($filename);
    print $p->minimum_version, "\n";

# DESCRIPTION

Perl::MinimumVersion::Fast is alternativee implemntation of Perl::MinimumVersion.

It's based on goccy's [Compiler::Lexer](http://search.cpan.org/perldoc?Compiler::Lexer).

This module detects features only supported on __Perl 5.10+__ like _given_, _when_.
If you want to support __Perl 5.6__, use [Perl::MinimumVersion](http://search.cpan.org/perldoc?Perl::MinimumVersion) instead.

# METHODS

- my $p = Perl::MinimumVersion::Fast->new($filename);
- my $p = Perl::MinimumVersion::Fast->new(\\$filename);

    Create new instance. You can create object from `$filename` and `\$src` in string.

- $p->minimum\_version();

    Get a minimum perl version the code required.

# LICENSE

Copyright (C) tokuhirom.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

tokuhirom <tokuhirom@gmail.com>

# SEE ALSO

[Compiler::Lexer](http://search.cpan.org/perldoc?Compiler::Lexer), [Perl::MinimumVersion](http://search.cpan.org/perldoc?Perl::MinimumVersion)
