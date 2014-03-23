#!/bin/env perl

use strict;
use warnings;
use utf8;
use lib qw(../lib);
use feature qw(say);
use Encode;
use WWW::DojinEvent;

my $e = WWW::DojinEvent->new;

my $creation = $e->module('COMIC1');
my $res = $creation->scrape('http://www.comic1.jp/CM8_circle_list2.htm');

for my$circle(@{$res->{circles}}) {
    my $circle_name = Encode::encode_utf8($circle->{circle_name} || '');
    my $pen_name =  Encode::encode_utf8($circle->{pen_name} || '');
    my $url =  Encode::encode_utf8($circle->{circle_url} || '');
    my $space = Encode::encode_utf8($circle->{space} || '');
    say join ',', $circle_name, $pen_name, $url, $space;
}
