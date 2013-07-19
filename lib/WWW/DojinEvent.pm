package WWW::DojinEvent;

use strict;
use warnings;
use utf8;
use Module::Load;

our $VERSION = "0.08";

sub new {
    my ($class) = @_;
    bless {}, $class;
}

sub module {
    my ($self, $name) = @_;
    warn $name;
    my $class = "WWW::DojinEvent::$name";
    Module::Load::load($class);
    $self->{"module#$name"} //= do {
        $class->new;
    };
}


1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent - 同人イベントのサークルリストを取得・パースする

=head1 SYNOPSIS

    use WWW::DojinEvent;

    $event = WWW::DojinEvent->new;
    $res = $event->module('COMIC1')->scrape('http://www.comic1.jp/CM7_circle_list.htm');

    for $circle(@{$res->{circles}}) {
        #print "$circle->{circle_name}\n";
        #print "$circle->{pen_name}\n";
        #print "$circle->{circle_url}\n";
    }
    

=head1 DESCRIPTION

同人イベントのサークルリストを、公式WEBサイトの出展サークル一覧から取得します

このモジュールはI<WWW::DojinEvent::*>にある各種同人イベントモジュールのラッパーとして利用します

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

