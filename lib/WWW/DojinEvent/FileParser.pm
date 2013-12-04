package WWW::DojinEvent::FileParser;
use 5.008005;
use strict;
use warnings;
use utf8;
use File::Basename;

use WWW::DojinEvent;
our $VERSION = $WWW::DojinEvent::VERSION;

sub simple {
    my ($self, $event_name, $file) = @_;

    my $event_class = $self->_load_event_class($event_name);

    return $event_class->simple($file);
}

sub parse {
    my ($self, $event_name, $file) = @_;

    my $event_class = $self->_load_event_class($event_name);

    return $event_class->parse($file);
}

sub _load_event_class {
    my ($self, $event_name) = @_;

    my $class = 'Data::DojinEvent::'.$event_name ;
    eval qq{ use $class ; };

    return $class;
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::DojinEvent - 同人イベントのサークルリストをパースする

=head1 SYNOPSIS

    use Data::DojinEvent;

    $checklist = Data::DojinEvent->simple('Comiket', '/path/to/checklist.csv');

    # or

    $circles = Data::DojinEvent->parse('KettoCom', 'circlelist.csv');

=head1 DESCRIPTION

同人イベントのサークルリストをPerlの変数構造へ変換します

I<Data::DojinEvent::*>にある各種同人イベントモジュールのラッパーとして機能します

=head1 MODULES

I<Data::DojinEvent>下にあるモジュールの一覧

=item Comiket L<http://www.comiket.co.jp/>

WEBカタログ・CM-ROM版からエクスポートされるチェックリストをパースします

=item KettoCom L<http://ketto.com>

「みみけん」(L<http://ketto.com/mimiken/ken.cgi>) のエクセル用リストをパースします

=head1 SEE ALSO

=item WWW::DojinEvent - L<https://github.com/ichigotake/p5-WWW-DojinEvent>

公式でサークルデータが配布されていないイベントのサークルリストを、公式WEBサイトのサークル一覧をパースして取得する

=item Data::DojinEvent::Comiket Data::DojinEvent::KettoCom

=head1 LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=cut

=head1 AUTHOR

ichigotake

