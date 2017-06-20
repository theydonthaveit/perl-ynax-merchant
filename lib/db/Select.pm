package Select;

use MongoDB;

use Try::Tiny;
use List::MoreUtils qw/uniq/;
use Data::Dumper;
use Moo;
use namespace::clean;

has db => ( is => 'ro', default => 'YNAP' );
has collection => ( is => 'ro', default => 'CLOTHING' );
has clothing_name => ( is => 'ro' );
has color => ( is => 'ro' );
has filter => ( is => 'ro' );
has db_client => ( is => 'rw' );

sub init_client
{
    my $self = shift;

    my $client =
        MongoDB->connect();

    my $content =
        $self->db
        . '.'
        . $self->collection;

    return $self->db_client($client->ns( $content ));
}

sub retrieve_all_items
{
    my $self = shift;

    return $self->db_client->find({});
}

sub retrieve_oufit_range
{
    my $self = shift;

    return $self->db_client->find($self->filter);
}

sub retrieve_item
{
    my $self = shift;

    return $self->db_client->find($self->filter);
}

sub retrieve_similar
{
    my $self = shift;

    my $cursor =
        try {
            $self->db_client->find({});
        }
        catch {
            # TODO LOG TO LOGGER DB
        };

    my $search_params;
    @{$search_params} = split(' ', $self->filter);

    my $data;

    @{$data} =
        map {
            is_similar($_, $search_params)
        } $cursor->result->all;

    return $data;
}

sub is_similar
{
    my $mongo_result_obj = shift;
    my $search_parmas = shift;

    my $tmp_data;

    foreach my $sk ( @{$search_parmas} )
    {
        while ( my ($k, $v) = each %{$mongo_result_obj} )
        {
            $tmp_data = {
                name => $mongo_result_obj->{name},
                tag => $mongo_result_obj->{tag},
                category => $mongo_result_obj->{category}
            } if $mongo_result_obj->{$k} =~ m/$sk/i;
        }
    }

    no warnings "uninitialized";
    return grep { $_ ne '' } $tmp_data;
}

1;
