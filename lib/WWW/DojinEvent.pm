package WWW::DojinEvent;

use strict;
use warnings;
use Module::Find qw/findsubmod/;

our $VERSION = "0.09";

sub modules {
    my $event_modules = [];

    for my $sub_module( findsubmod WWW::DojinEvent ) {
        if ($sub_module ne 'WWW::DojinEvent::Scraper') {
            push @$event_modules, $sub_module;
        }
    }

    return $event_modules;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent - "Dojin" event data handler

=head1 SYNOPSIS

    use WWW::DojinEvent;

    # Get including "dojin event" modules.
    $modules = WWW::DojinEvent::modules;

    for $module_name( @$modules ) {
        print $module_name;
    }
    

=head1 DESCRIPTION

This namespace is "Dojin" event data handler modules.

And this class is hub document.

=head1 METHOD

=head2 modules

Get including "dojin event" modules.

=over 4

=item L<COMIC1|http://www.comic1.jp>
 
=item L<Comiket1|http://www.comiket.co.jp>
 
=item L<Creation|http://www.creation.gr.jp>

=item L<KettoCom|http://ketto.com>

=item L<Reitaisai|http://reitaisai.com>

=back

=head1 LICENSE

Copyright (C) ichigotake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ichigotake E<lt>k.wisiiy (a) gmail.comE<gt>

=head1 SEE ALSO

Return the I<WWW::DojinEvent::modules> classes.

=cut

