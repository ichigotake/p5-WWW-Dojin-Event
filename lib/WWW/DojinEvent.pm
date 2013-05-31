package WWW::DojinEvent;

use WWW::DojinEvent::Base qw(-base);
use WWW::DojinEvent::COMIC1;
use WWW::DojinEvent::Creation;
use WWW::DojinEvent::Reitaisai;

our $VERSION = "0.02";

sub scrape_process { }

sub _create_instance {
    my ($self, $class) = @_;
    return $class->new;
}

sub reitaisai {
    return shift->_create_instance('WWW::DojinEvent::Reitaisai');
}

sub comic1 {
    return shift->_create_instance('WWW::DojinEvent::COMIC1');
}

sub creation {
    return shift->_create_instance('WWW::DojinEvent::Creation');
}


1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent - 同人イベントのサークルリストを取得・パースする

=head1 SYNOPSIS

    use WWW::DojinEvent;

    $comic1 = WWW::DojinEvent->new->comic1;
    $res = $e->scrape('http://www.comic1.jp/CM7_circle_list.htm');

    for $circle(@{$res->{circles}}) {
        #print "$circle->{circle_name}\n";
        #print "$circle->{pen_name}\n";
        #print "$circle->{circle_url}\n";
    }
    

=head1 DESCRIPTION

同人イベントのサークルリストをPerlの変数構造へ変換します

I<WWW::DojinEvent::*>にある各種同人イベントモジュールのラッパーとして機能します

=head1 MODULES

I<WWW::DojinEvent>下にあるモジュールの一覧

メソッド名はsnake_caseになっています

=item COMIC1 L<http://www.comic1.jp/>

=item Creation L<http://www.creation.gr.jp/>

=item Reitaisai L<http://reitaisai.com/>

=head1 LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

