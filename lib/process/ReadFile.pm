package ReadFile;

use Getopt::Long;
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
            name => remove_whitespace($_->[0]),
            category => remove_whitespace($_->[1])
        )->insert;
    }

    return 1;
}

sub remove_whitespace
{
    my $data = shift;
    $data =~ s/^\s+|\s+$//g;
    return $data
}

1;
