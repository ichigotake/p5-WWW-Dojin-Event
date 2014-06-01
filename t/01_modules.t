use strict;
use warnings;
use Test::More;
use Array::Utils qw/ array_diff /;
use WWW::DojinEvent;

my $expected = [
    'WWW::DojinEvent::COMIC1',
    'WWW::DojinEvent::Comiket',
    'WWW::DojinEvent::Creation',
    'WWW::DojinEvent::KettoCom',
    'WWW::DojinEvent::Reitaisai',
];

my $modules = WWW::DojinEvent->modules;

isa_ok($modules, 'ARRAY');

ok(!array_diff(@$modules, @$expected));

done_testing;

