use strict;
use warnings;
use Test::More;
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

ok(eq_array($modules, $expected));

done_testing;

