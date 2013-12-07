package WWW::DojinEvent::KettoCom;
use 5.008005;
use strict;
use warnings;
use utf8;
use Encode;
use Text::CSV;

use WWW::DojinEvent;
our $VERSION = $WWW::DojinEvent::VERSION;


sub parse {
    my ($class, $file) = @_;

    my $csv = Text::CSV->new( { binary => 1 } ) or die "Cannot use CSV: $@";

    my @circles;

    open my$fh, '<', $file or die "Cannot open file. $@: $file";
    while ( my $row = $csv->getline($fh) ) {

        my $r18;
        my $genre = $row->[6];
        if ($genre =~ m/^18/) {
            $genre =~ s/^18//;
            $r18 = 1;
        }
        else {
            $r18 = 0;
        }

        my %sns_accounts;
        if ($row->[7] =~ m/twitter\.com\/(\w+)/) {
            $sns_accounts{twitter} = $1;
        }
        if ($row->[8] =~ m/pixiv.net\/member\.php\?id=(\w+)/) {
            $sns_accounts{pixiv} = $1;
        }
        elsif ($row->[8] =~ m/nicovideo\.jp\/user\/(\w+)/) {
            $sns_accounts{nicovideo} = $1;
        }

        push(@circles, {
            circle_name_kana => $row->[0],
            circle_name => $row->[1],
            pen_name_kana => $row->[2],
            pen_name => $row->[3],
            space => $row->[4],
            site_url => $row->[5],
            genre => $genre,
            r18 => $r18,
            sns_accounts => \%sns_accounts,
        });
    }

    return \@circles;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::KettoCom - ケットコムの出展サークルデータパーサ

=head1 SYNOPSIS

    use WWW::DojinEvent::KettoCom;

    $circles = WWW::DojinEvent::KettoCom->simple('circlelist.csv');

    # or

    $circles = WWW::DojinEvent::KettoCom->parse('circlelist.csv');

=head1 DESCRIPTION

「みみけん」(L<http://ketto.com/mimiken/ken.cgi>) に登録されているイベントのエクセル用リストをPerlの変数構造に変換します

=head1 SEE ALSO

WWW::DojinEvent

=head1 LICENSE

Copyright (C) Takayuki Otake.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takayuki Otake E<lt>k.wisiiy@gmail.comE<gt>

=cut

