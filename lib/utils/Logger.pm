package Logger;

use MongoDB;

use Moo;
use namespace::clean;

has info => ( is => 'rw' );
has debug => ( is => 'rw' );
has error => ( is => 'rw' );
has status => ( is => 'rw' );

# TODO simple Logger to DB on any errors caught;

1;
