package WWW::DojinEvent::Base;

use strict;
use warnings;
use utf8;
use URI;
use Web::Scraper;
use LWP::UserAgent;
use parent qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors(qw( tmp_dir scrape_process web_scraper ));


sub fields { die "this is abstract method: fields" }
sub scrape_process { die "this is abstract method: scrape_process" }

sub new {
    my ($class, @args) = @_;
    my $self = bless { @args }, $class;

    $self->web_scraper($self->scrape_process);

    return $self;
}

sub scrape {
    my ($self, $url) = @_;

    my $res = LWP::UserAgent->new->head($url);
    unless ($res->is_success) {
        warn sprintf("Couldn't access url. code: %s, url: %s", $res->code, $url);
        return ;
    }
    return $self->web_scraper->scrape(URI->new($url));
}

1;
__DATA__

=head1 NAME

WWW::DojinEvent::Base - Base class for all WWW:::DojinEvent modules

=head1 SYNOPSIS

    {
        package WWW::DojinEvent::SomeEvent;

        use WWW::DojinEvent::Base qw(-base);

        sub scraper_process {
            return scraper {
                # Web::Scraper's "scraper" block.
                # see also: Web::Scraper
                return process "#circlelist tr", 'circles[]' => scraper {
                    process '//td[1]', 'space' => 'TEXT',
                    process '//td[2]', 'circle_name' => 'TEXT',
                    process '//td[2]/a', 'circle_url' => '@href',
                    process '//td[3]', 'pen_name' => 'TEXT',
                };
            };

        1;
    }

    use WWW::DojinEvent::SomeEvent;

    my $e = WWW::DojinEvent::SomeEvent->new;
    my $res = $e->scrape('http://some-event.com/circle_list.html');

    for my$circle ( @{$res->{circles}} ) {
        print "----\n";
        print "$circle->{space}\n";
        print "$circle->{circle_name}\n";
        print "$circle->{pen_name}\n";
        print "$circle->{circle_url}\n";
    }

=head1 SEE ALSO

Web::Scraper

=head1 AUTHOR

ichigotake

