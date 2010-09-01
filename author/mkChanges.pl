#!perl -w
use strict;
use Text::Xslate;
use Time::Piece ();

BEGIN { *CORE::GLOBAL::time = sub() { Time::Piece->strptime("2010/9/2", "%Y/%m/%d") } }
use Acme::Hidek;

my $tx = Text::Xslate->new(
    function => { sprintf => sub { sprintf shift, @_ } },
);

my @events;
$events[0]  = "Initial version; released to an unsuspecting world.";
$events[6]  = "Enters to an elementary school.";
$events[20] = "Comes of age.";

my %history = (
    1970 => 'The Unix epoch',
    1987 => 'Perl 1.0 released',
    1988 => 'Perl 2.0 released',
    1989 => 'Perl 3.0 released',
    1991 => 'Perl 4.0 released',
    1994 => 'Perl 5.0 released',
    2000 => 'Perl 5.6.0 released',
    2002 => 'Perl 5.8.0 released',
    2007 => 'Perl 5.10.0 released',
    2010 => 'Perl 5.12.0 released',
);

my $hidek = Acme::Hidek->new();
my %vars = (
    range   => [0 .. 40],
    date    => $hidek->birthdate,
    hidek   => $hidek,
    events  => \@events,
    history => \%history,
);
print $tx->render_string(<<'TX', \%vars);
Revision history for Perl extension Acme::Hidek (Hidek on Perls).

: for $range -> $age {
    : my $year = $date.year + $age;
    : sprintf("%4.01f %d/%d/%d\n", $age, $year, $date.mon, $date.mday);
    Acme::Hidek <: sprintf("%.01f", $age) :> released!
    : if $age % 10 == 0 {
    Heartiest congratulations on the <: $age :>th anniversary!
    : }
    : if defined $events[$age] {
    <: $events[$age] :>
    : }
    : if defined $history[$year] {
    (<: $history[$year] :>)
    : }

: }
TX
