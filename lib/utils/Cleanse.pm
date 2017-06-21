package Cleanse;

use Moo;
use namespace::clean;

has string => ( is => 'rw' );

sub understand_string
{
    my $self = shift;
    my $string;

    if ( $self->string =~ m/\+|&/g )
    {
        $string = remove_appending_chars($self->string);
    }
    else
    {
        $string = $self->string;
    }

    return $string;
}

sub remove_appending_chars
{
    my $string = shift;
    $string =~ s/\+|&/ /g;
    return $string;
}

1;
