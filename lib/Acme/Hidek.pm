package Acme::Hidek;

use 5.008_001;
use Mouse;
use Time::Piece;

our $VERSION = '0.0001';

#use XSLoader;
#XSLoader::load(__PACKAGE__, $VERSION);

use constant {
    BIRTH_YEAR  => 1970,
    BIRTH_MONTH => 9,
    BIRTH_DAY   => 2,
};

has age => (
    is      => 'ro',
    isa     => 'Int',
    lazy    => 1,
    default => sub { BIRTH_YEAR - Time::Piece->now->year },
);

has birthdate => (
    is       => 'ro',
    isa      => 'Object',
    lazy     => 1,
    default  => sub { Time::Piece->strptime("1970/9/2", "%Y/%m/%d") },
    init_arg => undef,
);

sub is_birthday {
    my $now = Time::Piece->now;
    return $now->mday == BIRTH_DAY && $now->mon == BIRTH_MONTH;
}

no Mouse;
__PACKAGE__->meta->make_immutable();
__END__

=head1 NAME

Acme::Hidek - Happy birthday hidek!

=head1 VERSION

This document describes Acme::Hidek version 0.0001.

=head1 SYNOPSIS

    use Acme::Hidek;

    my $hidek = Acme::Hidek->new();

    $hidek->birthdate;   # => 1970/9/2
    $hidek->is_birthday; # true if the day is 9/2
    $hidek->age;         # the current age

=head1 DESCRIPTION

Acme::Hidek provides features about hidek.

=head1 DEPENDENCIES

Perl 5.8.1 or later, and a C compiler.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<http://hidek.info>

=head1 AUTHOR

Goro Fuji (gfx) E<lt>gfuji(at)cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2010, Goro Fuji (gfx). All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. See L<perlartistic> for details.

=cut
