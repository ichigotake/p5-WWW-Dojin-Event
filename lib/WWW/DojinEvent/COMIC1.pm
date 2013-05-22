package WWW::DojinEvent::COMIC1;
use 5.008005;
use strict;
use warnings;
use utf8;
use LWP::Simple;
use HTML::TreeBuilder;

our $VERSION = "0.01";


sub from_website{
    my ($self, $url, $output_file) = @_;
    $output_file = "/tmp/" . basename($url);

    $self->download($url, $output_file);

    return $self->parse($output_file);
}

sub download {
    my ($class, $url, $tmp) = @_;
    return mirror($url, $tmp);
}

sub parse {
    my ($class, $file) = @_;
    
    my $p = HTML::TreeBuilder->new;
    $p->parse_file($file);

    my %circles;
    my $i = 0;
    for my$tr( $p->look_down( _tag => 'tr')) {
        my @cells = $tr->look_down( _tag => 'td' );

        next unless @cells;

        my ($a) = $cells[0]->look_down(_tag => 'a');;

        my $circle_url = $a ? $a->attr('href') : '';

        ++$i;
        $circles{$i} = {
            id => $i,
            circle_name => Encode::decode_utf8($cells[0]->as_text || ''),
            circle_name_kana => Encode::decode_utf8($cells[1]->as_text || ''),
            circle_url => $circle_url,
        };
    }

    return \%circles;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::COMIC1 - COMIC1の出展サークルを取得する

=head1 SYNOPSIS

    use WWW::DojinEvent::COMIC1;

    # download circle list from official site
    WWW::DojinEvent::COMIC1('http://www.comic1.jp/CM7_circle_list2.htm', 'tmp/comic1_circle_list.html');
    $circle_list = WWW::DojinEvent::COMIC1->parse('comic1_circle_list.html');

=head1 LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

WWW::DojinEvent

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

