package Insert;

use MongoDB;
use Moo;
use namespace::clean;

has db => ( is => 'ro', default => 'YNAP' );
has collection => ( is => 'ro', default => 'CLOTHING' );
has name => ( is => 'ro' );
has category => ( is => 'ro' );
has tag => ( is => 'ro' );

# TODO LOG AT THE END

sub insert
{
    my $self = shift;

    my $client =
        MongoDB->connect();

    my $content =
        $self->db
        .'.'
        .$self->collection;

    my $collection = $client->ns($content);

    $collection->insert_one({
        name => $self->name,
        category => $self->category,
        tag => $self->tag
    });
}

1;
