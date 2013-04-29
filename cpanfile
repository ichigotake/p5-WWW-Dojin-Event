requires 'JSON';
requires 'LWP::Simple';
requires 'HTML::TreeBuilder';
requires 'HTML::TreeBuilder::XPath';
requires 'HTML::Selector::XPath';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


