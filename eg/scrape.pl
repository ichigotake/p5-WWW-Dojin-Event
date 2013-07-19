#!/bin/env perl

use strict;
use warnings;
use utf8;
use lib qw(../lib);
use WWW::DojinEvent;

my $e = WWW::DojinEvent->new;

my $creation = $e->module('COMIC1');
my $res = $creation->scrape('http://www.comic1.jp/CM7_circle_list.htm');

for my$circle(@{$res->{circles}}) {
    print "$circle->{circle_name}\n";
    print "$circle->{pen_name}\n";
    print "$circle->{circle_url}\n";
}
