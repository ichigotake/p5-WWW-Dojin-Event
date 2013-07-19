# NAME

WWW::DojinEvent - 同人イベントのサークルリストを取得・パースする

# SYNOPSIS

    use WWW::DojinEvent;

    $event = WWW::DojinEvent->new;
    $res = $event->module('COMIC1')->scrape('http://www.comic1.jp/CM7_circle_list.htm');

    for $circle(@{$res->{circles}}) {
        #print "$circle->{circle_name}\n";
        #print "$circle->{pen_name}\n";
        #print "$circle->{circle_url}\n";
    }
    



# DESCRIPTION

同人イベントのサークルリストを、公式WEBサイトの出展サークル一覧から取得します

このモジュールは_WWW::DojinEvent::\*_にある各種同人イベントモジュールのラッパーとして利用します

# MODULES

_WWW::DojinEvent_下にあるモジュールの一覧

メソッド名はsnake\_caseになっています

- COMIC1 [http://www.comic1.jp/](http://www.comic1.jp/)
- Creation [http://www.creation.gr.jp/](http://www.creation.gr.jp/)
- Reitaisai [http://reitaisai.com/](http://reitaisai.com/)

# LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ichigotake <k.wisiiy (a) gmail.com>
