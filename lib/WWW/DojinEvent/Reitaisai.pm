package WWW::DojinEvent::Reitaisai;
use 5.008005;
use strict;
use warnings;
use utf8;
use LWP::Simple;
use HTML::TreeBuilder::XPath;
use HTML::Selector::XPath qw(selector_to_xpath);

our $VERSION = "0.01";

sub from_website {
    my ($self) = @_;
    my $res;
    my @circles;
    for (1..8) {
        my $file = "tmp/reitaisai_list_circle$_.html";
        $self->download("http://reitaisai.com/list_circle$_/", $file);
        $res = $self->parse($file);
        push(@circles, @$res);
    }

    return \@circles;
}


sub download {
    my ($class, $url, $tmp) = @_;
    return mirror($url, $tmp);
}

sub parse {
    my ($class, $file) = @_;
    
    my $p = HTML::TreeBuilder::XPath->new;
    $p->parse_file($file);

    my @circles;
    my $i = 0;
    my ($table) = $p->findnodes( selector_to_xpath('#circlelist') );

    for my$tr( $table->findnodes( selector_to_xpath('tr') ) ) {
        my @cells = $tr->look_down( _tag => 'td' );

        next unless @cells;

        my ($a) = $cells[1]->look_down( _tag => 'a' );

        my $circle_url = $a ? $a->attr('href') : '';

        if ($circle_url =~ m/http:\/\/reitaisai\.com\/list_circle/) {
            next;
        }

        push(@circles, {
            space       => Encode::decode_utf8($cells[0]->as_text || ''),
            circle_name => Encode::decode_utf8($cells[1]->as_text || ''),
            pen_name    => Encode::decode_utf8($cells[2]->as_text || ''),
            circle_url  => Encode::decode_utf8($circle_url),
        });
    }

    return \@circles;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::Reitaisai - Reitaisai(博麗神社例大祭)'s website parser

=head1 SYNOPSIS

    use WWW::DojinEvent::Reitaisai;

    $circle_list = WWW::DojinEvent::Reitaisai->from_website('comic1_circle_list.html');


=head1 LICENSE

Copyright (C) ichigotake

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

