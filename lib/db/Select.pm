package Select;

use MongoDB;

use Moo;
use namespace::clean;

has db => ( is => 'ro' );
has collection => ( is => 'ro' );
has clothing_name => ( is => 'ro' );
has color => ( is => 'ro' );
has filter => ( is => 'ro' );

sub create
{
    my $self = shift;

    my $client =
        MongoDB->connect();

    my $content =
        $self->db
        . '.'
        . $self->collection;

    return $client->ns( $content );
}

sub retrieve_article
{
    my $self = shift;
    my $collection = shift;

    return $collection->find($self->filter);
}
