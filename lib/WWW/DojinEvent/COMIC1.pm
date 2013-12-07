package WWW::DojinEvent::COMIC1;

use strict;
use warnings;
use utf8;
use parent qw(WWW::DojinEvent::Scraper);
use Web::Scraper;

use WWW::DojinEvent;
our $VERSION = $WWW::DojinEvent::VERSION;

sub fields { return qw(circle_name circle_name_kana circle_url) }

sub scrape_process {
    return scraper {
        process "table tr", 'circles[]' => scraper {
                process '//td[1]', 'circle_name' => 'TEXT',
                process '//td[1]/a', 'circle_url' => '@href',
                process '//td[2]', 'pen_name' => 'TEXT',
            };
        };
}


1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::COMIC1 - COMIC1's website parser

=head1 SYNOPSIS

    use WWW::DojinEvent::COMIC1;

    $event = WWW::DojinEvent::COMIC1->new;

    $res = $event->scrape("http://www.comic1.jp/CM7_circle_list.htm");

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

