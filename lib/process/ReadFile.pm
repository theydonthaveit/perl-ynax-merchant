package ReadFile;

use Text::CSV::Simple;

use db::Insert;

use Moo;
use namespace::clean;
# use utils::Logger;

# THIS IS A PROCESS A NEED NOT BE DONE IN OOP

# my $LOG = Logger->new();

has file => ( is => 'ro' );

sub get_data
{
    my $self = shift;

    my $parser = Text::CSV::Simple->new({
        decode_utf8 => 1,
        binary => 1,
        sep_char => ","
    });

    my $data;
    @{$data} = $parser->read_file($self->file);

    return bless {
        completed => 1,
        declined => 0,
        response => $data
    }
}

sub input_to_db
{
    my $self = shift;

    unless ( $self->{completed} )
    {
        return 1;
    }

    foreach ( @{$self->{response}} )
    {
        next if $_->[0] =~ m/name/;
        Insert->new(
            name => $self->remove_whitespace($_->[0]),
            category => $self->remove_whitespace($_->[1]),
            tag => $self->tag_clothes($_->[0])
        )->insert;
    }

    return 1;
}

sub remove_whitespace
{
    my $self = shift;
    my $data = shift;

    $data =~ s/^\s+|\s+$//g;
    return $data;
}

sub tag_clothes
{
    my $self = shift;
    my $item = shift;
    my $tag_for_item;

    my $name_of_items;
    @{$name_of_items} = split( ' ', $item );

    $tag_for_item = $name_of_items->[0];

    return $tag_for_item;
}

1;
