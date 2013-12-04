package WWW::DojinEvent::Comiket;

use strict;
use warnings;
use Encode;
use Encode::Guess qw/utf8 cp932/;
use Text::CSV;

use WWW::DojinEvent;
our $VERSION = $WWW::DojinEvent::VERSION;

sub simple {
    my ($self, $checklist_file) = @_;

    my $catalog = __PACKAGE__->parse($checklist_file);

    my @circles;
    for my$circle ( @{$catalog->{circle}} ) {
        push(@circles, {
            id => $circle->{id},
            wday => $circle->{wday},
            space => $circle->{map}.$circle->{block_id}.$circle->{space_no},
            circle_name => $circle->{circle_name},
            circle_name_kana => $circle->{circle_name_kana},
            pen_name => $circle->{pen_name},
            url => $circle->{url},
            description => $circle->{description},
            circlems => $circle->{circlems}
        });
    }

    return \@circles;
}

sub parse {
    my ($self, $checklist_file) = @_;
    my %checklist = (
        header => {},
        label  => {},
        circle => [],
    );

    my $csv = Text::CSV->new ( { binary => 1 } ) or die "Cannot use CSV: ".Text::CSV->error_diag();

    open my$fh, '<', $checklist_file or die "Cannot open file. $@: '$checklist_file'";
    while ( my $row = $csv->getline( $fh ) ) {
        my $col_count = scalar(@$row);
        for (my$i=0; $i<$col_count; ++$i) {
            $row->[$_] = Encode::decode('Guess', $row->[$_]);
        }

        if ($row->[0] eq 'Header') {

            my $comiket_name = $row->[2];
            $comiket_name =~ m/(\d+)$/;
            my $comiket_no = $1;

            $checklist{header} = {
                name => $row->[1],
                encode => $row->[3],
                comiket_name => $comiket_name,
                comiket_no   => $comiket_no,
            };

        }
        elsif ($row->[0] eq 'Color') {

            my $display_color = $row->[2];
            $display_color =~ s/^\#//g;

            my $print_color = $row->[3];
            $print_color =~ s/^\#//g;

            $checklist{label}{$row->[1]} = {
                label_name => $row->[3] || '',
                display_color => $display_color,
                print_color   => $print_color,
            };

        }
        elsif ($row->[0] eq 'Circle') {

            push(@{$checklist{circle}}, {
                    id    => $row->[1],
                    label => $row->[2],
                    wday  => $row->[5],
                    map   => $row->[6],
                    genre_id => $row->[9],
                    block_id => $row->[7],
                    space_no => $row->[8],
                    circle_name  => $row->[10],
                    circle_name_kana => $row->[11],
                    pen_name    => $row->[12],
                    description => $row->[16],
                    url => $row->[14],
                    mail_addr => $row->[15],
                    sns_accounts => {
                        circlems  => $row->[23],
                        circlems_rss  => $row->[24],
                    },
                });
        }
    }
    $csv->eof or $csv->error_diag();
    close $fh;

    return \%checklist;
}


1;
__DATA__

=encoding utf-8

=head1 NAME

WWW::DojinEvent::Comiket - コミックマーケットのチェックリストをパースする

=head1 SYNOPSIS

    use WWW::DojinEvent::Comiket;

    my $circlelist = WWW::DojinEvent::Comiket->simple( '/path/to/cdrom_checklist.csv' );

    my $checklist = WWW::DojinEvent::Comiket->parse( '/path/to/cdrom_checklist.csv' );

=head1 METHODS

=head2 simple( $path_to_checklist )

CD-ROM版カタログで出力したチェックリストをPerlのデータ構造に変換します。

    ### data structure
    # $circlelist = [
    #   {
    #       'wday' => '土', // kanji week day
    #       'circlems' => 'http://webcatalog.circle.ms/circle/00/AAAAAA/',
    #       'description' => 'Circle description',
    #       'circle_name' => 'Circle name',
    #       'space' => '東シ44',
    #       'url' => 'http://mycircle.example.com/',
    #       'id' => '100000',
    #       'pen_name' => 'Pen name',
    #       'circle_name_kana' => 'サークルネーム' // japanese kana
    #   },
    #   ...
    # ];


=head2 parse( $path_to_checklist )

CD-ROM版カタログで出力したチェックリストをB<そのまま>Perlのデータ構造に変換します。

    ### data structure
    # $checklist = {
    #        header => {
    #            name => 'ComicMarketCD-ROMCatalog',
    #            comiket_name => 'コミックマーケット82',
    #            comiket_no => 82,
    #            encode => 'Shift_JIS',
    #        },
    #        label => {
    #            1 => {
    #                label_name    => '絶対に欲しい',
    #                display_color => '4a94ff', # rgb hex
    #                print_color   => '4a94ff', # rgb hex
    #            },
    #            2 => [ label_name => '出来れば欲しい', .... ],
    #            3 => [ label_name => '午後でも安心', .... ],
    #            4 => [ label_name => '余裕があったら欲しい', .... ],
    #            ...
    #        },
    #        circle => [
    #            {
    #                id => 100000,
    #                wday => '金',
    #                block_id => 'U',
    #                space_no => '10',
    #                genre_id => ,
    #                circle_name  => 'Circle name',
    #                circle_name_kana => 'サークルネーム', # kana
    #                pen_name => 'にわとりぼうや(非実在にわとり)',
    #                url => 'http://mycircle.example.com/',
    #                description  => '',
    #                circlems => 'http://webcatalog.circle.ms/circle/00/AAAAAA/',
    #                circlems_rss => '',
    #            },
    #            ...
    #        ],
    # };

=head1 TODO

https://github.com/ichigotake/p5-WWW-DojinEvent/issues

=head1 AUTHOR

ichigotake

=cut

