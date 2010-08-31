#!perl -w
use strict;
use Text::Xslate;

my $tx = Text::Xslate->new(
    function => { sprintf => sub { sprintf shift, @_ } },
);

my %vars = (
    range => [0 .. 40],
    year  => 2010,
    month => 9,
    day   => 2,
);
print $tx->render_string(<<'TX', \%vars);
Revision history for Perl extension Acme::Hidek

: for $range.reverse() -> $age {
    : sprintf("%4.01f %d/%d/%d\n", $age, $year - $~age.index, $month, $day);
    Hidek <: sprintf("%.01f", $age) :> released!
    : if $age % 10 == 0 {
    Heartiest congratulations on your <: $age :>th birthday!
    : }

: }
TX
