use strict;
use Test::More;
use WWW::DojinEvent;

use_ok $_ for qw(
    WWW::DojinEvent
    WWW::DojinEvent::COMIC1
    WWW::DojinEvent::Comiket
    WWW::DojinEvent::Creation
    WWW::DojinEvent::KettoCom
    WWW::DojinEvent::Reitaisai
    WWW::DojinEvent::Scraper
);

done_testing;

