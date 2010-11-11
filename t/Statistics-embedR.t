#!perl -T

use warnings;
use strict;
use Statistics::embedR;
use Test::More tests => 4;

my $r = Statistics::embedR->new;

is $r->R("1")->{real}[0], "1", "R() works 1.";
is $r->R('"1"')->{str}[0], "1", "R() works 2.";

my $ary = [3,5,7];
$r->arry2R($ary, "array");
is_deeply $r->R("array")->{int}, $ary, "arry2R() works.";

is $r->sum("c(2,3)")->getvalue->{real}[0], 5, "AUTOLOAD() works.";

# vim: sw=4 ts=4 ft=perl expandtab
