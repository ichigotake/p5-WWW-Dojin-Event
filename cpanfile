requires 'Class::Accessor::Fast';
requires 'LWP::UserAgent';
requires 'Module::Load';
requires 'Web::Scraper';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


