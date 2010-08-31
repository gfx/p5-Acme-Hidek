#!perl -w

use strict;
use Test::More;

use Acme::Hidek;

my $hidek = Acme::Hidek->new();

is $hidek->birthdate->year,  1970;
is $hidek->birthdate->mon,      9;
is $hidek->birthdate->mday,     1;

done_testing;
