# NAME

WWW::DojinEvent - 同人イベントのサークルリストを取得・パースする

# SYNOPSIS

    use WWW::DojinEvent;

    $circle_list = WWW::DojinEvent->from_website('COMIC1', '/path/to/circle_list_file', '/tmp/dir');

    # or

    WWW::DojinEvent->download('http://www.comic1.jp/CM7_circle_list2.htm', 'comic1_circle_list.html');
    $circle_list = WWW::DojinEvent->parse('COMIC1', 'comic1_circle_list.html');

# DESCRIPTION

同人イベントのサークルリストをPerlの変数構造へ変換します

_WWW::DojinEvent::\*_にある各種同人イベントモジュールのラッパーとして機能します

# MODULES

_WWW::DojinEvent_下にあるモジュールの一覧

- COMIC1 [http://www.comic1.jp/](http://www.comic1.jp/)
- Reitaisai [http://reitaisai.com/](http://reitaisai.com/)

# LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ichigotake <k.wisiiy (a) gmail.com>
