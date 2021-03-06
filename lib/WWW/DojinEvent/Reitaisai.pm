package WWW::DojinEvent::Reitaisai;

use strict;
use warnings;
use utf8;
use parent qw(WWW::DojinEvent::Scraper);
use Web::Scraper;

use WWW::DojinEvent;
our $VERSION = $WWW::DojinEvent::VERSION;

sub fields { return qw(space circle_name circle_url pen_name) }

sub scrape_process {
    return scraper {
        process "#circlelist tr", 'circles[]' => scraper {
                process '//td[1]', 'space' => 'TEXT',
                process '//td[2]', 'circle_name' => 'TEXT',
                process '//td[2]/a', 'circle_url' => '@href',
                process '//td[3]', 'pen_name' => 'TEXT',
            };
        };
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::Reitaisai - Reitaisai(博麗神社例大祭)'s website parser

=head1 SYNOPSIS

    use WWW::DojinEvent::Reitaisai;

    my $event = WWW::DojinEvent::Reitaisai->new;

    @circles;
    for $i (1..8) {
        $res = $event->scrape("http://reitaisai.com/list_circle$i/");
        @circles = (@circles, @{$res->{circles}});
    }

    for $circle ( @{$res->{circles}} ) {
        print "----\n";
        print "$circle->{space}\n";
        print "$circle->{circle_name}\n";
        print "$circle->{pen_name}\n";
        print "$circle->{circle_url}\n";
    }

=head1 SEE ALSO

WWW::DojinEvent::Scraper

=head1 LICENSE

Copyright (C) ichigotake

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

