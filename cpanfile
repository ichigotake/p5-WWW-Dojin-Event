requires 'Class::Accessor::Fast';
requires 'Encode::Guess';
requires 'LWP::UserAgent';
requires 'Module::Load';
requires 'Text::CSV';
requires 'Web::Scraper';
requires 'Module::Find';
recommends 'Text::CSV_XS';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


