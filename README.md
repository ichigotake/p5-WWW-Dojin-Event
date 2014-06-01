# NAME

WWW::DojinEvent - "Dojin" event data handler

# SYNOPSIS

    use WWW::DojinEvent;

    # Get including "dojin event" modules.
    $modules = WWW::DojinEvent::modules;

    for $module_name( @$modules ) {
        print $module_name;
    }
    



# DESCRIPTION

This namespace is "Dojin" event data handler modules.

And this class is hub document.

# METHOD

## modules

Get including "dojin event" modules.

- [COMIC1](http://www.comic1.jp)
 
- [Comiket1](http://www.comiket.co.jp)
 
- [Creation](http://www.creation.gr.jp)
- [KettoCom](http://ketto.com)
- [Reitaisai](http://reitaisai.com)

# LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ichigotake <k.wisiiy (a) gmail.com>

# SEE ALSO

Return the _WWW::DojinEvent::modules_ classes.
