package WWW::DojinEvent;
use 5.008005;
use strict;
use warnings;
use utf8;
use File::Basename;

our $VERSION = "0.01";

sub from_website {
    my ($self, $event_name, $url, $tmp_dir) = @_;
    
    my $event_class = $self->_event_class($event_name);

    eval qq{ use $event_class ; };

    $event_class->from_website($url, $tmp_dir);
}

sub download {
    my ($self, $event_name, $url, $output_file) = @_;
    
    my $event_class = $self->_event_class($event_name);

    eval qq{ use $event_class ; };

    $event_class->download($url, $output_file);
}

sub parse {
    my ($self, $event_name, $parse_file) = @_;

    my $event_class = $self->_event_class($event_name);
    eval qq{ use $event_class ; };

    return $event_class->parse($parse_file);
}

sub _event_class {
    my ($self, $event_name) = @_;
    return 'WWW::DojinEvent::'.$event_name ;
}
1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent - 同人イベントのサークルリストを取得・パースする

=head1 SYNOPSIS

    use WWW::DojinEvent;

    $circle_list = WWW::DojinEvent->from_website('COMIC1', '/path/to/circle_list_file', '/tmp/dir');

    # or

    WWW::DojinEvent->download('http://www.comic1.jp/CM7_circle_list2.htm', 'comic1_circle_list.html');
    $circle_list = WWW::DojinEvent->parse('COMIC1', 'comic1_circle_list.html');

=head1 DESCRIPTION

同人イベントのサークルリストをPerlの変数構造へ変換します

I<WWW::DojinEvent::*>にある各種同人イベントモジュールのラッパーとして機能します

=head1 MODULES

I<WWW::DojinEvent>下にあるモジュールの一覧

=item COMIC1 L<http://www.comic1.jp/>

=item Reitaisai L<http://reitaisai.com/>

=head1 LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

