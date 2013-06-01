requires 'Class::Accessor::Fast';
requires 'Log::Minimal';
requires 'LWP::UserAgent';
requires 'Sub::Identify';
requires 'Web::Scraper';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


