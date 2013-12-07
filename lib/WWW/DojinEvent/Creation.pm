package WWW::DojinEvent::Creation;

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
        process "table tr .list-row1, table tr .list-row2", 'circles[]' => scraper {
                process '//td[1]', 'space' => 'TEXT',
                process '//td[2]', 'circle_name' => 'TEXT',
                process '//td[3]', 'pen_name' => 'TEXT',
                process '//td[4]/a', 'circle_url' => [ '@href', sub {
                    (my $url = $_->as_string) =~ s/^.+\?//;
                    URI->new($url);
                }],
            };
        };
}


1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::Creation - Creation's website parser

=head1 SYNOPSIS

    use WWW::DojinEvent::Creation;

    $event = WWW::DojinEvent::Creation->new;

    $res = $event->scrape('http://www.creation.gr.jp/sc60/circle_list/sn/a1.html');

    for $circle ( @{$res->{circles}} ) {
        print "----\n";
        print "$circle->{space}\n";
        print "$circle->{circle_name}\n";
        print "$circle->{pen_name}\n";
        print "$circle->{circle_url}\n";
    }


=head1 LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

WWW::DojinEvent

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

