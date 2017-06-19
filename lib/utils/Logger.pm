package Logger;
use Log::Message::Simple qw[msg error debug carp croak cluck confess];

use utils::LogToDB;
use MongoDB;

use Moo;
use namespace::clean;

has info => ( is => 'rw', isa => sub { msg($_[0]) } );
has debug => ( is => 'rw' );
has error => ( is => 'rw' );
has status => ( is => 'rw' );

sub send_to_db
{
    my $self = shift;

    print $self->info;
}

# sub info
# {
#     my $self = shift;
#
#     return $self;
# }

# sub debug
# {
#     my $self = shift;
#
#     return LogToDB->new(
#         string => $self->debug,
#         status => $self->status )->send_to_db;
# }
#
# sub error
# {
#     my $self = shift;
#
#     return LogToDB->new(
#         string => $self->error,
#         status => $self->status )->send_to_db;
# }
#
# sub send_to_db
# {
#     my $self = shift;
#
#     my $client =
#         MongoDB->connect();
#
#     my $content =
#         $self->db
#         .'.'
#         .$self->collection;
#
#     my $collection = $client->ns($content);
#
#     $collection->insert_one({
#         content => $self->string,
#         status => $self->status
#     });
# }

1;
